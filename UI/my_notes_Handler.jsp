<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>
<%@ page errorPage="AppError.jsp" %>


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

// Get data
String student = request.getParameter("student_id");
String note = request.getParameter("note_id");
String new_note = request.getParameter("add_note");
String del_note = request.getParameter("del_note");

int student_id = Integer.parseInt(student);
int note_id = Integer.parseInt(note);

// Variable to check if note has alrady been added to favourites
boolean note_exists = false;

// Initialize NoteDAO object
NoteDAO noteDAO = new NoteDAO();
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
        </div>
    </nav>

     <!-- Main Content -->
    <main class="container my-4 flex-grow-1">

    <% if (new_note != null && new_note.equals("true")) {  

        try {
            noteDAO.checkfavNoteExists(student_id, note_id);
        } catch(Exception e) {
            note_exists = true;
    %>

        <!-- Alert Box for General Error -->
        <div class="alert alert-danger" role="alert">
            <strong><%= e.getMessage()%></strong>
        </div>

        <!-- Back Button  -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/searchnotes_Controller.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to notes page
            </a>
        </div>

    <%  }

        if (!note_exists) {

            // Call method to insert student note into database
            noteDAO.saveNote(student_id, note_id);        
    %>

        <!-- Success Box with Bootstrap success class -->
        <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
            <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
            <div>
                <strong>Your note has been added to favourites!</strong>
            </div>
        </div>

        <!-- Buttons Section -->
        <div class="d-flex justify-content-center gap-3 mt-4">
            <!-- New button to redirect back to searchnotesController.jsp -->
            <a href="<%=request.getContextPath()%>/elearn/UI/searchnotes_Controller.jsp" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left ms-2"></i>Back to Notes Page
            </a>
            <!-- Button to redirect to favourite notes page -->
            <a href="<%=request.getContextPath()%>/elearn/UI/my_notes.jsp" class="btn btn-outline-primary">
                Check your note here<i class="fas fa-arrow-right ms-2"></i>
            </a>         
        </div>

        <% }   %>

    <% }  

    if (del_note.equals("true")) {
        noteDAO.deleteFavNote(student_id, note_id);
    %>

        <!-- Success Box with Bootstrap success class -->
        <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
            <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
            <div>
                <strong>The note has successfully been deleted from your list!</strong>
            </div>
        </div>

        <!-- Back Button  -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/my_notes.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to personal notes
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
