<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - Connect Students & Teachers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/index.css">
    
</head>
<body class="d-flex flex-column min-vh-100">

    <nav class="navbar navbar-expand-lg mb-5">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="<%=request.getContextPath()%>/elearn/logo.svg" alt="Logo" width="150" height="48">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sign In</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">
        <h1>Welcome to E-Learn</h1>
        <p>Your platform for connecting students and teachers.</p>
        
        <div class="row">
            <!-- Functionality Section 1 -->
            <div class="col-md-4 my-3">
                <div class="card functionality-card p-4">
                    <div class="functionality-title">Profile Creation</div>
                    <div class="functionality-description">
                        Teachers and students create profiles to identify their interests and needs.
                    </div>
                </div>
            </div>

            <!-- Functionality Section 2 -->
            <div class="col-md-4 my-3">
                <div class="card functionality-card p-4">
                    <div class="functionality-title">Search and Book Lessons</div>
                    <div class="functionality-description">
                        Students can search for teachers based on subject, experience, and availability.
                    </div>
                </div>
            </div>

            <!-- Functionality Section 3 -->
            <div class="col-md-4 my-3">
                <div class="card functionality-card p-4">
                    <div class="functionality-title">Note Management</div>
                    <div class="functionality-description">
                        Users can upload, share, and view notes and course materials.
                    </div>
                </div>
            </div>

            <!-- Functionality Section 4 -->
            <div class="col-md-4 my-3">
                <div class="card functionality-card p-4">
                    <div class="functionality-title">Communication Platform</div>
                    <div class="functionality-description">
                        An integrated messaging system for easy communication between students and teachers.
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-WofnHkT9V+gBoOwXpTVSgTsAA13RYqArvDjNkHH4iy0Tx4sLIFEd5lfjqBa8TobC" crossorigin="anonymous"></script>

</body>
</html>
