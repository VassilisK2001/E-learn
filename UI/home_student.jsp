<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="AppError.jsp" %>
<%@ page import="elearn_classes.*" %>

<%
// Check if the user is not signed in, set an error message, and forward to the login page
if((session.getAttribute("studentObj") == null && session.getAttribute("teacherObj") == null)) {
    request.setAttribute("message","You are not authorized to access this page. Please sign in.");
%>

<jsp:forward page="signin.jsp"/>

<% }
// Prevent browser from caching page
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

// Set session timeout to 15 minutes
int sessionTimeoutSeconds = 15 * 60;
session.setMaxInactiveInterval(sessionTimeoutSeconds);

// Get the student object from session
Student student = (Student) session.getAttribute("studentObj");
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
                    <li class="nav-item">
                        <a class="nav-link"><b>Signed in as <%= student.getFullName()%></b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">
        <h1>Hello <%= student.getFullName()%>. Welcome to E-Learn!</h1>
        
        <div class="row mb-5">
            <!-- Functionality Section 1 -->
                <div class="col-md-4 my-3">
                    <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher.jsp" class="text-decoration-none">
                        <div class="card functionality-card p-4">
                            <div class="functionality-title">Find teacher</div>
                            <div class="functionality-description">
                                Search and find the teacher you are looking for according to your criteria and preferences and schedule a lesson.
                            </div>
                        </div>
                    </a>
                </div>
            
            <!-- Functionality Section 2 -->
            <div class="col-md-4 my-3">
                <a href="<%=request.getContextPath()%>/elearn/UI/my_lessons.jsp" class="text-decoration-none">
                    <div class="card functionality-card p-4">
                        <div class="functionality-title">My lessons</div>
                        <div class="functionality-description">
                            Check the status of your requests for the teachers to whom you have sent a request to arrange a lesson
                        </div>
                    </div>
                </a>
            </div>

            <!-- Functionality Section 3 -->
            <div class="col-md-4 my-3">
                <a href="<%=request.getContextPath()%>/elearn/UI/search_notes.jsp" class="text-decoration-none">
                    <div class="card functionality-card p-4">
                        <div class="functionality-title">Search notes</div>
                        <div class="functionality-description">
                            Search notes for the course you are interested in and grant access to hundreds of notes and educational material uploaded by both students and teachers.
                        </div>
                    </div>
                </a>
            </div>

            <!-- Functionality Section 4 -->
            <div class="col-md-4 my-3">
                <a href="<%=request.getContextPath()%>/elearn/UI/upload_material.jsp" class="text-decoration-none">
                    <div class="card functionality-card p-4">
                        <div class="functionality-title">Share notes</div>
                        <div class="functionality-description">
                            Upload notes on courses you are interested in and help hundreds of students enrich their knowledge and pass their final exams.
                        </div>
                    </div>
                </a>
            </div>

            <!-- Functionality Section 5 -->
            <div class="col-md-4 my-3">
                <a href="<%=request.getContextPath()%>/elearn/UI/my_notes.jsp" class="text-decoration-none">
                    <div class="card functionality-card p-4">
                        <div class="functionality-title">My notes</div>
                        <div class="functionality-description">
                            Check your personal notes, which you have either saved or marked as favourite.
                        </div>
                    </div>
                </a>
            </div>

             <!-- Functionality Section 6 -->
            <div class="col-md-4 my-3">
                <a href="<%=request.getContextPath()%>/elearn/UI/student_messages.jsp" class="text-decoration-none">
                    <div class="card functionality-card p-4">
                        <div class="functionality-title">Check your messages</div>
                        <div class="functionality-description">
                            Have a look at conversations with other teachers and reply to their messages.
                        </div>
                    </div>
                </a>
            </div>
        </div>

    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
