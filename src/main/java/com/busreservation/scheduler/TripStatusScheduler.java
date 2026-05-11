package com.busreservation.scheduler;

import com.busreservation.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class TripStatusScheduler {
    @Autowired private TripRepository tripRepo;

    @Scheduled(fixedDelay = 60000)
    public void updateTripStatuses() {
        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        tripRepo.markDeparted(now);
        tripRepo.markCompleted(now);
    }
}
