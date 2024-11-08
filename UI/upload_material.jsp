<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - Upload Educational Material</title>
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
                        <a class="nav-link">Signed in as Mary Smith</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp">Home</a>
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
        <h1 class="mb-4 text-center">Upload Educational Material</h1>
        
        <!-- Upload Form -->
        <form action="<%=request.getContextPath()%>/uploadMaterial" method="post" enctype="multipart/form-data" class="p-4 border rounded bg-light">
            <div class="mb-3">
                <label for="courseTitle" class="form-label">Course Title</label>
                <input type="text" class="form-control" id="courseTitle" name="courseTitle" placeholder="Enter the course title" required>
            </div>
            <div class="mb-3">
                <label for="noteTitle" class="form-label">Note Title</label>
                <input type="text" class="form-control" id="noteTitle" name="noteTitle" placeholder="Enter the note title" required>
            </div>
            <div class="mb-3">
                <label for="fileUpload" class="form-label">Upload File</label>
                <input type="file" class="form-control" id="fileUpload" name="fileUpload" accept=".pdf, .doc, .docx" required>
                <small class="form-text text-muted">Accepted formats: PDF, DOC, DOCX</small>
            </div>
            <button type="submit" class="btn btn-primary w-100">Submit</button>
        </form>

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
