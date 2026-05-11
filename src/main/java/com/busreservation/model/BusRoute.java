package com.busreservation.model;
import javax.persistence.*;

@Entity
@Table(name = "bus_routes")
public class BusRoute {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "bus_id", nullable = false)
    private Long busId;
    @Column(name = "location_name", nullable = false)
    private String locationName;
    @Column(name = "order_id", nullable = false)
    private int orderId;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getBusId() { return busId; }
    public void setBusId(Long busId) { this.busId = busId; }
    public String getLocationName() { return locationName; }
    public void setLocationName(String locationName) { this.locationName = locationName; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
}
