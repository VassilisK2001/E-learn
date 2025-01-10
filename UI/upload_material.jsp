<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page errorPage="AppError.jsp" %>
<%@ page import="elearn_classes.*" %>
<%@ page import="com.google.gson.Gson" %>

<%
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

// Create CourseDAO object
CourseDAO courseDAO = new CourseDAO();

// Fetch data from the database
List<String> courses = courseDAO.getCourseTitles();

// Convert lists to JSON using Gson library
Gson gson = new Gson();
String coursesJson = gson.toJson(courses);

// Check if user role and retrieve object from session
Student student = null;
Teacher teacher = null;
boolean isStudent = false;
if (session.getAttribute("studentObj") != null) {
    student = (Student) session.getAttribute("studentObj");
    isStudent = true;
} else {
    teacher = (Teacher) session.getAttribute("teacherObj");
}
%>

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
            <a class="navbar-brand">
                <img src="<%=request.getContextPath()%>/elearn/logo.svg" alt="Logo" width="150" height="48">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link"><b>Signed in as <%=((isStudent) ? (student.getFullName()) : (teacher.getName()))%></b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/<%=((isStudent) ? "home_student.jsp" : "home_teacher.jsp")%>"><b>Home</b></a>
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
        <h1 class="mb-4 text-center">Upload Educational Material</h1>
        
        <!-- Upload Form -->
        <form action="<%=request.getContextPath()%>/elearn/UI/newMaterial_Controller.jsp" method="post" enctype="multipart/form-data" class="p-4 border rounded bg-light">
            <!-- Course Title Input -->
            <div class="mb-3 position-relative">
                <label for="courseTitle" class="form-label">Course Title</label>
                <input type="text" class="form-control" id="courseTitle" name="courseTitle" placeholder="Enter the course title" required oninput="fetchCourseSuggestions(this.value)">
                <!-- Suggestions Container -->
                <div id="courseSuggestions" class="list-group"></div>
            </div>

            <!-- Note Title Input -->
            <div class="mb-3">
                <label for="noteTitle" class="form-label">Note Title</label>
                <input type="text" class="form-control" id="noteTitle" name="noteTitle" placeholder="Enter the note title" required>
            </div>

            <!-- File Upload Input -->
            <div class="mb-3">
                <label for="fileUpload" class="form-label">Upload File</label>
                <input type="file" class="form-control" id="fileUpload" name="fileUpload" accept=".pdf" required>
                <small class="form-text text-muted">Accepted formats: PDF</small>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary w-100">Submit</button>
        </form>

        <!-- Back Button -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/<%=((isStudent) ? "home_student.jsp" : "home_teacher.jsp")%>" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>
    </main>

    <!-- Footer -->
    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Inject the data into JavaScript as global variables -->
    <script>
        const coursesData = <%= coursesJson %>;
    </script>
    <script src="<%=request.getContextPath()%>/elearn/js/course_title.js"></script>

</body>
</html>
