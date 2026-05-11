<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Sign In | BusGo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; min-height: 100vh; }
  .login-wrapper { display: flex; min-height: 100vh; }
  .login-left {
    flex: 1; background: #1a1a2e; color: #fff; padding: 48px;
    display: flex; flex-direction: column; justify-content: center;
  }
  .login-left h1 { font-size: 2rem; font-weight: 700; margin-bottom: 8px; }
  .login-left p { color: #94a3b8; line-height: 1.6; }
  .login-left ul { list-style: none; padding: 0; margin-top: 32px; }
  .login-left ul li { color: #cbd5e1; margin-bottom: 14px; font-size: 0.95rem; }
  .login-left ul li i { color: #60a5fa; margin-right: 10px; width: 20px; }
  .login-right { flex: 1; display: flex; align-items: center; justify-content: center; padding: 32px; }
  .login-box { width: 100%; max-width: 400px; }
  .login-box h2 { font-weight: 700; margin-bottom: 4px; }
  .login-box .text-muted { margin-bottom: 24px; }
  .google-btn {
    display: flex; align-items: center; justify-content: center; gap: 10px;
    width: 100%; padding: 11px; border: 1.5px solid #dee2e6; border-radius: 8px;
    background: #fff; text-decoration: none; color: #212529;
    font-weight: 600; font-size: 0.92rem; transition: 0.15s;
  }
  .google-btn:hover { background: #f8f9fa; border-color: #adb5bd; color: #212529; }
  .google-btn img { width: 20px; }
  .separator { display: flex; align-items: center; gap: 12px; margin: 20px 0; color: #adb5bd; font-size: 0.82rem; }
  .separator::before, .separator::after { content: ''; flex: 1; height: 1px; background: #dee2e6; }
  @media (max-width: 768px) { .login-left { display: none; } }
</style>
</head>
<body>
<div class="login-wrapper">
  <div class="login-left">
    <h1><i class="fas fa-bus me-2"></i>BusGo</h1>
    <p>Bus reservation and fleet management for operators and passengers.</p>
    <ul>
      <li><i class="fas fa-search"></i>Search buses by route & date</li>
      <li><i class="fas fa-chair"></i>Interactive seat selection</li>
      <li><i class="fas fa-calendar-check"></i>Schedule and manage trips</li>
      <li><i class="fas fa-chart-line"></i>Track bookings & availability</li>
    </ul>
  </div>
  <div class="login-right">
    <div class="login-box">
      <h2>Welcome back</h2>
      <p class="text-muted">Sign in to continue</p>

      <div id="errorBox" class="alert alert-danger py-2" style="display:none;font-size:0.88rem;"></div>

      <a href="/oauth2/authorization/google" class="google-btn mb-2">
        <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" alt="G">
        Continue with Google
      </a>

      <div class="separator">or sign in with email</div>

      <form action="/login" method="post">
        <div class="mb-3">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Email</label>
          <input type="email" name="username" class="form-control" placeholder="you@example.com" required>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold" style="font-size:0.85rem;">Password</label>
          <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-dark w-100 py-2 fw-semibold">Sign In</button>
      </form>

      <p class="text-center mt-3" style="font-size:0.88rem;">
        Don't have an account? <a href="/signup" class="text-decoration-none fw-semibold">Create one</a>
      </p>
    </div>
  </div>
</div>
<script>
  const params = new URLSearchParams(window.location.search);
  const box = document.getElementById('errorBox');
  if (params.has('error')) {
    box.textContent = 'Invalid email or password.';
    box.style.display = 'block';
  }
  if (params.has('logout')) {
    box.className = 'alert alert-success py-2';
    box.textContent = 'Signed out successfully.';
    box.style.display = 'block';
  }
</script>
</body>
</html>
