package com.busreservation.repository;
import com.busreservation.model.Bus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface BusRepository extends JpaRepository<Bus, Long> {
    Optional<Bus> findByNumberPlate(String numberPlate);
    boolean existsByNumberPlate(String numberPlate);
}
