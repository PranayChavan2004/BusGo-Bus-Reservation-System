package com.busreservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping({"/", "/home"})
    public String home() { return "index"; }

    @GetMapping("/register")
    public String register() { return "register"; }

    @GetMapping("/schedule")
    public String schedule() { return "schedule"; }

    @GetMapping("/search")
    public String search() { return "search"; }

    @GetMapping("/bus-details")
    public String busDetails() { return "bus-details"; }
}
