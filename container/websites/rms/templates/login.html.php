<body>

<div class="login-container">
  <div class="logo-container">
    <img src="/img/woodlandslogo.jpg" alt="Woodlands University Logo" class="logo">
    <h1 class="text-center">Woodlands University</h1>
  </div>
  <form class="login-form" method="post">
    <h2 class="text-center mb-4">Staff RMS Login</h2>
    <div class="form-group">
      <label for="username">Username</label>
      <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username">
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password">
    </div>
    <button type="submit" class="btn btn-purple btn-block">Login</button>
  </form>
<?php
if (isset($auth_failed)) { ?>
	<p>Authentication Failed</p>
<?php } ?>

</div>

</body>
</html>
