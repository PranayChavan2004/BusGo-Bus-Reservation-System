package com.busreservation.repository;
import com.busreservation.model.SeatBooking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SeatBookingRepository extends JpaRepository<SeatBooking, Long> {

    List<SeatBooking> findByTripIdAndSeatNo(Long tripId, int seatNo);

    @Query(value = "SELECT DISTINCT seat_no FROM seat_bookings WHERE trip_id = :tripId AND booked = true AND from_order < :toOrd AND to_order > :fromOrd", nativeQuery = true)
    List<Integer> findOccupiedSeats(@Param("tripId") Long tripId, @Param("fromOrd") int fromOrd, @Param("toOrd") int toOrd);

    @Query("SELECT s FROM SeatBooking s WHERE s.tripId = :tripId ORDER BY s.seatNo, s.fromOrder")
    List<SeatBooking> findByTripIdOrderBySeatNo(@Param("tripId") Long tripId);
}
