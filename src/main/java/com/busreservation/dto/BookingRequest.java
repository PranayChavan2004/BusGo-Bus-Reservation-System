package com.busreservation.dto;

import javax.validation.constraints.*;
import java.util.List;

public class BookingRequest {

    @NotNull(message = "Trip ID is required")
    private Long tripId;

    @NotNull(message = "Bus ID is required")
    private Long busId;

    @NotBlank(message = "Departure location is required")
    private String fromLocation;

    @NotBlank(message = "Destination is required")
    private String toLocation;

    private int fromOrder;
    private int toOrder;

    @NotBlank(message = "Passenger name is required")
    @Size(min = 2, max = 100, message = "Name must be between 2-100 characters")
    private String passengerName;

    @NotBlank(message = "Mobile number is required")
    @Pattern(regexp = "^\\d{10}$", message = "Enter a valid 10-digit mobile number")
    private String mobileNo;

    @Email(message = "Enter a valid email address")
    private String emailId;

    @NotEmpty(message = "Select at least one seat")
    private List<Integer> selectedSeats;

    public Long getTripId() { return tripId; }
    public void setTripId(Long tripId) { this.tripId = tripId; }
    public Long getBusId() { return busId; }
    public void setBusId(Long busId) { this.busId = busId; }
    public String getFromLocation() { return fromLocation; }
    public void setFromLocation(String fromLocation) { this.fromLocation = fromLocation; }
    public String getToLocation() { return toLocation; }
    public void setToLocation(String toLocation) { this.toLocation = toLocation; }
    public int getFromOrder() { return fromOrder; }
    public void setFromOrder(int fromOrder) { this.fromOrder = fromOrder; }
    public int getToOrder() { return toOrder; }
    public void setToOrder(int toOrder) { this.toOrder = toOrder; }
    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }
    public String getMobileNo() { return mobileNo; }
    public void setMobileNo(String mobileNo) { this.mobileNo = mobileNo; }
    public String getEmailId() { return emailId; }
    public void setEmailId(String emailId) { this.emailId = emailId; }
    public List<Integer> getSelectedSeats() { return selectedSeats; }
    public void setSelectedSeats(List<Integer> selectedSeats) { this.selectedSeats = selectedSeats; }
}
