package com.busreservation.repository;
import com.busreservation.model.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {

    List<Trip> findByBusIdAndStatusNotOrderByDepartureTimeAsc(Long busId, String status);
    List<Trip> findByBusIdAndStatusOrderByDepartureTimeAsc(Long busId, String status);

    @Query(value = "SELECT * FROM trips WHERE departure_time LIKE CONCAT(:datePrefix,'%') AND departure_time > :currentTime AND status = 'SCHEDULED'", nativeQuery = true)
    List<Trip> findAvailableTrips(@Param("datePrefix") String datePrefix, @Param("currentTime") String currentTime);

    @Transactional
    @Modifying
    @Query("UPDATE Trip t SET t.status = 'DEPARTED' WHERE t.departureTime <= :now AND t.status = 'SCHEDULED'")
    void markDeparted(@Param("now") String now);

    @Transactional
    @Modifying
    @Query("UPDATE Trip t SET t.status = 'COMPLETED' WHERE t.arrivalTime <= :now AND t.status = 'DEPARTED'")
    void markCompleted(@Param("now") String now);

    @Query(value = "SELECT * FROM trips WHERE bus_id = :busId AND ((departure_time <= :dep AND arrival_time >= :dep) OR (departure_time <= :arr AND arrival_time >= :arr) OR (departure_time >= :dep AND arrival_time <= :arr)) AND status != 'COMPLETED'", nativeQuery = true)
    List<Trip> findOverlapping(@Param("busId") Long busId, @Param("dep") String dep, @Param("arr") String arr);
}
