package com.busreservation.model;

import javax.persistence.*;
import javax.validation.constraints.*;

@Entity
@Table(name = "buses")
public class Bus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "bus_name", nullable = false)
    private String busName;

    @Column(name = "owner_name", nullable = false)
    private String ownerName;

    @Column(name = "number_plate", nullable = false, unique = true)
    private String numberPlate;

    @Column(name = "mobile_no", nullable = false)
    private String mobileNo;

    @Column(name = "email_id")
    private String emailId;

    @Column(name = "total_seats", nullable = false)
    private int totalSeats;

    @Column(name = "total_rows", nullable = false)
    private int totalRows;

    @Column(name = "left_seats", nullable = false)
    private int leftSeats;

    @Column(name = "right_seats", nullable = false)
    private int rightSeats;

    @Column(name = "last_row_seats", nullable = false)
    private int lastRowSeats;

    @Column(name = "endpoint1", nullable = false)
    private String endpoint1;

    @Column(name = "endpoint2", nullable = false)
    private String endpoint2;

    @Column(name = "est_hours", nullable = false)
    private int estHours;

    @Column(name = "est_minutes", nullable = false)
    private int estMinutes;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
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
}
