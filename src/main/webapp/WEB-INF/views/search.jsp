<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Book Ticket | BusGo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
  .navbar { background: #fff; border-bottom: 1px solid #e9ecef; }
  .navbar-brand { font-weight: 700; color: #212529 !important; }
  .navbar-brand i { color: #0d6efd; }
  .nav-link { font-weight: 500; color: #6c757d !important; font-size: 0.9rem; }
  .nav-link:hover, .nav-link.active { color: #212529 !important; }

  .search-box { background: #fff; border: 1px solid #e9ecef; border-radius: 12px; padding: 24px; }

  /* bus result card */
  .bus-card {
    background: #fff; border: 1px solid #e9ecef; border-radius: 10px;
    padding: 20px; margin-bottom: 12px; cursor: pointer; transition: 0.2s;
  }
  .bus-card:hover { box-shadow: 0 2px 8px rgba(0,0,0,0.06); border-color: #ced4da; }
  .bus-card .bus-name { font-weight: 700; font-size: 1rem; }
  .bus-card .bus-meta { color: #6c757d; font-size: 0.82rem; }
  .bus-card .time-big { font-size: 1.3rem; font-weight: 700; }
  .bus-card .time-label { font-size: 0.72rem; color: #6c757d; text-transform: uppercase; }

  /* seat layout */
  .seat-layout-box {
    background: #1e293b; border-radius: 12px; padding: 20px;
    display: inline-block; min-width: 300px;
  }
  .seat-row-flex { display: flex; gap: 6px; justify-content: center; margin-bottom: 6px; }
  .seat-btn {
    width: 36px; height: 36px; border-radius: 6px; border: none;
    font-size: 0.7rem; font-weight: 700; cursor: pointer; transition: 0.15s;
    display: flex; align-items: center; justify-content: center;
  }
  .seat-free { background: #334155; color: #94a3b8; }
  .seat-free:hover { background: #0d6efd; color: #fff; }
  .seat-taken { background: #dc3545; color: #fff; cursor: not-allowed; opacity: 0.7; }
  .seat-picked { background: #0d6efd; color: #fff; }
  .seat-gap { width: 14px; background: transparent; border: none; }

  .toast-fixed { position: fixed; top: 16px; right: 16px; z-index: 9999; }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top">
  <div class="container">
    <a class="navbar-brand" href="/home"><i class="fas fa-bus me-2"></i>BusGo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mainNav">
      <ul class="navbar-nav ms-auto gap-1">
        <li class="nav-item"><a class="nav-link" href="/home">Home</a></li>
        <li class="nav-item"><a class="nav-link active" href="/search">Book Ticket</a></li>
        <li class="nav-item"><a class="nav-link" href="/register">Register Bus</a></li>
        <li class="nav-item"><a class="nav-link" href="/bus-details">Bus Details</a></li>
        <li class="nav-item"><a class="nav-link" href="/schedule">Schedule Trip</a></li>
      </ul>
      <a href="/logout" class="btn btn-outline-danger btn-sm ms-3">Logout</a>
    </div>
  </div>
</nav>

<div class="container py-4">
  <h4 class="fw-bold mb-1"><i class="fas fa-ticket me-2 text-primary"></i>Book a Ticket</h4>
  <p class="text-muted mb-3" style="font-size:0.9rem;">Search buses, pick seats, and confirm your booking.</p>

  <!-- Search -->
  <div class="search-box mb-4">
    <div class="row g-3 align-items-end">
      <div class="col-md-3">
        <label class="form-label fw-semibold" style="font-size:0.85rem;">From</label>
        <input type="text" class="form-control" id="fromLoc" placeholder="e.g. Pune">
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold" style="font-size:0.85rem;">To</label>
        <input type="text" class="form-control" id="toLoc" placeholder="e.g. Mumbai">
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold" style="font-size:0.85rem;">Date</label>
        <input type="date" class="form-control" id="travelDate">
      </div>
      <div class="col-md-3">
        <button class="btn btn-dark w-100" onclick="searchBuses()">
          <i class="fas fa-search me-1"></i> Search
        </button>
      </div>
    </div>
  </div>

  <!-- Results -->
  <div id="resultsSection" style="display:none;">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h5 class="fw-bold mb-0">Available Buses</h5>
      <span class="text-muted" id="resultCount" style="font-size:0.85rem;"></span>
    </div>
    <div id="resultsList"></div>
  </div>

  <!-- Seat Selection -->
  <div id="seatSection" style="display:none;">
    <div class="d-flex align-items-center mb-3">
      <button class="btn btn-outline-secondary btn-sm me-3" onclick="backToResults()">
        <i class="fas fa-arrow-left me-1"></i>Back
      </button>
      <h5 class="fw-bold mb-0" id="selectedBusInfo"></h5>
    </div>
    <div class="row g-4">
      <!-- Seat map -->
      <div class="col-lg-7">
        <div class="bg-white border rounded-3 p-4">
          <h6 class="fw-bold mb-3">Seat Layout</h6>
          <div class="text-center">
            <div class="seat-layout-box">
              <div style="color:#64748b;font-size:0.72rem;text-align:center;margin-bottom:10px;font-weight:600;">
                DRIVER &#128663;
              </div>
              <div id="seatGrid"></div>
            </div>
          </div>
          <div class="d-flex gap-3 mt-3 flex-wrap" style="font-size:0.82rem;color:#6c757d;">
            <span><span class="d-inline-block rounded" style="width:14px;height:14px;background:#334155;vertical-align:middle;"></span> Available</span>
            <span><span class="d-inline-block rounded" style="width:14px;height:14px;background:#dc3545;vertical-align:middle;"></span> Occupied</span>
            <span><span class="d-inline-block rounded" style="width:14px;height:14px;background:#0d6efd;vertical-align:middle;"></span> Selected</span>
          </div>
          <div class="bg-light rounded p-2 mt-3" style="font-size:0.88rem;">
            Selected: <strong class="text-primary" id="selectedSeatsList">None</strong>
          </div>
        </div>
      </div>
      <!-- Passenger form -->
      <div class="col-lg-5">
        <div class="bg-white border rounded-3 p-4">
          <h6 class="fw-bold mb-3"><i class="fas fa-user me-2 text-primary"></i>Passenger Details</h6>
          <div class="mb-3">
            <label class="form-label fw-semibold" style="font-size:0.85rem;">Full Name *</label>
            <input type="text" class="form-control" id="passengerName" placeholder="Enter full name">
          </div>
          <div class="mb-3">
            <label class="form-label fw-semibold" style="font-size:0.85rem;">Mobile Number *</label>
            <input type="tel" class="form-control" id="passengerMobile" placeholder="10-digit number" maxlength="10">
          </div>
          <div class="mb-3">
            <label class="form-label fw-semibold" style="font-size:0.85rem;">Email (optional)</label>
            <input type="email" class="form-control" id="passengerEmail" placeholder="you@example.com">
          </div>
          <button class="btn btn-dark w-100 fw-semibold" onclick="confirmBooking()">
            <i class="fas fa-check me-1"></i> Confirm Booking
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Toast -->
<div class="toast-fixed">
  <div id="liveToast" class="toast align-items-center border-0 text-white" role="alert">
    <div class="d-flex">
      <div class="toast-body fw-semibold" id="toastMsg"></div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
var currentTrip = null;
var selectedSeats = [];

// set today as default
document.getElementById('travelDate').min = new Date().toISOString().split('T')[0];
document.getElementById('travelDate').value = new Date().toISOString().split('T')[0];

function showToast(msg, success) {
  var el = document.getElementById('liveToast');
  el.className = 'toast align-items-center border-0 text-white ' + (success ? 'bg-success' : 'bg-danger');
  document.getElementById('toastMsg').textContent = msg;
  new bootstrap.Toast(el, { delay: 4000 }).show();
}

function searchBuses() {
  var from = document.getElementById('fromLoc').value.trim();
  var to = document.getElementById('toLoc').value.trim();
  var date = document.getElementById('travelDate').value;
  if (!from || !to || !date) { showToast('Fill all search fields', false); return; }
  if (from.toLowerCase() === to.toLowerCase()) { showToast('From and To cannot be same', false); return; }

  fetch('/api/bus/search', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ fromLocation: from, toLocation: to, travelDate: date })
  }).then(function(r) { return r.json(); }).then(function(data) {
    document.getElementById('resultsSection').style.display = '';
    document.getElementById('seatSection').style.display = 'none';
    var results = data.data || [];
    document.getElementById('resultCount').textContent = results.length + ' buses found';
    var list = document.getElementById('resultsList');

    if (!results.length) {
      list.innerHTML = '<div class="text-center py-5 text-muted"><i class="fas fa-bus fa-2x mb-2 d-block"></i>No buses found. Try different route or date.</div>';
      return;
    }

    var html = '';
    for (var i = 0; i < results.length; i++) {
      var r = results[i];
      var badgeClass = r.availableSeats > 5 ? 'bg-success' : 'bg-warning text-dark';
      html += '<div class="bus-card" onclick="selectBus(' + i + ')">' +
        '<div class="row align-items-center">' +
          '<div class="col-md-3"><div class="bus-name"><i class="fas fa-bus me-2 text-primary"></i>' + r.bus.busName + '</div>' +
            '<div class="bus-meta">' + r.bus.numberPlate + ' &middot; ' + r.fromLocation + ' &rarr; ' + r.toLocation + '</div></div>' +
          '<div class="col-md-5 text-center">' +
            '<div class="d-flex align-items-center justify-content-center gap-3">' +
              '<div><div class="time-big">' + r.depTime + '</div><div class="time-label">Departure</div></div>' +
              '<i class="fas fa-long-arrow-alt-right text-muted"></i>' +
              '<div><div class="time-big">' + r.arrTime + '</div><div class="time-label">Arrival</div></div>' +
            '</div></div>' +
          '<div class="col-md-4 text-end">' +
            '<span class="badge ' + badgeClass + ' rounded-pill">' + r.availableSeats + ' seats</span>' +
            '<div class="mt-2"><button class="btn btn-dark btn-sm">Select Seats</button></div>' +
          '</div>' +
        '</div></div>';
    }
    list.innerHTML = html;
    window._searchResults = results;
  }).catch(function() { showToast('Search failed. Try again.', false); });
}

function selectBus(i) {
  var r = window._searchResults[i];
  currentTrip = r;
  selectedSeats = [];
  document.getElementById('selectedSeatsList').textContent = 'None';
  document.getElementById('resultsSection').style.display = 'none';
  document.getElementById('seatSection').style.display = '';
  document.getElementById('selectedBusInfo').innerHTML = r.bus.busName + ' &middot; ' + r.fromLocation + ' &rarr; ' + r.toLocation;

  fetch('/api/seats/layout', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ tripId: r.trip.id, busId: r.bus.id, fromLocation: r.fromLocation, toLocation: r.toLocation })
  }).then(function(res) { return res.json(); }).then(function(data) {
    if (!data.success) { showToast('Could not load seats', false); return; }
    renderSeats(data.data);
  }).catch(function() { showToast('Error loading seats', false); });
}

function renderSeats(data) {
  var bus = data.bus, seats = data.seats;
  var left = bus.leftSeats, right = bus.rightSeats, last = bus.lastRowSeats, total = bus.totalSeats;
  var grid = document.getElementById('seatGrid');
  var html = '';
  var idx = last;
  var bodySeats = total - last;
  var perRow = left + right;
  var bodyRows = perRow > 0 ? bodySeats / perRow : 0;

  for (var r = 0; r < bodyRows; r++) {
    html += '<div class="seat-row-flex">';
    for (var l = 0; l < left; l++) { html += makeSeatBtn(seats[idx]); idx++; }
    html += '<div class="seat-gap"></div>';
    for (var ri = 0; ri < right; ri++) { html += makeSeatBtn(seats[idx]); idx++; }
    html += '</div>';
  }
  if (last > 0) {
    html += '<div class="seat-row-flex">';
    for (var j = 0; j < last; j++) { html += makeSeatBtn(seats[j]); }
    html += '</div>';
  }
  grid.innerHTML = html;
}

function makeSeatBtn(s) {
  if (s.occupied) return '<button class="seat-btn seat-taken" disabled>' + s.seatNo + '</button>';
  return '<button class="seat-btn seat-free" id="s' + s.seatNo + '" onclick="toggleSeat(' + s.seatNo + ')">' + s.seatNo + '</button>';
}

function toggleSeat(no) {
  var btn = document.getElementById('s' + no);
  var idx = selectedSeats.indexOf(no);
  if (idx === -1) {
    selectedSeats.push(no);
    btn.className = 'seat-btn seat-picked';
  } else {
    selectedSeats.splice(idx, 1);
    btn.className = 'seat-btn seat-free';
  }
  document.getElementById('selectedSeatsList').textContent = selectedSeats.length ? selectedSeats.join(', ') : 'None';
}

function backToResults() {
  document.getElementById('seatSection').style.display = 'none';
  document.getElementById('resultsSection').style.display = '';
}

function confirmBooking() {
  if (!selectedSeats.length) { showToast('Select at least one seat', false); return; }
  var name = document.getElementById('passengerName').value.trim();
  var mobile = document.getElementById('passengerMobile').value.trim();
  var email = document.getElementById('passengerEmail').value.trim();
  if (!name) { showToast('Enter passenger name', false); return; }
  if (!/^\d{10}$/.test(mobile)) { showToast('Enter valid 10-digit mobile', false); return; }

  var r = currentTrip;
  fetch('/api/booking/confirm', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      tripId: r.trip.id, busId: r.bus.id,
      fromLocation: r.fromLocation, toLocation: r.toLocation,
      fromOrder: r.fromOrder, toOrder: r.toOrder,
      passengerName: name, mobileNo: mobile, emailId: email,
      selectedSeats: selectedSeats
    })
  }).then(function(res) { return res.json(); }).then(function(data) {
    showToast(data.message, data.success);
    if (data.success) {
      selectedSeats = [];
      // refresh seat map
      selectBus(window._searchResults.indexOf(r));
    }
  }).catch(function() { showToast('Booking failed', false); });
}
</script>
</body>
</html>
