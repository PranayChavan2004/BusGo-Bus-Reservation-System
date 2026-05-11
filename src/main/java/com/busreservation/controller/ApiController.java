package com.busreservation.controller;

import com.busreservation.dto.*;
import com.busreservation.service.BusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired private BusService busService;

    @PostMapping("/bus/register")
    public ResponseEntity<ApiResponse> registerBus(@Valid @RequestBody BusRegistrationRequest req,
                                                    BindingResult result) {
        if (result.hasErrors()) {
            String errors = result.getFieldErrors().stream()
                .map(e -> e.getDefaultMessage())
                .collect(Collectors.joining(", "));
            return ResponseEntity.badRequest().body(new ApiResponse(false, errors));
        }
        return ResponseEntity.ok(busService.registerBus(req));
    }

    @GetMapping("/bus/check-plate")
    public ResponseEntity<ApiResponse> checkPlate(@RequestParam String plate) {
        if (plate == null || plate.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(new ApiResponse(false, "Number plate is required."));
        }
        return ResponseEntity.ok(busService.checkNumberPlate(plate));
    }

    @GetMapping("/bus/details")
    public ResponseEntity<?> getBusDetails(@RequestParam String numberPlate) {
        if (numberPlate == null || numberPlate.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(new ApiResponse(false, "Number plate is required."));
        }
        Map<String, Object> data = busService.getBusDetails(numberPlate);
        if (data == null) return ResponseEntity.ok(new ApiResponse(false, "Bus not found with plate: " + numberPlate));
        return ResponseEntity.ok(new ApiResponse(true, "Success", data));
    }

    @PostMapping("/trip/schedule")
    public ResponseEntity<ApiResponse> scheduleTrip(@Valid @RequestBody TripScheduleRequest req,
                                                     BindingResult result) {
        if (result.hasErrors()) {
            String errors = result.getFieldErrors().stream()
                .map(e -> e.getDefaultMessage())
                .collect(Collectors.joining(", "));
            return ResponseEntity.badRequest().body(new ApiResponse(false, errors));
        }
        return ResponseEntity.ok(busService.scheduleTrip(req));
    }

    @PostMapping("/bus/search")
    public ResponseEntity<ApiResponse> searchBuses(@Valid @RequestBody SearchRequest req,
                                                    BindingResult result) {
        if (result.hasErrors()) {
            String errors = result.getFieldErrors().stream()
                .map(e -> e.getDefaultMessage())
                .collect(Collectors.joining(", "));
            return ResponseEntity.badRequest().body(new ApiResponse(false, errors));
        }
        List<Map<String, Object>> results = busService.searchBuses(req);
        return ResponseEntity.ok(new ApiResponse(true, "Found " + results.size() + " bus(es)", results));
    }

    @PostMapping("/seats/layout")
    public ResponseEntity<?> getSeatLayout(@RequestBody SeatRequest req) {
        Map<String, Object> layout = busService.getSeatLayout(req);
        if (layout == null) return ResponseEntity.ok(new ApiResponse(false, "Could not fetch seat layout."));
        return ResponseEntity.ok(new ApiResponse(true, "Success", layout));
    }

    @PostMapping("/booking/confirm")
    public ResponseEntity<ApiResponse> confirmBooking(@Valid @RequestBody BookingRequest req,
                                                       BindingResult result) {
        if (result.hasErrors()) {
            String errors = result.getFieldErrors().stream()
                .map(e -> e.getDefaultMessage())
                .collect(Collectors.joining(", "));
            return ResponseEntity.badRequest().body(new ApiResponse(false, errors));
        }
        return ResponseEntity.ok(busService.bookSeats(req));
    }
}
