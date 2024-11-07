<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Lessons</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
</head>
<body class="d-flex flex-column min-vh-100">
    
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
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signin.jsp">Sign In</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">
        <h1 class="mb-4">My Lessons</h1>

        <!-- Lessons Cards -->
        <div class="row">
            <!-- Lesson 1: Pending -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Lesson Info -->
                        <div class="col-8">
                            <div class="card-body">
                                <h5 class="card-title">John Doe</h5>
                                <p class="card-text"><strong>Course:</strong> Math 101</p>
                                <p class="card-text"><strong>Lesson Date:</strong> 2024-11-10</p>
                                <p class="card-text"><strong>Status:</strong> 
                                    <button class="btn btn-info">Pending</button>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer text-center">
                        <button type="button" id="submitBtn1" class="btn btn-primary">Contact Teacher</button>
                    </div>
                </div>
            </div>

            <!-- Lesson 2: Accepted -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Lesson Info -->
                        <div class="col-8">
                            <div class="card-body">
                                <h5 class="card-title">Jane Smith</h5>
                                <p class="card-text"><strong>Course:</strong> Science 202</p>
                                <p class="card-text"><strong>Lesson Date:</strong> 2024-11-15</p>
                                <p class="card-text"><strong>Status:</strong> 
                                    <button class="btn btn-success">Accepted</button>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer text-center">
                        <button type="button" id="submitBtn2" class="btn btn-primary">Contact Teacher</button>
                    </div>
                </div>
            </div>

            <!-- Lesson 3: Rejected -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Lesson Info -->
                        <div class="col-8">
                            <div class="card-body">
                                <h5 class="card-title">Samuel Green</h5>
                                <p class="card-text"><strong>Course:</strong> History 301</p>
                                <p class="card-text"><strong>Lesson Date:</strong> 2024-11-20</p>
                                <p class="card-text"><strong>Status:</strong> 
                                    <button class="btn btn-danger">Rejected</button>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer text-center">
                        <button type="button" id="submitBtn3" class="btn btn-primary">Contact Teacher</button>
                    </div>
                </div>
            </div>
        </div>

    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            © 2024 E-Learn. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
