package com.busreservation.model;
import javax.persistence.*;

@Entity
@Table(name = "trips")
public class Trip {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "bus_id", nullable = false)
    private Long busId;
    @Column(name = "direction", nullable = false)  // 0 = endpoint1->endpoint2, 1 = reverse
    private int direction;
    @Column(name = "departure_time", nullable = false)
    private String departureTime;
    @Column(name = "arrival_time", nullable = false)
    private String arrivalTime;
    @Column(name = "status", nullable = false)  // SCHEDULED, DEPARTED, COMPLETED
    private String status;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getBusId() { return busId; }
    public void setBusId(Long busId) { this.busId = busId; }
    public int getDirection() { return direction; }
    public void setDirection(int direction) { this.direction = direction; }
    public String getDepartureTime() { return departureTime; }
    public void setDepartureTime(String departureTime) { this.departureTime = departureTime; }
    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
