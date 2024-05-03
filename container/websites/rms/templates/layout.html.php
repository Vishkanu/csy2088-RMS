<?php
require '../templates/head.html.php';
?>

<body>

    <!-- Main Title Bar -->
    <div class="container-fluid bg-primary text-light py-4">
        <div class="row align-items-center">
            <div class="col-auto">
                <img src="/img/woodlandslogo.jpg" alt="Woodlands University Logo" class="rmslogo">
            </div>
            <div class="col-auto">
                <h1 class="text-center">Woodlands University - Records Management System</h1>
            </div>
            <div class="col user-logged">
                <div class="image-container-user">
                    <img src="/img/user.png" alt="User Profile Image" class="user-logo">
                </div>
				<h5>Logged in as: <?=$_SESSION['auth_name'];?> (<?=$_SESSION['auth_id'];?>)</h5>
				<p>Last logged in: <?=$_SESSION['lastlogged'];?></p>
                <a class="link-user" href="/rms/logout">Logout</a>
                <a class="link-user" href="">Manage User</a>
            </div>
        </div>
    </div>

    <!-- Content Area -->
    <div class="container-fluid content-area d-flex flex-column">
        <div class="row flex-grow-1">
            <!-- Side Navigation -->
            <div class="sidenav col-md-2 bg-dark text-light flex-column">
                <div class="sidebar-heading text-center py-4">
                    Woodlands University
                </div>
                <ul class="nav flex-column flex-grow-1">
                    <li class="nav-item">
                        <a href="home" class=" btn btn-dark btn-lg btn-block py-4">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="students" class="btn-selected btn btn-dark btn-lg btn-block py-4">Students</a>
                    </li>
                    <li class="nav-item">
                        <a href="attendance" class="btn btn-dark btn-lg btn-block py-4">Attendance</a>
                    </li>
                    <li class="nav-item">
                        <a href="assignments" class="btn btn-dark btn-lg btn-block py-4">Assignments</a>
                    </li>
                    <li class="nav-item">
                        <a href="staff" class="btn btn-dark btn-lg btn-block py-4">Tutors</a>
                    </li>
                    <li class="nav-item">
                        <a href="enrolment" class="btn btn-dark btn-lg btn-block py-4">Enrolment</a>
                    </li>
                </ul>
			</div>

<?php
require "../templates/$templateName.html.php";
?>

    <!-- Bootstrap JS (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
