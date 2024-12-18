<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>


<%
// Get the student object from the session
Student student = (Student) session.getAttribute("studentObj");

// Get form data
String course = request.getParameter("courseTitle");
String from = request.getParameter("minYear");
String to = request.getParameter("maxYear");
String uploader_type = request.getParameter("uploaderType");

// Variables for validation and error messages
int start_year = Integer.parseInt(from);
int end_year = Integer.parseInt(to);
List<String> errorMessages = new ArrayList<String>();
int countErrors = 0;
String fileUrl = "";
String iconClass = "";


// initialize available_notes list
List<Note> available_notes = new ArrayList<Note>();
%>

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

    <%
    CourseDAO courseDAO = new CourseDAO();

    try {
        courseDAO.checkCourseExists(course);
    } catch(Exception e) {
        countErrors++;
        errorMessages.add(e.getMessage());
    }

    if (start_year >= end_year) {
        countErrors++;
        errorMessages.add("The <b>start year</b> must be less than <b>end year</b> in academic year range.");
    }

    if (countErrors != 0) {
    %>

     <!-- Main Content -->
    <main class="container my-4 flex-grow-1">

    <!-- Alert Box for General Error -->
    <div class="alert alert-danger" role="alert">
        <strong>The form you filled in has errors.</strong>
    </div>

    <!-- Card to display detailed errors -->
    <div class="card">
        <div class="card-header">
            <strong>Search Material Form Errors</strong>
        </div>
        <div class="card-body">
            <ol class="list-group list-group-numbered">
                <% for (String errorMessage : errorMessages) { %>
                    <li class="list-group-item"><%= errorMessage %></li>
                <% } %>
            </ol>
        </div>
    </div>

    <!-- Back Button to Search Material form -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/search_notes.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back to Form
        </a>
    </div>

    <% } else {  %>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">
        <h1 class="mb-4 text-center">Available Notes for Course: <%=course%></h1>

        <!-- Card Layout for Notes -->
        <div class="row row-cols-1 row-cols-md-2 g-4">

        <%
        NoteDAO noteDAO = new NoteDAO();
        available_notes = noteDAO.searchNotes(course, start_year, end_year, uploader_type);

        for (Note note: available_notes) {

            // Get the file URL and determine the extension
            fileUrl = note.getFile_url();
            
            if (fileUrl.endsWith(".pdf")) {
                iconClass = "fas fa-file-pdf fa-3x text-danger";  // PDF icon
            } else if (fileUrl.endsWith(".doc") || fileUrl.endsWith(".docx")) {
                iconClass = "fas fa-file-word fa-3x text-primary";  // Word icon
            } else if (fileUrl.endsWith(".ppt") || fileUrl.endsWith(".pptx")) {
                iconClass = "fas fa-file-powerpoint fa-3x text-warning";  // PowerPoint icon
            }
        %>
            <!-- Card Notes -->
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="row g-0">
                        <!-- Icon Section -->
                        <div class="col-md-3 d-flex align-items-center justify-content-center p-3">
                            <i class="<%= iconClass %>"></i>
                        </div>
                        <!-- Content Section -->
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">Lecture Notes: <%=note.getTitle()%></h5>
                                <p class="card-text">
                                    <strong>Uploaded on:</strong> <%=note.getUpload_date()%><br>
                                    <strong>Uploader:</strong> <%=note.getUploader_name()%><br>
                                    <strong>Role:</strong> <%=note.getUploader_type()%>
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
        <%   }   %>
        </div>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/search_notes.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to search notes form
            </a>
        </div>

    
    <%  }  %>
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
