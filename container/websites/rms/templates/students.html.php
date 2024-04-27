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
                        <a href="rms.html" class=" btn btn-dark btn-lg btn-block py-4">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="students.html" class="btn-selected btn btn-dark btn-lg btn-block py-4">Students</a>
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
                <div class="container table-container">
                    <div class="row justify-content-center"> <!-- Center the table -->
                        <div class="col-md-12">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Column 1</th>
                                        <th>Column 2</th>
                                        <th>Column 3</th>
                                        <th>Column 4</th>
                                        <th>Column 5</th>


                                        <!-- Add more columns here -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Data 1</td>
                                        <td>Data 2</td>
                                        <td>Data 3</td>
                                        <td>Data 4</td>
                                        <td>Data 5</td>
                                        <!-- Add more cells here -->
                                    </tr>
                                    <!-- Repeat this row 9 more times for a 10 x 5 table -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="container bottom-bar bg-light">
                    <div class="row">
                        <div class="col text-center">
                            <button id="first-page" class="btn btn-primary">First Page</button>
                        </div>
                        <div class="col text-center">
                            <button id="prev-page" class="btn btn-primary">Previous</button>
                        </div>
                        <div class="col text-center">
                            <span id="page-number">Page 1</span>
                        </div>
                        <div class="col text-center">
                            <button id="next-page" class="btn btn-primary">Next</button>
                        </div>
                        <div class="col text-center">
                            <button id="last-page" class="btn btn-primary">Last Page</button>
                        </div>
                    </div>
                </div>



            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
