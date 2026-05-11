package com.busreservation.controller;

import com.busreservation.dto.ApiResponse;
import com.busreservation.model.AppUser;
import com.busreservation.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@Controller
public class AuthController {

    @Autowired private AppUserRepository userRepo;
    @Autowired private PasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }

    @PostMapping("/api/auth/signup")
    @ResponseBody
    public ApiResponse signup(@RequestBody Map<String, String> body) {
        String name = body.getOrDefault("name", "").trim();
        String email = body.getOrDefault("email", "").trim().toLowerCase();
        String password = body.getOrDefault("password", "");

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            return new ApiResponse(false, "All fields are required.");
        }
        if (password.length() < 6) {
            return new ApiResponse(false, "Password must be at least 6 characters.");
        }
        if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            return new ApiResponse(false, "Enter a valid email address.");
        }
        if (userRepo.existsByEmail(email)) {
            return new ApiResponse(false, "An account with this email already exists.");
        }

        AppUser user = new AppUser();
        user.setFullName(name);
        user.setEmail(email);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setProvider("local");
        userRepo.save(user);

        return new ApiResponse(true, "Account created! You can now sign in.");
    }
}
