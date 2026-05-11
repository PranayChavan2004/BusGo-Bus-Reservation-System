package com.busreservation.model;
import javax.persistence.*;

@Entity
@Table(name = "seat_bookings")
public class SeatBooking {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "trip_id", nullable = false)
    private Long tripId;
    @Column(name = "bus_id", nullable = false)
    private Long busId;
    @Column(name = "seat_no", nullable = false)
    private int seatNo;
    @Column(name = "from_order", nullable = false)
    private int fromOrder;
    @Column(name = "to_order", nullable = false)
    private int toOrder;
    @Column(name = "customer_id")
    private Long customerId;
    @Column(name = "booked", nullable = false)
    private boolean booked;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getTripId() { return tripId; }
    public void setTripId(Long tripId) { this.tripId = tripId; }
    public Long getBusId() { return busId; }
    public void setBusId(Long busId) { this.busId = busId; }
    public int getSeatNo() { return seatNo; }
    public void setSeatNo(int seatNo) { this.seatNo = seatNo; }
    public int getFromOrder() { return fromOrder; }
    public void setFromOrder(int fromOrder) { this.fromOrder = fromOrder; }
    public int getToOrder() { return toOrder; }
    public void setToOrder(int toOrder) { this.toOrder = toOrder; }
    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long customerId) { this.customerId = customerId; }
    public boolean isBooked() { return booked; }
    public void setBooked(boolean booked) { this.booked = booked; }
}
