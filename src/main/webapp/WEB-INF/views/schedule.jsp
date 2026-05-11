<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Schedule Trip | BusGo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
  .navbar { background: #fff; border-bottom: 1px solid #e9ecef; }
  .navbar-brand { font-weight: 700; color: #212529 !important; }
  .navbar-brand i { color: #0d6efd; }
  .nav-link { font-weight: 500; color: #6c757d !important; font-size: 0.9rem; }
  .nav-link:hover, .nav-link.active { color: #212529 !important; }

  .main-card { background: #fff; border: 1px solid #e9ecef; border-radius: 12px; padding: 28px; }
  .bus-info-strip {
    background: #e7f1ff; border-radius: 10px; padding: 16px; margin-bottom: 20px;
  }
  .bus-info-strip .label { font-size: 0.72rem; color: #0d6efd; font-weight: 700; text-transform: uppercase; letter-spacing: 0.3px; }
  .bus-info-strip .value { font-size: 1rem; font-weight: 700; color: #212529; margin-top: 2px; }

  .dir-option {
    border: 2px solid #e9ecef; border-radius: 10px; padding: 14px 20px;
    cursor: pointer; text-align: center; transition: 0.15s;
  }
  .dir-option:hover, .dir-option.active { border-color: #0d6efd; background: #e7f1ff; }
  .dir-option .dir-text { font-weight: 700; margin-top: 4px; font-size: 0.9rem; }

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
        <li class="nav-item"><a class="nav-link" href="/bus-details">Bus Details</a></li>
        <li class="nav-item"><a class="nav-link active" href="/schedule">Schedule Trip</a></li>
      </ul>
      <a href="/logout" class="btn btn-outline-danger btn-sm ms-3">Logout</a>
    </div>
  </div>
</nav>

<div class="container py-4" style="max-width:750px;">
  <h4 class="fw-bold mb-1"><i class="fas fa-calendar-plus me-2 text-primary"></i>Schedule a Trip</h4>
  <p class="text-muted mb-3" style="font-size:0.9rem;">Set departure and arrival with overlap detection</p>

  <div class="main-card">
    <!-- Find bus -->
    <div class="mb-4">
      <label class="form-label fw-semibold" style="font-size:0.85rem;">Bus Number Plate *</label>
      <div class="input-group">
        <input type="text" class="form-control text-uppercase" id="busPlate" placeholder="e.g. MH12AB1234">
        <button class="btn btn-primary" onclick="fetchBus()"><i class="fas fa-search me-1"></i>Find</button>
      </div>
    </div>

    <!-- Bus info (hidden initially) -->
    <div id="busInfo" style="display:none;">
      <div class="bus-info-strip">
        <div class="row g-3">
          <div class="col-md-3"><div class="label">Bus</div><div class="value" id="infoBusName"></div></div>
          <div class="col-md-3"><div class="label">Owner</div><div class="value" id="infoOwner"></div></div>
          <div class="col-md-3"><div class="label">Route</div><div class="value" id="infoRoute"></div></div>
          <div class="col-md-3"><div class="label">Duration</div><div class="value" id="infoEst"></div></div>
        </div>
        <div class="mt-2"><div class="label">Stops</div><div class="value" id="infoStops" style="font-size:0.88rem;"></div></div>
      </div>

      <!-- Direction -->
      <label class="form-label fw-semibold mb-2" style="font-size:0.85rem;">Direction *</label>
      <div class="row g-3 mb-4">
        <div class="col-md-6">
          <div class="dir-option active" id="dir0" onclick="setDir(0)">
            <i class="fas fa-arrow-right text-primary"></i>
            <div class="dir-text" id="dir0Label">A &rarr; B</div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="dir-option" id="dir1" onclick="setDir(1)">
            <i class="fas fa-arrow-left text-primary"></i>
            <div class="dir-text" id="dir1Label">B &rarr; A</div>
          </div>
        </div>
      </div>

      <!-- Times -->
      <div class="row g-3 mb-3">
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Departure *</label>
          <input type="datetime-local" class="form-control" id="depTime">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Arrival *</label>
          <input type="datetime-local" class="form-control" id="arrTime">
        </div>
      </div>
      <div id="timeHint" class="alert alert-info py-2 small" style="display:none;"></div>

      <div class="d-flex gap-2 mt-3">
        <button class="btn btn-dark fw-semibold" onclick="scheduleTrip()"><i class="fas fa-save me-1"></i>Schedule Trip</button>
        <button class="btn btn-outline-secondary" onclick="resetForm()"><i class="fas fa-redo me-1"></i>Reset</button>
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
var currentBus = null, selectedDir = 0;

function showToast(msg, ok) {
  var el = document.getElementById('liveToast');
  el.className = 'toast align-items-center border-0 text-white ' + (ok ? 'bg-success' : 'bg-danger');
  document.getElementById('toastMsg').textContent = msg;
  new bootstrap.Toast(el, { delay: 4000 }).show();
}

function fetchBus() {
  var plate = document.getElementById('busPlate').value.trim().toUpperCase();
  if (!plate) { showToast('Enter number plate', false); return; }

  fetch('/api/bus/details?numberPlate=' + encodeURIComponent(plate))
    .then(function(r) { return r.json(); }).then(function(data) {
      if (!data.success) { showToast(data.message, false); return; }
      var d = data.data;
      currentBus = d.bus;
      document.getElementById('busInfo').style.display = '';
      document.getElementById('infoBusName').textContent = d.bus.busName;
      document.getElementById('infoOwner').textContent = d.bus.ownerName;
      document.getElementById('infoRoute').textContent = d.bus.endpoint1 + ' ↔ ' + d.bus.endpoint2;
      document.getElementById('infoEst').textContent = d.bus.estHours + 'h ' + d.bus.estMinutes + 'm';
      document.getElementById('infoStops').textContent = d.routes.map(function(r) { return r.locationName; }).join(' → ');
      document.getElementById('dir0Label').textContent = d.bus.endpoint1 + ' → ' + d.bus.endpoint2;
      document.getElementById('dir1Label').textContent = d.bus.endpoint2 + ' → ' + d.bus.endpoint1;

      // set default departure to now
      var now = new Date();
      now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
      var nowStr = now.toISOString().slice(0, 16);
      document.getElementById('depTime').min = nowStr;
      document.getElementById('depTime').value = nowStr;
      updateArrival();
    }).catch(function() { showToast('Error fetching bus', false); });
}

function setDir(d) {
  selectedDir = d;
  document.getElementById('dir0').className = 'dir-option' + (d === 0 ? ' active' : '');
  document.getElementById('dir1').className = 'dir-option' + (d === 1 ? ' active' : '');
}

document.getElementById('depTime').addEventListener('change', updateArrival);

function updateArrival() {
  if (!currentBus) return;
  var dep = document.getElementById('depTime').value;
  if (!dep) return;
  var d = new Date(dep);
  d.setHours(d.getHours() + currentBus.estHours);
  d.setMinutes(d.getMinutes() + currentBus.estMinutes);
  var arrStr = d.toISOString().slice(0, 16);
  document.getElementById('arrTime').value = arrStr;
  document.getElementById('arrTime').min = dep;
  var hint = document.getElementById('timeHint');
  hint.style.display = '';
  hint.textContent = 'Estimated arrival: ' + d.toLocaleString('en-IN');
}

function scheduleTrip() {
  if (!currentBus) { showToast('Find a bus first', false); return; }
  var dep = document.getElementById('depTime').value;
  var arr = document.getElementById('arrTime').value;
  if (!dep || !arr) { showToast('Set departure and arrival', false); return; }
  if (dep >= arr) { showToast('Arrival must be after departure', false); return; }

  fetch('/api/trip/schedule', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      busId: currentBus.id,
      direction: selectedDir,
      departureTime: dep.replace('T', ' ') + ':00',
      arrivalTime: arr.replace('T', ' ') + ':00'
    })
  }).then(function(r) { return r.json(); }).then(function(data) {
    showToast(data.message, data.success);
    if (data.success) setTimeout(resetForm, 2000);
  }).catch(function() { showToast('Scheduling failed', false); });
}

function resetForm() {
  currentBus = null;
  document.getElementById('busPlate').value = '';
  document.getElementById('busInfo').style.display = 'none';
  document.getElementById('timeHint').style.display = 'none';
  setDir(0);
}
</script>
</body>
</html>
