package com.busreservation.dto;

import javax.validation.constraints.NotBlank;

public class SearchRequest {

    @NotBlank(message = "Departure location is required")
    private String fromLocation;

    @NotBlank(message = "Destination is required")
    private String toLocation;

    @NotBlank(message = "Travel date is required")
    private String travelDate;

    public String getFromLocation() { return fromLocation; }
    public void setFromLocation(String fromLocation) { this.fromLocation = fromLocation; }
    public String getToLocation() { return toLocation; }
    public void setToLocation(String toLocation) { this.toLocation = toLocation; }
    public String getTravelDate() { return travelDate; }
    public void setTravelDate(String travelDate) { this.travelDate = travelDate; }
}
