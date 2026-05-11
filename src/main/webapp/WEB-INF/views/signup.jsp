<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Sign Up | BusGo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; min-height: 100vh;
         display: flex; align-items: center; justify-content: center; padding: 24px; }
  .signup-card { width: 100%; max-width: 420px; background: #fff; border-radius: 12px;
                 padding: 36px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); }
  .google-btn {
    display: flex; align-items: center; justify-content: center; gap: 10px;
    width: 100%; padding: 10px; border: 1.5px solid #dee2e6; border-radius: 8px;
    background: #fff; text-decoration: none; color: #212529;
    font-weight: 600; font-size: 0.9rem; transition: 0.15s;
  }
  .google-btn:hover { background: #f8f9fa; color: #212529; }
  .google-btn img { width: 18px; }
  .separator { display: flex; align-items: center; gap: 12px; margin: 18px 0; color: #adb5bd; font-size: 0.82rem; }
  .separator::before, .separator::after { content: ''; flex: 1; height: 1px; background: #dee2e6; }
</style>
</head>
<body>
<div class="signup-card">
  <h4 class="fw-bold mb-1">Create an account</h4>
  <p class="text-muted mb-3" style="font-size:0.9rem;">Start booking bus tickets</p>

  <div id="msgBox" class="alert py-2" style="display:none;font-size:0.88rem;"></div>

  <a href="/oauth2/authorization/google" class="google-btn">
    <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" alt="G">
    Sign up with Google
  </a>

  <div class="separator">or register with email</div>

  <form onsubmit="return doSignup(event)">
    <div class="mb-3">
      <label class="form-label fw-semibold" style="font-size:0.85rem;">Full Name</label>
      <input type="text" class="form-control" id="name" placeholder="Pranay Chavan" required>
    </div>
    <div class="mb-3">
      <label class="form-label fw-semibold" style="font-size:0.85rem;">Email</label>
      <input type="email" class="form-control" id="email" placeholder="you@example.com" required>
    </div>
    <div class="mb-3">
      <label class="form-label fw-semibold" style="font-size:0.85rem;">Password</label>
      <input type="password" class="form-control" id="password" placeholder="Min 6 characters" required minlength="6">
      <div class="form-text">At least 6 characters</div>
    </div>
    <button type="submit" class="btn btn-dark w-100 py-2 fw-semibold" id="submitBtn">Create Account</button>
  </form>

  <p class="text-center mt-3 mb-0" style="font-size:0.88rem;">
    Already have an account? <a href="/login" class="text-decoration-none fw-semibold">Sign in</a>
  </p>
</div>
<script>
function doSignup(e) {
  e.preventDefault();
  var btn = document.getElementById('submitBtn');
  var msg = document.getElementById('msgBox');
  btn.disabled = true;
  btn.textContent = 'Creating...';

  fetch('/api/auth/signup', {
    method: 'POST',
    headers: {'Content-Type':'application/json'},
    body: JSON.stringify({
      name: document.getElementById('name').value.trim(),
      email: document.getElementById('email').value.trim(),
      password: document.getElementById('password').value
    })
  }).then(function(r) { return r.json(); }).then(function(data) {
    btn.disabled = false;
    btn.textContent = 'Create Account';
    msg.style.display = 'block';
    if (data.success) {
      msg.className = 'alert alert-success py-2';
      msg.textContent = data.message;
      setTimeout(function() { window.location.href = '/login'; }, 1500);
    } else {
      msg.className = 'alert alert-danger py-2';
      msg.textContent = data.message;
    }
  }).catch(function() {
    btn.disabled = false;
    btn.textContent = 'Create Account';
    msg.className = 'alert alert-danger py-2';
    msg.textContent = 'Network error. Try again.';
    msg.style.display = 'block';
  });
  return false;
}
</script>
</body>
</html>
