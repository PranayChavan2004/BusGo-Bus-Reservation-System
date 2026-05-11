package com.busreservation.repository;
import com.busreservation.model.BusRoute;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
public interface BusRouteRepository extends JpaRepository<BusRoute, Long> {
    List<BusRoute> findByBusIdOrderByOrderIdAsc(Long busId);
    BusRoute findByBusIdAndLocationNameIgnoreCase(Long busId, String locationName);
    BusRoute findByBusIdAndOrderId(Long busId, int orderId);

    @Transactional
    @Modifying
    void deleteByBusId(Long busId);
}
