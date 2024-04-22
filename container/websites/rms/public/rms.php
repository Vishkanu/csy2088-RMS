<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Woodlands University - Records Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="styles.css" rel="stylesheet">
</head>

<body>

    <!-- Main Title Bar -->
    <div class="container-fluid bg-primary text-light py-4">
        <div class="row align-items-center">
            <div class="col-auto">
                <img src="woodlandslogo.jpg" alt="Woodlands University Logo" class="rmslogo">
            </div>
            <div class="col-auto">
                <h1 class="text-center">Woodlands University - Records Management System</h1>
            </div>
            <div class="col user-logged">
                <div class="image-container-user">
                    <img src="user.png" alt="User Profile Image" class="user-logo">
                </div>
                <h5>Logged in as: Username</h5>
                <p>Last logged in: </p>
                <a class="link-user" href="">Logout</a>
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
                        <a href="rms.html" class="btn-selected btn btn-dark btn-lg btn-block py-4">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="students.html" class="btn btn-dark btn-lg btn-block py-4">Students</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="btn btn-dark btn-lg btn-block py-4">Attendance</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="btn btn-dark btn-lg btn-block py-4">Assignments</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="btn btn-dark btn-lg btn-block py-4">Tutors</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="btn btn-dark btn-lg btn-block py-4">Enrollment</a>
                    </li>
                </ul>
            </div>
            <!-- Main Content -->
            <div class="col-md-10 py-4">
                <!-- Main content here -->
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>