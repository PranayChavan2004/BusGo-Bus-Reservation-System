package com.busreservation.service;

import com.busreservation.model.AppUser;
import com.busreservation.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import java.util.Collections;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private AppUserRepository userRepo;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        AppUser user = userRepo.findByEmail(email)
            .orElseThrow(() -> new UsernameNotFoundException("No account found for " + email));

        if (!"local".equals(user.getProvider())) {
            throw new UsernameNotFoundException("This email uses Google login. Please sign in with Google.");
        }

        return new User(
            user.getEmail(),
            user.getPasswordHash(),
            Collections.singleton(new SimpleGrantedAuthority("ROLE_" + user.getRole()))
        );
    }
}
