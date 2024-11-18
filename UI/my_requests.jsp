<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lesson Requests</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <nav class="navbar navbar-expand-lg mb-5">
        <div class="container-fluid">
            <a class="navbar-brand">
                <img src="<%=request.getContextPath()%>/elearn/logo.svg" alt="Logo" width="150" height="48">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link"><b>Signed in as Mary Smith</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">
        <h1 class="mb-4">Lesson Requests</h1>

        <!-- Lesson Request Cards -->
        <div class="row">
            <!-- Lesson Request 1: Pending -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Student Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Student Photo">
                        </div>

                        <!-- Right Side: Carousel with Student Info and Lesson Info -->
                        <div class="col-8">
                            <div id="studentCarousel1" class="carousel slide" data-bs-ride="false" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Student Info -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">Alice Johnson</h5>
                                            <p class="card-text"><strong>Age:</strong> 25</p>
                                            <p class="card-text">A dedicated student focused on improving her skills in mathematics.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#studentCarousel1" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Lesson Info -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Course:</strong> Algebra 101</p>
                                            <p><strong>Lesson Date:</strong> 2024-11-10</p>
                                            <div class="mb-3">
                                                <label for="status1" class="form-label">Update request state</label>
                                                <select class="form-select" id="status1" onchange="updateStatus('status1')">
                                                    <option value="pending" selected>Pending</option>
                                                    <option value="accepted">Accepted</option>
                                                    <option value="rejected">Rejected</option>
                                                </select>
                                            </div>
                                            <p>Status: <span id="statusValue1">Pending</span></p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#studentCarousel1" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer: Conditional Buttons -->
                    <div class="card-footer text-center">
                        <button type="button" class="btn btn-outline-secondary">Contact Student</button>
                        <button type="button" id="submitBtn1" class="btn btn-primary d-none">Submit</button>
                    </div>
                </div>
            </div>

            <!-- Lesson Request 2: Accepted -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Student Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Student Photo">
                        </div>

                        <!-- Right Side: Carousel with Student Info and Lesson Info -->
                        <div class="col-8">
                            <div id="studentCarousel2" class="carousel slide" data-bs-ride="false" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Student Info -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">Bob Martin</h5>
                                            <p class="card-text"><strong>Age:</strong> 22</p>
                                            <p class="card-text">A passionate student with a focus on computer science.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#studentCarousel2" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Lesson Info -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Course:</strong> Computer Science 101</p>
                                            <p><strong>Lesson Date:</strong> 2024-11-12</p>
                                            <div class="mb-3">
                                                <label for="status2" class="form-label">Update request state</label>
                                                <select class="form-select" id="status2" onchange="updateStatus('status2')">
                                                    <option value="pending">Pending</option>
                                                    <option value="accepted" selected>Accepted</option>
                                                    <option value="rejected">Rejected</option>
                                                </select>
                                            </div>
                                            <p>Status: <span id="statusValue2">Accepted</span></p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#studentCarousel2" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer: Conditional Buttons -->
                    <div class="card-footer text-center">
                        <button type="button" class="btn btn-outline-secondary">Contact Student</button>
                        <button type="button" id="submitBtn2" class="btn btn-primary d-none">Submit</button>
                    </div>
                </div>
            </div>

            <!-- Lesson Request 3: Rejected -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Student Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Student Photo">
                        </div>

                        <!-- Right Side: Carousel with Student Info and Lesson Info -->
                        <div class="col-8">
                            <div id="studentCarousel3" class="carousel slide" data-bs-ride="false" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Student Info -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">Charlie Brown</h5>
                                            <p class="card-text"><strong>Age:</strong> 30</p>
                                            <p class="card-text">An enthusiastic student looking to improve his skills in physics.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#studentCarousel3" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Lesson Info -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Course:</strong> Physics 101</p>
                                            <p><strong>Lesson Date:</strong> 2024-11-18</p>
                                            <div class="mb-3">
                                                <label for="status3" class="form-label">Update request state</label>
                                                <select class="form-select" id="status3" onchange="updateStatus('status3')">
                                                    <option value="pending">Pending</option>
                                                    <option value="accepted">Accepted</option>
                                                    <option value="rejected" selected>Rejected</option>
                                                </select>
                                            </div>
                                            <p>Status: <span id="statusValue3">Rejected</span></p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#studentCarousel3" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer: Conditional Buttons -->
                    <div class="card-footer text-center">
                        <button type="button" class="btn btn-outline-secondary">Contact Student</button>
                        <button type="button" id="submitBtn3" class="btn btn-primary d-none">Submit</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>

    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=request.getContextPath()%>/elearn/js/my_requests.js"></script>

</body>
</html>
