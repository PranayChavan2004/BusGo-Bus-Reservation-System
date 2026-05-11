<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Register Bus | BusGo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
  .navbar { background: #fff; border-bottom: 1px solid #e9ecef; }
  .navbar-brand { font-weight: 700; color: #212529 !important; }
  .navbar-brand i { color: #0d6efd; }
  .nav-link { font-weight: 500; color: #6c757d !important; font-size: 0.9rem; }
  .nav-link:hover, .nav-link.active { color: #212529 !important; }

  .step-card { background: #fff; border: 1px solid #e9ecef; border-radius: 12px; padding: 28px; margin-bottom: 16px; }

  /* Progress indicators */
  .progress-bar-custom { display: flex; gap: 0; margin-bottom: 24px; }
  .prog-step { flex: 1; text-align: center; position: relative; }
  .prog-step .circle {
    width: 32px; height: 32px; border-radius: 50%; background: #e9ecef; color: #6c757d;
    display: inline-flex; align-items: center; justify-content: center;
    font-weight: 700; font-size: 0.85rem; margin-bottom: 4px;
  }
  .prog-step.active .circle { background: #0d6efd; color: #fff; }
  .prog-step.done .circle { background: #198754; color: #fff; }
  .prog-step .label { font-size: 0.72rem; color: #6c757d; font-weight: 600; }
  .prog-step.active .label { color: #0d6efd; }

  /* Seat preview */
  .seat-preview-box { background: #1e293b; border-radius: 10px; padding: 16px; margin-top: 8px; }
  .seat-row-p { display: flex; gap: 6px; justify-content: center; margin-bottom: 6px; }
  .seat-p {
    width: 32px; height: 32px; border-radius: 6px; background: #0d6efd;
    display: flex; align-items: center; justify-content: center;
    color: #fff; font-size: 0.65rem; font-weight: 700;
  }
  .seat-p.aisle { background: transparent; width: 16px; }

  /* Stop inputs */
  .stop-row { position: relative; }
  .stop-num {
    position: absolute; left: 10px; top: 50%; transform: translateY(-50%);
    background: #0d6efd; color: #fff; border-radius: 50%; width: 20px; height: 20px;
    display: flex; align-items: center; justify-content: center;
    font-size: 0.65rem; font-weight: 700;
  }
  .stop-row input { padding-left: 38px; }

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
        <li class="nav-item"><a class="nav-link active" href="/register">Register Bus</a></li>
        <li class="nav-item"><a class="nav-link" href="/bus-details">Bus Details</a></li>
        <li class="nav-item"><a class="nav-link" href="/schedule">Schedule Trip</a></li>
      </ul>
      <a href="/logout" class="btn btn-outline-danger btn-sm ms-3">Logout</a>
    </div>
  </div>
</nav>

<div class="container py-4" style="max-width:850px;">
  <h4 class="fw-bold mb-1"><i class="fas fa-bus me-2 text-primary"></i>Register New Bus</h4>
  <p class="text-muted mb-3" style="font-size:0.9rem;">Add your bus with route and seating details</p>

  <!-- Progress -->
  <div class="progress-bar-custom">
    <div class="prog-step active" id="ind1"><div class="circle">1</div><div class="label">Basic Info</div></div>
    <div class="prog-step" id="ind2"><div class="circle">2</div><div class="label">Seat Layout</div></div>
    <div class="prog-step" id="ind3"><div class="circle">3</div><div class="label">Route</div></div>
  </div>

  <!-- Step 1: Basic Info -->
  <div id="step1">
    <div class="step-card">
      <h6 class="fw-bold mb-3"><i class="fas fa-id-card me-2 text-primary"></i>Basic Information</h6>
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Bus Name *</label>
          <input type="text" class="form-control" id="busName" placeholder="e.g. BusGo Travels">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Owner Name *</label>
          <input type="text" class="form-control" id="ownerName" placeholder="e.g. Pranay Chavan">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Number Plate *</label>
          <div class="input-group">
            <input type="text" class="form-control text-uppercase" id="numberPlate" placeholder="MH12AB1234" maxlength="15">
            <button class="btn btn-outline-primary" onclick="checkPlate()"><i class="fas fa-check"></i></button>
          </div>
          <small id="plateMsg" class="form-text"></small>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Mobile Number *</label>
          <input type="tel" class="form-control" id="mobileNo" placeholder="10-digit number" maxlength="10">
        </div>
        <div class="col-12">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Email (optional)</label>
          <input type="email" class="form-control" id="emailId" placeholder="owner@example.com">
        </div>
        <div class="col-12 text-end">
          <button class="btn btn-dark" onclick="goStep(2)">Next: Seat Layout <i class="fas fa-arrow-right ms-1"></i></button>
        </div>
      </div>
    </div>
  </div>

  <!-- Step 2: Seat Config -->
  <div id="step2" style="display:none;">
    <div class="step-card">
      <h6 class="fw-bold mb-3"><i class="fas fa-chair me-2 text-primary"></i>Seat Configuration</h6>
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Total Seats * <small class="text-muted">(10-60)</small></label>
          <input type="number" class="form-control" id="totalSeats" min="10" max="60" placeholder="e.g. 40" onchange="updateLayout()">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Left Side Seats *</label>
          <select class="form-select" id="leftSeats" onchange="updateLayout()">
            <option value="">Select</option><option value="1">1</option><option value="2">2</option><option value="3">3</option>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Right Side Seats *</label>
          <select class="form-select" id="rightSeats" onchange="updateLayout()">
            <option value="">Select</option><option value="1">1</option><option value="2">2</option><option value="3">3</option>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Last Row Extra Seats</label>
          <select class="form-select" id="lastRowSeats" onchange="updateLayout()">
            <option value="0">0</option><option value="1">1</option><option value="2">2</option>
            <option value="3">3</option><option value="4">4</option><option value="5">5</option>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Total Rows (auto)</label>
          <input type="number" class="form-control" id="totalRows" readonly>
        </div>
        <div class="col-12" id="previewWrap" style="display:none;">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Preview</label>
          <div class="seat-preview-box" id="seatPreview"></div>
        </div>
        <div class="col-12 d-flex justify-content-between">
          <button class="btn btn-outline-secondary" onclick="goStep(1)"><i class="fas fa-arrow-left me-1"></i>Back</button>
          <button class="btn btn-dark" onclick="goStep(3)">Next: Route <i class="fas fa-arrow-right ms-1"></i></button>
        </div>
      </div>
    </div>
  </div>

  <!-- Step 3: Route -->
  <div id="step3" style="display:none;">
    <div class="step-card">
      <h6 class="fw-bold mb-3"><i class="fas fa-route me-2 text-primary"></i>Route Information</h6>
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Start Point *</label>
          <input type="text" class="form-control" id="endpoint1" placeholder="e.g. Pune" oninput="syncStops()">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">End Point *</label>
          <input type="text" class="form-control" id="endpoint2" placeholder="e.g. Mumbai" oninput="syncStops()">
        </div>
        <div class="col-md-3">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Est. Hours</label>
          <input type="number" class="form-control" id="estHours" min="0" max="24" placeholder="0">
        </div>
        <div class="col-md-3">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Est. Minutes</label>
          <input type="number" class="form-control" id="estMinutes" min="0" max="59" placeholder="0">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Number of Stops * <small class="text-muted">(2-10, incl. endpoints)</small></label>
          <input type="number" class="form-control" id="numStops" min="2" max="10" placeholder="e.g. 3" oninput="generateStops()">
        </div>
        <div class="col-12" id="stopsContainer"></div>
        <div class="col-12 d-flex justify-content-between">
          <button class="btn btn-outline-secondary" onclick="goStep(2)"><i class="fas fa-arrow-left me-1"></i>Back</button>
          <button class="btn btn-dark" onclick="submitForm()"><i class="fas fa-save me-1"></i>Register Bus</button>
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
function showToast(msg, ok) {
  var el = document.getElementById('liveToast');
  el.className = 'toast align-items-center border-0 text-white ' + (ok ? 'bg-success' : 'bg-danger');
  document.getElementById('toastMsg').textContent = msg;
  new bootstrap.Toast(el, { delay: 4000 }).show();
}

function goStep(n) {
  if (n === 2 && !validateStep1()) return;
  if (n === 3 && !validateStep2()) return;
  document.getElementById('step1').style.display = n === 1 ? '' : 'none';
  document.getElementById('step2').style.display = n === 2 ? '' : 'none';
  document.getElementById('step3').style.display = n === 3 ? '' : 'none';
  for (var i = 1; i <= 3; i++) {
    var el = document.getElementById('ind' + i);
    el.className = 'prog-step' + (i < n ? ' done' : i === n ? ' active' : '');
  }
}

function validateStep1() {
  if (!document.getElementById('busName').value.trim()) { showToast('Enter bus name', false); return false; }
  if (!document.getElementById('ownerName').value.trim()) { showToast('Enter owner name', false); return false; }
  if (!document.getElementById('numberPlate').value.trim()) { showToast('Enter number plate', false); return false; }
  if (!/^\d{10}$/.test(document.getElementById('mobileNo').value.trim())) { showToast('Enter valid 10-digit mobile', false); return false; }
  return true;
}

function validateStep2() {
  var seats = parseInt(document.getElementById('totalSeats').value);
  var left = parseInt(document.getElementById('leftSeats').value);
  var right = parseInt(document.getElementById('rightSeats').value);
  if (!seats || seats < 10 || seats > 60) { showToast('Seats must be 10-60', false); return false; }
  if (!left || !right) { showToast('Select left and right seats', false); return false; }
  if (!document.getElementById('totalRows').value) { showToast('Invalid seat config, try different values', false); return false; }
  return true;
}

function checkPlate() {
  var plate = document.getElementById('numberPlate').value.trim().toUpperCase();
  if (!plate) { showToast('Enter plate first', false); return; }
  fetch('/api/bus/check-plate?plate=' + encodeURIComponent(plate))
    .then(function(r) { return r.json(); }).then(function(data) {
      var msg = document.getElementById('plateMsg');
      msg.textContent = data.success ? '✓ Available' : '✗ ' + data.message;
      msg.className = 'form-text ' + (data.success ? 'text-success' : 'text-danger');
    });
}

function updateLayout() {
  var seats = parseInt(document.getElementById('totalSeats').value) || 0;
  var left = parseInt(document.getElementById('leftSeats').value) || 0;
  var right = parseInt(document.getElementById('rightSeats').value) || 0;
  var last = parseInt(document.getElementById('lastRowSeats').value) || 0;
  if (!seats || !left || !right) { document.getElementById('totalRows').value = ''; document.getElementById('previewWrap').style.display = 'none'; return; }
  var perRow = left + right;
  var body = seats - last;
  if (body <= 0 || body % perRow !== 0) { document.getElementById('totalRows').value = ''; document.getElementById('previewWrap').style.display = 'none'; return; }
  var rows = body / perRow + (last > 0 ? 1 : 0);
  document.getElementById('totalRows').value = rows;
  renderPreview(seats, left, right, last, rows);
}

function renderPreview(total, left, right, last, rows) {
  var box = document.getElementById('seatPreview');
  var wrap = document.getElementById('previewWrap');
  var html = '<div style="color:#64748b;font-size:0.7rem;text-align:center;margin-bottom:8px;">FRONT &#128652;</div>';
  var num = last > 0 ? last : 0;
  var bodyRows = last > 0 ? rows - 1 : rows;
  for (var r = 0; r < bodyRows; r++) {
    html += '<div class="seat-row-p">';
    for (var l = 0; l < left; l++) { num++; html += '<div class="seat-p">' + num + '</div>'; }
    html += '<div class="seat-p aisle"></div>';
    for (var ri = 0; ri < right; ri++) { num++; html += '<div class="seat-p">' + num + '</div>'; }
    html += '</div>';
  }
  if (last > 0) {
    html += '<div class="seat-row-p">';
    for (var j = 0; j < last; j++) { html += '<div class="seat-p">' + (j + 1) + '</div>'; }
    html += '</div>';
  }
  box.innerHTML = html;
  wrap.style.display = '';
}

function generateStops() {
  var n = parseInt(document.getElementById('numStops').value);
  var ep1 = document.getElementById('endpoint1').value.trim();
  var ep2 = document.getElementById('endpoint2').value.trim();
  var container = document.getElementById('stopsContainer');
  if (!n || n < 2 || n > 10) { container.innerHTML = ''; return; }
  var html = '<div class="row g-2">';
  for (var i = 0; i < n; i++) {
    var val = '', ro = '';
    if (i === 0) { val = ep1; ro = 'readonly'; }
    if (i === n - 1) { val = ep2; ro = 'readonly'; }
    html += '<div class="col-md-6"><div class="stop-row"><span class="stop-num">' + (i + 1) + '</span>' +
      '<input type="text" class="form-control" id="stop' + i + '" value="' + val + '" placeholder="Stop ' + (i + 1) + '" ' + ro + '></div></div>';
  }
  html += '</div>';
  container.innerHTML = html;
}

function syncStops() {
  var n = parseInt(document.getElementById('numStops').value);
  if (!n) return;
  var s0 = document.getElementById('stop0');
  var sLast = document.getElementById('stop' + (n - 1));
  if (s0) s0.value = document.getElementById('endpoint1').value.trim();
  if (sLast) sLast.value = document.getElementById('endpoint2').value.trim();
}

function submitForm() {
  var ep1 = document.getElementById('endpoint1').value.trim();
  var ep2 = document.getElementById('endpoint2').value.trim();
  var n = parseInt(document.getElementById('numStops').value);
  if (!ep1 || !ep2) { showToast('Enter start and end points', false); return; }
  if (!n || n < 2) { showToast('Enter number of stops (min 2)', false); return; }
  var stops = [];
  for (var i = 0; i < n; i++) {
    var el = document.getElementById('stop' + i);
    var v = el ? el.value.trim() : '';
    if (!v) { showToast('Fill all stop names', false); return; }
    stops.push(v.charAt(0).toUpperCase() + v.slice(1).toLowerCase());
  }
  var body = {
    busName: document.getElementById('busName').value.trim(),
    ownerName: document.getElementById('ownerName').value.trim(),
    numberPlate: document.getElementById('numberPlate').value.trim().toUpperCase(),
    mobileNo: document.getElementById('mobileNo').value.trim(),
    emailId: document.getElementById('emailId').value.trim(),
    totalSeats: parseInt(document.getElementById('totalSeats').value),
    totalRows: parseInt(document.getElementById('totalRows').value),
    leftSeats: parseInt(document.getElementById('leftSeats').value),
    rightSeats: parseInt(document.getElementById('rightSeats').value),
    lastRowSeats: parseInt(document.getElementById('lastRowSeats').value) || 0,
    endpoint1: ep1.charAt(0).toUpperCase() + ep1.slice(1).toLowerCase(),
    endpoint2: ep2.charAt(0).toUpperCase() + ep2.slice(1).toLowerCase(),
    estHours: parseInt(document.getElementById('estHours').value) || 0,
    estMinutes: parseInt(document.getElementById('estMinutes').value) || 0,
    stops: stops
  };
  fetch('/api/bus/register', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) })
    .then(function(r) { return r.json(); }).then(function(data) {
      showToast(data.message, data.success);
      if (data.success) { setTimeout(function() { window.location.href = '/schedule'; }, 2000); }
    }).catch(function() { showToast('Registration failed', false); });
}
</script>
</body>
</html>
