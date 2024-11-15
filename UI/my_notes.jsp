<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - My Notes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
    <script>
        function removeCard(button) {
            // Get the card element containing the button
            const card = button.closest('.card');
            // Remove the card from the DOM
            card.remove();
        }
    </script>
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Navbar -->
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
                        <a class="nav-link"><b>Signed in as John Doe</b></a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp">
                            <span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">
        <h1 class="mb-4 text-center">My Notes</h1>

        <!-- Sample Cards for Notes -->
        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-2 d-flex align-items-center justify-content-center">
                    <i class="fas fa-file-pdf fa-3x text-danger"></i>
                </div>
                <div class="col-md-10">
                    <div class="card-body">
                        <h5 class="card-title">Lecture Notes: Fundamentals of Machine Learning Algorithms</h5>
                        <p class="card-text">
                            <strong>Uploaded on:</strong> 2024-09-15 <br>
                            <strong>Uploader:</strong> Sarah Brown<br>
                            <strong>Role:</strong> Teacher
                        </p>
                    </div>
                    <div class="card-footer text-end">
                        <button class="btn btn-danger" onclick="removeCard(this)">Remove from my notes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-2 d-flex align-items-center justify-content-center">
                    <i class="fas fa-file-word fa-3x text-primary"></i>
                </div>
                <div class="col-md-10">
                    <div class="card-body">
                        <h5 class="card-title">Assignment Solutions: Supervised and Unsupervised Learning</h5>
                         <p class="card-text">
                            <strong>Uploaded on:</strong> 2024-10-03 <br>
                            <strong>Uploader:</strong> Jane Smith<br>
                            <strong>Role:</strong> Teacher
                        </p>
                    </div>
                    <div class="card-footer text-end">
                        <button class="btn btn-danger" onclick="removeCard(this)">Remove from my notes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-2 d-flex align-items-center justify-content-center">
                    <i class="fas fa-file-pdf fa-3x text-danger"></i>
                </div>
                <div class="col-md-10">
                    <div class="card-body">
                        <h5 class="card-title">Study Guide: Key Concepts and Techniques in Machine Learning</h5>
                        <p class="card-text">
                            <strong>Uploaded on:</strong> 2024-11-20 <br>
                            <strong>Uploader:</strong> John Doe<br>
                            <strong>Role:</strong> Student
                        </p>
                    </div>
                    <div class="card-footer text-end">
                        <button class="btn btn-danger" onclick="removeCard(this)">Remove from my notes</button>
                    </div>
                </div>
            </div>
        </div>

    </main>

    <!-- Footer -->
    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
