<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
<%@ page errorPage="AppError.jsp" %>

<%
// Get Student object from session
Student student = (Student) session.getAttribute("studentObj");

// Get Teacher object from session
Teacher teacher = (Teacher) session.getAttribute("teacherObj");

// Initialize variable
int sessionTimeoutSeconds = 0;
if (student != null || teacher != null) {
    // Set session timeout to 15 minutes
    sessionTimeoutSeconds = 15 * 60;
    session.setMaxInactiveInterval(sessionTimeoutSeconds);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - Connect Students & Teachers</title>
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
                <% if (student != null) { %>

                  <li class="nav-item">
                        <a class="nav-link"><b>Signed in as <%= student.getFullName()%></b></a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp">
                            <span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span>
                        </a>
                    </li>

                <% } else if (teacher != null) { %>

                <li class="nav-item">
                        <a class="nav-link"><b>Signed in as <%= teacher.getName()%></b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span></a>
                    </li>

                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/elearn/UI/index.jsp">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  href="<%=request.getContextPath()%>/elearn/UI/signup.jsp"><b>Sign Up</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signin.jsp"><b>Sign In</b></a>
                    </li>
                <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">
        <h1>Welcome to E-Learn</h1>
        <p>Your platform for connecting students and teachers.</p>
        
        <div class="row mb-5">
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
                        An integrated messaging system in which students and teachers can communicate.
                    </div>
                </div>
            </div>
        </div>

        <!-- Encouragement Section -->
        <div class="row">
            <h2>Join E-Learn Today!</h2>
            <p>Sign up to connect with expert teachers or eager students.</p>
            <p>Empower your learning journey or share your knowledge!</p>
            <% if (student != null) { %>
            <a href="home_student.jsp" class="btn btn-custom btn-lg">Go to Student Home page</a>
            <% } else if (teacher != null) { %>
            <a href="home_teacher.jsp" class="btn btn-custom btn-lg">Go to Teacher Home page</a>
            <% } else { %> 
            <a href="signup.jsp" class="btn btn-custom btn-lg">Sign Up Now</a>
            <% } %>
        </div>
    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-WofnHkT9V+gBoOwXpTVSgTsAA13RYqArvDjNkHH4iy0Tx4sLIFEd5lfjqBa8TobC" crossorigin="anonymous"></script>

</body>
</html>
