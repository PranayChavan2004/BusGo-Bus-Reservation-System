<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Bus Details | BusGo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
  .navbar { background: #fff; border-bottom: 1px solid #e9ecef; }
  .navbar-brand { font-weight: 700; color: #212529 !important; }
  .navbar-brand i { color: #0d6efd; }
  .nav-link { font-weight: 500; color: #6c757d !important; font-size: 0.9rem; }
  .nav-link:hover, .nav-link.active { color: #212529 !important; }

  .main-card { background: #fff; border: 1px solid #e9ecef; border-radius: 12px; padding: 28px; margin-bottom: 16px; }
  .info-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 12px; margin: 16px 0; }
  .info-item { background: #f8f9fa; border-radius: 8px; padding: 12px; }
  .info-item .lbl { font-size: 0.72rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.3px; }
  .info-item .val { font-size: 1rem; font-weight: 700; color: #212529; margin-top: 2px; }

  .stop-pill { display: inline-block; background: #e7f1ff; color: #0d6efd; padding: 4px 12px;
               border-radius: 50px; font-size: 0.82rem; font-weight: 600; margin: 2px; }

  .trip-item {
    background: #f8f9fa; border-radius: 8px; padding: 14px; margin-bottom: 8px;
    border-left: 4px solid #0d6efd;
  }
  .trip-item.completed { border-left-color: #198754; }

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
        <li class="nav-item"><a class="nav-link" href="/search">Book Ticket</a></li>
        <li class="nav-item"><a class="nav-link" href="/register">Register Bus</a></li>
        <li class="nav-item"><a class="nav-link active" href="/bus-details">Bus Details</a></li>
        <li class="nav-item"><a class="nav-link" href="/schedule">Schedule Trip</a></li>
      </ul>
      <a href="/logout" class="btn btn-outline-danger btn-sm ms-3">Logout</a>
    </div>
  </div>
</nav>

<div class="container py-4" style="max-width:850px;">
  <h4 class="fw-bold mb-1"><i class="fas fa-info-circle me-2 text-primary"></i>Bus Details</h4>
  <p class="text-muted mb-3" style="font-size:0.9rem;">Look up bus info, route, and trip history</p>

  <div class="main-card">
    <div class="input-group">
      <input type="text" class="form-control" id="searchPlate" placeholder="Enter Bus Number Plate (e.g. MH12AB1234)" style="text-transform:uppercase;">
      <button class="btn btn-primary" onclick="fetchDetails()"><i class="fas fa-search me-1"></i>Search</button>
    </div>
  </div>

  <div id="details" style="display:none;">
    <!-- Bus info -->
    <div class="main-card">
      <h6 class="fw-bold mb-2"><i class="fas fa-bus me-2 text-primary"></i>Bus Information</h6>
      <div class="info-grid">
        <div class="info-item"><div class="lbl">Bus Name</div><div class="val" id="dBusName"></div></div>
        <div class="info-item"><div class="lbl">Plate</div><div class="val" id="dPlate"></div></div>
        <div class="info-item"><div class="lbl">Owner</div><div class="val" id="dOwner"></div></div>
        <div class="info-item"><div class="lbl">Mobile</div><div class="val" id="dMobile"></div></div>
        <div class="info-item"><div class="lbl">Seats</div><div class="val" id="dSeats"></div></div>
        <div class="info-item"><div class="lbl">Duration</div><div class="val" id="dEst"></div></div>
      </div>
      <div class="mt-2">
        <strong style="font-size:0.85rem;">Route:</strong>
        <div id="dStops" class="mt-1"></div>
      </div>
    </div>

    <!-- Trips tabs -->
    <ul class="nav nav-tabs mb-3">
      <li class="nav-item">
        <a class="nav-link active" data-bs-toggle="tab" href="#scheduled">Scheduled / Active</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-bs-toggle="tab" href="#completed">Completed</a>
      </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane fade show active" id="scheduled"><div id="scheduledList"></div></div>
      <div class="tab-pane fade" id="completed"><div id="completedList"></div></div>
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
function showToast(msg, ok) {
  var el = document.getElementById('liveToast');
  el.className = 'toast align-items-center border-0 text-white ' + (ok ? 'bg-success' : 'bg-danger');
  document.getElementById('toastMsg').textContent = msg;
  new bootstrap.Toast(el, { delay: 4000 }).show();
}

function fetchDetails() {
  var plate = document.getElementById('searchPlate').value.trim().toUpperCase();
  if (!plate) { showToast('Enter number plate', false); return; }

  fetch('/api/bus/details?numberPlate=' + encodeURIComponent(plate))
    .then(function(r) { return r.json(); }).then(function(data) {
      if (!data.success) { showToast(data.message, false); document.getElementById('details').style.display = 'none'; return; }
      var d = data.data;
      document.getElementById('dBusName').textContent = d.bus.busName;
      document.getElementById('dPlate').textContent = d.bus.numberPlate;
      document.getElementById('dOwner').textContent = d.bus.ownerName;
      document.getElementById('dMobile').textContent = d.bus.mobileNo;
      document.getElementById('dSeats').textContent = d.bus.totalSeats;
      document.getElementById('dEst').textContent = d.bus.estHours + 'h ' + d.bus.estMinutes + 'm';

      // route stops
      var stopsHtml = '';
      for (var i = 0; i < d.routes.length; i++) {
        stopsHtml += '<span class="stop-pill">' + d.routes[i].locationName + '</span>';
        if (i < d.routes.length - 1) stopsHtml += ' <i class="fas fa-arrow-right text-muted" style="font-size:0.75rem;"></i> ';
      }
      document.getElementById('dStops').innerHTML = stopsHtml;

      // trips
      document.getElementById('scheduledList').innerHTML = renderTrips(d.scheduledTrips, d.bus, false);
      document.getElementById('completedList').innerHTML = renderTrips(d.completedTrips, d.bus, true);
      document.getElementById('details').style.display = '';
    }).catch(function() { showToast('Error fetching details', false); });
}

function renderTrips(trips, bus, isCompleted) {
  if (!trips.length) return '<p class="text-muted text-center py-3">No trips</p>';
  var html = '';
  for (var i = 0; i < trips.length; i++) {
    var t = trips[i];
    var dep = t.departureTime.substring(0, 16).replace('T', ' ');
    var arr = t.arrivalTime.substring(0, 16).replace('T', ' ');
    var dir = t.direction === 0 ? bus.endpoint1 + ' → ' + bus.endpoint2 : bus.endpoint2 + ' → ' + bus.endpoint1;

    var badgeClass = 'bg-primary';
    if (t.status === 'DEPARTED') badgeClass = 'bg-warning text-dark';
    if (t.status === 'COMPLETED') badgeClass = 'bg-success';

    html += '<div class="trip-item' + (isCompleted ? ' completed' : '') + '">' +
      '<div class="d-flex justify-content-between align-items-start">' +
        '<div><div class="fw-bold" style="font-size:0.9rem;">' + dir + '</div>' +
          '<small class="text-muted"><i class="fas fa-clock me-1"></i>' + dep + ' → ' + arr + '</small></div>' +
        '<span class="badge ' + badgeClass + ' rounded-pill">' + t.status + '</span>' +
      '</div></div>';
  }
  return html;
}

// enter key support
document.getElementById('searchPlate').addEventListener('keypress', function(e) {
  if (e.key === 'Enter') fetchDetails();
});
</script>
</body>
</html>
