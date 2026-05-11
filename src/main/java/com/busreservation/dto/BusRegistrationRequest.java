package com.busreservation.dto;

import javax.validation.constraints.*;
import java.util.List;

public class BusRegistrationRequest {

    @NotBlank(message = "Bus name is required")
    private String busName;

    @NotBlank(message = "Owner name is required")
    private String ownerName;

    @NotBlank(message = "Number plate is required")
    @Pattern(regexp = "^[A-Z]{2}\\d{1,2}[A-Z]{0,3}\\d{1,4}$", message = "Invalid number plate format")
    private String numberPlate;

    @NotBlank(message = "Mobile number is required")
    @Pattern(regexp = "^\\d{10}$", message = "Enter a valid 10-digit mobile number")
    private String mobileNo;

    @Email(message = "Enter a valid email address")
    private String emailId;

    @Min(value = 10, message = "Minimum 10 seats required")
    @Max(value = 60, message = "Maximum 60 seats allowed")
    private int totalSeats;

    @Min(value = 1, message = "At least 1 row required")
    private int totalRows;

    @Min(value = 1, message = "Left seats must be at least 1")
    @Max(value = 3, message = "Left seats cannot exceed 3")
    private int leftSeats;

    @Min(value = 1, message = "Right seats must be at least 1")
    @Max(value = 3, message = "Right seats cannot exceed 3")
    private int rightSeats;

    @Min(value = 0)
    @Max(value = 5)
    private int lastRowSeats;

    @NotBlank(message = "Start point is required")
    private String endpoint1;

    @NotBlank(message = "End point is required")
    private String endpoint2;

    @Min(value = 0) @Max(value = 24)
    private int estHours;

    @Min(value = 0) @Max(value = 59)
    private int estMinutes;

    @NotEmpty(message = "At least 2 stops are required")
    @Size(min = 2, max = 10, message = "Stops must be between 2-10")
    private List<String> stops;

    public String getBusName() { return busName; }
    public void setBusName(String busName) { this.busName = busName; }
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    public String getNumberPlate() { return numberPlate; }
    public void setNumberPlate(String numberPlate) { this.numberPlate = numberPlate; }
    public String getMobileNo() { return mobileNo; }
    public void setMobileNo(String mobileNo) { this.mobileNo = mobileNo; }
    public String getEmailId() { return emailId; }
    public void setEmailId(String emailId) { this.emailId = emailId; }
    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }
    public int getTotalRows() { return totalRows; }
    public void setTotalRows(int totalRows) { this.totalRows = totalRows; }
    public int getLeftSeats() { return leftSeats; }
    public void setLeftSeats(int leftSeats) { this.leftSeats = leftSeats; }
    public int getRightSeats() { return rightSeats; }
    public void setRightSeats(int rightSeats) { this.rightSeats = rightSeats; }
    public int getLastRowSeats() { return lastRowSeats; }
    public void setLastRowSeats(int lastRowSeats) { this.lastRowSeats = lastRowSeats; }
    public String getEndpoint1() { return endpoint1; }
    public void setEndpoint1(String endpoint1) { this.endpoint1 = endpoint1; }
    public String getEndpoint2() { return endpoint2; }
    public void setEndpoint2(String endpoint2) { this.endpoint2 = endpoint2; }
    public int getEstHours() { return estHours; }
    public void setEstHours(int estHours) { this.estHours = estHours; }
    public int getEstMinutes() { return estMinutes; }
    public void setEstMinutes(int estMinutes) { this.estMinutes = estMinutes; }
    public List<String> getStops() { return stops; }
    public void setStops(List<String> stops) { this.stops = stops; }
}
