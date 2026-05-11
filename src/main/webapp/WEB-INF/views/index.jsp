<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BusGo - Bus Reservation System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
  .navbar { background: #fff; border-bottom: 1px solid #e9ecef; }
  .navbar-brand { font-weight: 700; color: #212529 !important; }
  .navbar-brand i { color: #0d6efd; }
  .nav-link { font-weight: 500; color: #6c757d !important; font-size: 0.9rem; }
  .nav-link:hover, .nav-link.active { color: #212529 !important; }

  .hero-section { padding: 80px 0 60px; text-align: center; }
  .hero-section h1 { font-size: 2.5rem; font-weight: 700; margin-bottom: 16px; }
  .hero-section p { color: #6c757d; font-size: 1.05rem; max-width: 600px; margin: 0 auto 32px; }

  .feature-card {
    background: #fff; border: 1px solid #e9ecef; border-radius: 12px;
    padding: 28px 24px; height: 100%; transition: box-shadow 0.2s;
  }
  .feature-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.06); }
  .feature-card .icon-box {
    width: 48px; height: 48px; border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.2rem; margin-bottom: 16px;
  }
  .feature-card h5 { font-weight: 700; font-size: 1rem; }
  .feature-card p { color: #6c757d; font-size: 0.88rem; }

  .how-it-works .step-circle {
    width: 44px; height: 44px; border-radius: 50%; background: #212529; color: #fff;
    display: inline-flex; align-items: center; justify-content: center;
    font-weight: 700; font-size: 1.1rem; margin-bottom: 12px;
  }

  footer { background: #fff; border-top: 1px solid #e9ecef; padding: 36px 0 20px; margin-top: 60px; }
  footer h6 { font-weight: 700; font-size: 0.82rem; text-transform: uppercase; color: #6c757d; letter-spacing: 0.5px; }
  footer a { color: #212529; text-decoration: none; font-size: 0.88rem; }
  footer a:hover { color: #0d6efd; }
  .footer-bottom { border-top: 1px solid #e9ecef; margin-top: 24px; padding-top: 16px;
                    text-align: center; color: #adb5bd; font-size: 0.82rem; }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg sticky-top">
  <div class="container">
    <a class="navbar-brand" href="/home"><i class="fas fa-bus me-2"></i>BusGo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mainNav">
      <ul class="navbar-nav ms-auto gap-1">
        <li class="nav-item"><a class="nav-link active" href="/home">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="/search">Book Ticket</a></li>
        <li class="nav-item"><a class="nav-link" href="/register">Register Bus</a></li>
        <li class="nav-item"><a class="nav-link" href="/bus-details">Bus Details</a></li>
        <li class="nav-item"><a class="nav-link" href="/schedule">Schedule Trip</a></li>
      </ul>
      <a href="/logout" class="btn btn-outline-danger btn-sm ms-3">Logout</a>
    </div>
  </div>
</nav>

<!-- Hero -->
<section class="hero-section">
  <div class="container">
    <span class="badge bg-primary bg-opacity-10 text-primary mb-3 px-3 py-2 rounded-pill" style="font-size:0.82rem;">
      <i class="fas fa-shield-alt me-1"></i> Trusted by operators across Maharashtra
    </span>
    <h1>Book bus seats.<br>Manage your fleet.</h1>
    <p>Search available buses, pick your seats, and confirm bookings instantly. Operators can register buses and schedule trips from one place.</p>
    <div class="d-flex gap-2 justify-content-center flex-wrap">
      <a href="/search" class="btn btn-dark btn-lg px-4"><i class="fas fa-ticket me-2"></i>Book a Seat</a>
      <a href="/register" class="btn btn-outline-dark btn-lg px-4"><i class="fas fa-plus me-2"></i>Register Bus</a>
    </div>
  </div>
</section>

<!-- Features -->
<section class="container mb-5">
  <div class="text-center mb-4">
    <h3 class="fw-bold">What you can do</h3>
    <p class="text-muted">Complete bus management at your fingertips</p>
  </div>
  <div class="row g-3">
    <div class="col-md-6 col-lg-3">
      <div class="feature-card">
        <div class="icon-box" style="background:#e7f1ff;color:#0d6efd;"><i class="fas fa-bus"></i></div>
        <h5>Register Bus</h5>
        <p>Add buses with seating config, route stops, and owner details.</p>
        <a href="/register" class="text-primary text-decoration-none fw-semibold" style="font-size:0.85rem;">Register &rarr;</a>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="feature-card">
        <div class="icon-box" style="background:#d1fae5;color:#059669;"><i class="fas fa-calendar-plus"></i></div>
        <h5>Schedule Trips</h5>
        <p>Set departure/arrival times with conflict detection.</p>
        <a href="/schedule" class="text-primary text-decoration-none fw-semibold" style="font-size:0.85rem;">Schedule &rarr;</a>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="feature-card">
        <div class="icon-box" style="background:#ede9fe;color:#7c3aed;"><i class="fas fa-chair"></i></div>
        <h5>Book Seats</h5>
        <p>Interactive seat map with real-time availability.</p>
        <a href="/search" class="text-primary text-decoration-none fw-semibold" style="font-size:0.85rem;">Book now &rarr;</a>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="feature-card">
        <div class="icon-box" style="background:#fef3c7;color:#d97706;"><i class="fas fa-info-circle"></i></div>
        <h5>Bus Details</h5>
        <p>View bus info, trip history, and current schedules.</p>
        <a href="/bus-details" class="text-primary text-decoration-none fw-semibold" style="font-size:0.85rem;">View &rarr;</a>
      </div>
    </div>
  </div>
</section>

<!-- How it works -->
<section class="container how-it-works mb-5">
  <h4 class="fw-bold text-center mb-4">How it works</h4>
  <div class="row g-4 text-center">
    <div class="col-md-4">
      <div class="step-circle">1</div>
      <h6 class="fw-bold">Search your route</h6>
      <p class="text-muted" style="font-size:0.88rem;">Enter from/to locations and travel date to find buses.</p>
    </div>
    <div class="col-md-4">
      <div class="step-circle">2</div>
      <h6 class="fw-bold">Pick your seats</h6>
      <p class="text-muted" style="font-size:0.88rem;">Choose from the seat layout. See what's taken, what's free.</p>
    </div>
    <div class="col-md-4">
      <div class="step-circle">3</div>
      <h6 class="fw-bold">Confirm booking</h6>
      <p class="text-muted" style="font-size:0.88rem;">Enter your details and you're done. Seats locked instantly.</p>
    </div>
  </div>
</section>

<!-- Footer -->
<footer>
  <div class="container">
    <div class="row g-4">
      <div class="col-md-5">
        <h5 class="fw-bold"><i class="fas fa-bus me-2 text-primary"></i>BusGo</h5>
        <p class="text-muted" style="font-size:0.88rem;">Bus reservation system for Maharashtra. Register buses, schedule trips, book seats.</p>
      </div>
      <div class="col-md-3">
        <h6>Quick Links</h6>
        <ul class="list-unstyled">
          <li class="mb-1"><a href="/home">Home</a></li>
          <li class="mb-1"><a href="/search">Book Ticket</a></li>
          <li class="mb-1"><a href="/register">Register Bus</a></li>
          <li class="mb-1"><a href="/schedule">Schedule Trip</a></li>
        </ul>
      </div>
      <div class="col-md-4">
        <h6>Contact</h6>
        <ul class="list-unstyled text-muted" style="font-size:0.88rem;">
          <li class="mb-1"><i class="fas fa-phone me-2 text-primary"></i>+91 9876543210</li>
          <li class="mb-1"><i class="fas fa-envelope me-2 text-primary"></i>info@busgo.in</li>
          <li class="mb-1"><i class="fas fa-map-marker-alt me-2 text-primary"></i>Pune, Maharashtra</li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">&copy; 2026 BusGo. All rights reserved.</div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
