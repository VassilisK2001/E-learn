<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - Available Notes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg mb-5">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
                <img src="<%=request.getContextPath()%>/elearn/logo.svg" alt="Logo" width="150" height="48">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link">Signed in as John Doe</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_students.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signin.jsp">Sign In</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp">
                            <span>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">
        <h1 class="mb-4 text-center">Available Notes for Course: Introduction to Machine Learning</h1>

        <!-- Card Layout for Notes -->
        <div class="row row-cols-1 row-cols-md-2 g-4">
            <!-- Sample Card 1 -->
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="row g-0">
                        <!-- Icon Section -->
                        <div class="col-md-3 d-flex align-items-center justify-content-center p-3">
                            <i class="fas fa-file-pdf fa-3x text-danger"></i>
                        </div>
                        <!-- Content Section -->
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">Lecture Notes: Fundamentals of Machine Learning Algorithms</h5>
                                <p class="card-text">
                                    <strong>Uploaded on:</strong> 2024-11-05<br>
                                    <strong>Uploader:</strong> Alice Johnson<br>
                                    <strong>Role:</strong> Teacher
                                </p>
                            </div>
                            <!-- Card Footer with Actions -->
                            <div class="card-footer d-flex justify-content-between">
                                <a href="#" class="btn btn-primary"><i class="fas fa-download me-2"></i>Download</a>
                                <a href="#" class="btn btn-outline-secondary"><i class="fas fa-plus me-2"></i>Add to My Notes</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sample Card 2 -->
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="row g-0">
                        <div class="col-md-3 d-flex align-items-center justify-content-center p-3">
                            <i class="fas fa-file-word fa-3x text-primary"></i>
                        </div>
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">Assignment Solutions: Supervised and Unsupervised Learning</h5>
                                <p class="card-text">
                                    <strong>Uploaded on:</strong> 2024-10-20<br>
                                    <strong>Uploader:</strong> John Smith<br>
                                    <strong>Role:</strong> Student
                                </p>
                            </div>
                            <div class="card-footer d-flex justify-content-between">
                                <a href="#" class="btn btn-primary"><i class="fas fa-download me-2"></i>Download</a>
                                <a href="#" class="btn btn-outline-secondary"><i class="fas fa-plus me-2"></i>Add to My Notes</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sample Card 3 -->
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="row g-0">
                        <div class="col-md-3 d-flex align-items-center justify-content-center p-3">
                            <i class="fas fa-file-excel fa-3x text-success"></i>
                        </div>
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">Study Guide: Key Concepts and Techniques in Machine Learning</h5>
                                <p class="card-text">
                                    <strong>Uploaded on:</strong> 2024-09-15<br>
                                    <strong>Uploader:</strong> Sarah Brown<br>
                                    <strong>Role:</strong> Teacher
                                </p>
                            </div>
                            <div class="card-footer d-flex justify-content-between">
                                <a href="#" class="btn btn-primary"><i class="fas fa-download me-2"></i>Download</a>
                                <a href="#" class="btn btn-outline-secondary"><i class="fas fa-plus me-2"></i>Add to My Notes</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            © 2024 E-Learn. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
