package com.busreservation.dto;

import javax.validation.constraints.*;

public class TripScheduleRequest {

    @NotNull(message = "Bus ID is required")
    private Long busId;

    @Min(value = 0) @Max(value = 1)
    private int direction;

    @NotBlank(message = "Departure time is required")
    private String departureTime;

    @NotBlank(message = "Arrival time is required")
    private String arrivalTime;

    public Long getBusId() { return busId; }
    public void setBusId(Long busId) { this.busId = busId; }
    public int getDirection() { return direction; }
    public void setDirection(int direction) { this.direction = direction; }
    public String getDepartureTime() { return departureTime; }
    public void setDepartureTime(String departureTime) { this.departureTime = departureTime; }
    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }
}
