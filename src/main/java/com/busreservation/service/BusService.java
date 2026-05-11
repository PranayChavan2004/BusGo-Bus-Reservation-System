package com.busreservation.service;

import com.busreservation.dto.*;
import com.busreservation.model.*;
import com.busreservation.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional
public class BusService {

    @Autowired private BusRepository busRepo;
    @Autowired private BusRouteRepository routeRepo;
    @Autowired private TripRepository tripRepo;
    @Autowired private SeatBookingRepository bookingRepo;
    @Autowired private CustomerRepository customerRepo;

    public ApiResponse registerBus(BusRegistrationRequest req) {
        if (busRepo.existsByNumberPlate(req.getNumberPlate().toUpperCase())) {
            return new ApiResponse(false, "Number plate " + req.getNumberPlate() + " already registered.");
        }
        try {
            Bus bus = new Bus();
            bus.setBusName(req.getBusName());
            bus.setOwnerName(req.getOwnerName());
            bus.setNumberPlate(req.getNumberPlate().toUpperCase());
            bus.setMobileNo(req.getMobileNo());
            bus.setEmailId(req.getEmailId());
            bus.setTotalSeats(req.getTotalSeats());
            bus.setTotalRows(req.getTotalRows());
            bus.setLeftSeats(req.getLeftSeats());
            bus.setRightSeats(req.getRightSeats());
            bus.setLastRowSeats(req.getLastRowSeats());
            bus.setEndpoint1(cap(req.getEndpoint1()));
            bus.setEndpoint2(cap(req.getEndpoint2()));
            bus.setEstHours(req.getEstHours());
            bus.setEstMinutes(req.getEstMinutes());
            bus = busRepo.save(bus);
            int order = 1;
            for (String stop : req.getStops()) {
                BusRoute route = new BusRoute();
                route.setBusId(bus.getId());
                route.setLocationName(cap(stop));
                route.setOrderId(order++);
                routeRepo.save(route);
            }
            return new ApiResponse(true, "Bus '" + bus.getBusName() + "' registered successfully!", bus.getId());
        } catch (Exception e) {
            return new ApiResponse(false, "Registration failed: " + e.getMessage());
        }
    }

    public ApiResponse checkNumberPlate(String plate) {
        if (busRepo.existsByNumberPlate(plate.toUpperCase()))
            return new ApiResponse(false, "Number plate already exists.");
        return new ApiResponse(true, "Number plate is available.");
    }

    public Map<String, Object> getBusDetails(String numberPlate) {
        Optional<Bus> busOpt = busRepo.findByNumberPlate(numberPlate.toUpperCase());
        if (busOpt.isEmpty()) return null;
        Bus bus = busOpt.get();
        List<BusRoute> routes = routeRepo.findByBusIdOrderByOrderIdAsc(bus.getId());
        List<Trip> scheduled = tripRepo.findByBusIdAndStatusNotOrderByDepartureTimeAsc(bus.getId(), "COMPLETED");
        List<Trip> completed = tripRepo.findByBusIdAndStatusOrderByDepartureTimeAsc(bus.getId(), "COMPLETED");
        Map<String, Object> result = new HashMap<>();
        result.put("bus", bus);
        result.put("routes", routes);
        result.put("scheduledTrips", scheduled);
        result.put("completedTrips", completed);
        return result;
    }

    public ApiResponse scheduleTrip(TripScheduleRequest req) {
        Optional<Bus> busOpt = busRepo.findById(req.getBusId());
        if (busOpt.isEmpty()) return new ApiResponse(false, "Bus not found.");
        Bus bus = busOpt.get();
        List<Trip> overlapping = tripRepo.findOverlapping(bus.getId(), req.getDepartureTime(), req.getArrivalTime());
        if (!overlapping.isEmpty())
            return new ApiResponse(false, "Bus already has a trip that overlaps this time slot.");
        Trip trip = new Trip();
        trip.setBusId(bus.getId());
        trip.setDirection(req.getDirection());
        trip.setDepartureTime(req.getDepartureTime());
        trip.setArrivalTime(req.getArrivalTime());
        trip.setStatus("SCHEDULED");
        trip = tripRepo.save(trip);

        List<BusRoute> routes = routeRepo.findByBusIdOrderByOrderIdAsc(bus.getId());
        int numStops = routes.size();
        for (int seat = 1; seat <= bus.getTotalSeats(); seat++) {
            for (int s = 0; s < numStops - 1; s++) {
                SeatBooking sb = new SeatBooking();
                sb.setTripId(trip.getId());
                sb.setBusId(bus.getId());
                sb.setSeatNo(seat);
                sb.setFromOrder(routes.get(s).getOrderId());
                sb.setToOrder(routes.get(s + 1).getOrderId());
                sb.setBooked(false);
                bookingRepo.save(sb);
            }
        }
        return new ApiResponse(true, "Trip scheduled successfully!", trip.getId());
    }

    public List<Map<String, Object>> searchBuses(SearchRequest req) {
        String from = cap(req.getFromLocation());
        String to = cap(req.getToLocation());
        String date = req.getTravelDate(); // yyyy-MM-dd
        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

        List<Trip> trips = tripRepo.findAvailableTrips(date, now);
        List<Map<String, Object>> results = new ArrayList<>();

        for (Trip trip : trips) {
            Bus bus = busRepo.findById(trip.getBusId()).orElse(null);
            if (bus == null) continue;
            BusRoute fromRoute = routeRepo.findByBusIdAndLocationNameIgnoreCase(bus.getId(), from);
            BusRoute toRoute = routeRepo.findByBusIdAndLocationNameIgnoreCase(bus.getId(), to);
            if (fromRoute == null || toRoute == null) continue;
            boolean valid = trip.getDirection() == 0
                ? fromRoute.getOrderId() < toRoute.getOrderId()
                : fromRoute.getOrderId() > toRoute.getOrderId();
            if (!valid) continue;

            int fromOrd = Math.min(fromRoute.getOrderId(), toRoute.getOrderId());
            int toOrd = Math.max(fromRoute.getOrderId(), toRoute.getOrderId());
            List<Integer> occupied = bookingRepo.findOccupiedSeats(trip.getId(), fromOrd, toOrd);
            int available = bus.getTotalSeats() - occupied.size();

            Map<String, Object> item = new HashMap<>();
            item.put("trip", trip);
            item.put("bus", bus);
            item.put("fromLocation", from);
            item.put("toLocation", to);
            item.put("fromOrder", fromOrd);
            item.put("toOrder", toOrd);
            item.put("availableSeats", available);
            item.put("depTime", trip.getDepartureTime().length() >= 16 ? trip.getDepartureTime().substring(11, 16) : trip.getDepartureTime());
            item.put("arrTime", trip.getArrivalTime().length() >= 16 ? trip.getArrivalTime().substring(11, 16) : trip.getArrivalTime());
            results.add(item);
        }
        results.sort(Comparator.comparing(m -> (String) m.get("depTime")));
        return results;
    }

    public Map<String, Object> getSeatLayout(SeatRequest req) {
        Bus bus = busRepo.findById(req.getBusId()).orElse(null);
        Trip trip = tripRepo.findById(req.getTripId()).orElse(null);
        if (bus == null || trip == null) return null;
        BusRoute fromRoute = routeRepo.findByBusIdAndLocationNameIgnoreCase(bus.getId(), cap(req.getFromLocation()));
        BusRoute toRoute = routeRepo.findByBusIdAndLocationNameIgnoreCase(bus.getId(), cap(req.getToLocation()));
        if (fromRoute == null || toRoute == null) return null;
        int fromOrd = Math.min(fromRoute.getOrderId(), toRoute.getOrderId());
        int toOrd = Math.max(fromRoute.getOrderId(), toRoute.getOrderId());
        List<Integer> occupied = bookingRepo.findOccupiedSeats(trip.getId(), fromOrd, toOrd);

        List<Map<String, Object>> seats = new ArrayList<>();
        for (int i = 1; i <= bus.getTotalSeats(); i++) {
            Map<String, Object> s = new HashMap<>();
            s.put("seatNo", i);
            s.put("occupied", occupied.contains(i));
            seats.add(s);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("seats", seats);
        result.put("bus", bus);
        result.put("trip", trip);
        result.put("fromOrder", fromOrd);
        result.put("toOrder", toOrd);
        result.put("fromLocation", cap(req.getFromLocation()));
        result.put("toLocation", cap(req.getToLocation()));
        return result;
    }

    public ApiResponse bookSeats(BookingRequest req) {
        Bus bus = busRepo.findById(req.getBusId()).orElse(null);
        Trip trip = tripRepo.findById(req.getTripId()).orElse(null);
        if (bus == null || trip == null) return new ApiResponse(false, "Invalid trip or bus.");
        if (!"SCHEDULED".equals(trip.getStatus())) return new ApiResponse(false, "This trip is no longer available.");
        if (req.getSelectedSeats() == null || req.getSelectedSeats().isEmpty())
            return new ApiResponse(false, "Please select at least one seat.");

        int fromOrd = req.getFromOrder();
        int toOrd = req.getToOrder();
        if (fromOrd == 0) fromOrd = getOrder(bus.getId(), req.getFromLocation());
        if (toOrd == 0) toOrd = getOrder(bus.getId(), req.getToLocation());
        if (fromOrd < 0 || toOrd < 0) return new ApiResponse(false, "Invalid route locations.");

        int minOrd = Math.min(fromOrd, toOrd);
        int maxOrd = Math.max(fromOrd, toOrd);
        List<Integer> occupied = bookingRepo.findOccupiedSeats(trip.getId(), minOrd, maxOrd);
        List<Integer> taken = new ArrayList<>();
        for (int seat : req.getSelectedSeats()) if (occupied.contains(seat)) taken.add(seat);
        if (!taken.isEmpty()) return new ApiResponse(false, "Seats " + taken + " are already booked. Please choose others.");

        Customer customer = customerRepo.findByMobileNo(req.getMobileNo()).orElse(null);
        if (customer == null) {
            customer = new Customer();
            customer.setName(req.getPassengerName());
            customer.setMobileNo(req.getMobileNo());
            customer.setEmailId(req.getEmailId());
            customer = customerRepo.save(customer);
        }

        for (int seat : req.getSelectedSeats()) {
            List<SeatBooking> slots = bookingRepo.findByTripIdAndSeatNo(trip.getId(), seat);
            for (SeatBooking slot : slots) {
                if (slot.getFromOrder() >= minOrd && slot.getToOrder() <= maxOrd) {
                    slot.setBooked(true);
                    slot.setCustomerId(customer.getId());
                    bookingRepo.save(slot);
                }
            }
        }
        return new ApiResponse(true, "Seats " + req.getSelectedSeats() + " booked successfully for " + req.getPassengerName() + "!");
    }

    private int getOrder(Long busId, String location) {
        BusRoute r = routeRepo.findByBusIdAndLocationNameIgnoreCase(busId, cap(location));
        return r == null ? -1 : r.getOrderId();
    }

    private String cap(String s) {
        if (s == null || s.trim().isEmpty()) return s;
        s = s.trim();
        return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
    }
}
