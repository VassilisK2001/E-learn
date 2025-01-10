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

// Set session timeout to 15 minutes
int sessionTimeoutSeconds = 15 * 60;
session.setMaxInactiveInterval(sessionTimeoutSeconds);

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

// Get the student object from the session
Student student = (Student) session.getAttribute("studentObj");

// // Get notes list and course_title from session
List<Note> notesList = (List<Note>) session.getAttribute("notesList");
String course_title = (String) session.getAttribute("course_title");

if (notesList != null) {
    session.removeAttribute("notesList");
} 

if (course_title != null) {
    session.removeAttribute("course_title");
}

// Create CourseDAO object
CourseDAO courseDAO = new CourseDAO();

// Fetch data from the database
List<String> courses = courseDAO.getCourseTitles();

// Convert lists to JSON using Gson library
Gson gson = new Gson();
String coursesJson = gson.toJson(courses);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - Search Notes</title>
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
                        <a class="nav-link"><b>Signed in as <%=student.getFullName()%></b></a>
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
        <h1 class="mb-4 text-center">Search Educational Materials</h1>
        
        <!-- Search Form -->
        <div class="card shadow-lg">
            <div class="card-body">
                <form action="<%=request.getContextPath()%>/elearn/UI/searchnotes_Controller.jsp" method="POST">
                    <!-- Course Title Input -->
                    <div class="mb-3 position-relative">
                        <label for="courseTitle" class="form-label">Course Title</label>
                        <input type="text" class="form-control" id="courseTitle" name="courseTitle" placeholder="Enter the course title" required oninput="fetchCourseSuggestions(this.value)">
                        <!-- Suggestions Container -->
                        <div id="courseSuggestions" class="list-group"></div>
                    </div>

                    <!-- Academic Year Input -->
                    <!-- Academic Year Range Input -->
                    <div class="mb-3">
                        <label for="academicYearRange" class="form-label">Academic Year Range</label>
                        <div class="d-flex justify-content-between">
                            <div class="input-group me-2">
                                <span class="input-group-text">From</span>
                                <input type="number" id="minYear" class="form-control" name="minYear" value="1980" min="1980" max="<%= new java.util.Date().getYear() + 1900 %>" required>
                            </div>
                            <div class="input-group ms-2">
                                <span class="input-group-text">To</span>
                                <input type="number" id="maxYear" class="form-control" name="maxYear" value="<%= new java.util.Date().getYear() + 1900 %>" min="1980" max="<%= new java.util.Date().getYear() + 1900 %>" required>
                            </div>
                        </div>
                    </div>

                    <!-- Uploaded By Dropdown -->
                    <div class="mb-3">
                        <label for="uploaderType" class="form-label">Uploaded By</label>
                        <select class="form-select" id="uploaderType" name="uploaderType" required>
                            <option value="" disabled selected>Select Uploader Type</option>
                            <option value="all">All</option>
                            <option value="student">Student</option>
                            <option value="teacher">Teacher</option>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary w-100">Search</button>
                </form>
            </div>
        </div>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp" class="btn btn-outline-primary">
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
    <script>
        // Inject the courses data into JavaScript as global variables
        const coursesData = <%= coursesJson %>;

        // Get the current year dynamically
        const currentYear = new Date().getFullYear();

        // Set the max year input to the current year
        document.getElementById('maxYear').max = currentYear;
        document.getElementById('maxYear').value = currentYear;

            
        if (performance.navigation.type === performance.navigation.TYPE_BACK_FORWARD) {
            location.reload(true); // Force a reload from the server
        }
    </script>

    </script>
    <script src="<%=request.getContextPath()%>/elearn/js/course_title.js"></script>
</body>
</html>