<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="elearn_classes.*" %>

<%
// Retrive student object from session
Student student = (Student) session.getAttribute("studentObj");

// Initialize NoteDAO object
NoteDAO noteDAO = new NoteDAO();

// Initialize favourite notes list
List<Note> fav_notes = new ArrayList<Note>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - My Notes</title>
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
                        <a class="nav-link"><b>Signed in as <%= student.getFullName()%></b></a>
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

        <%
        fav_notes = noteDAO.getFavNotes(student);

        if (fav_notes.isEmpty()) {
        %>

       <!-- Info Alert Box -->
        <div class="alert alert-info text-center" role="alert">
            <i class="fas fa-info-circle me-2"></i>
            Your personal notes list is empty.
        </div>

        <% } else {  %>
        <h1 class="mb-4 text-center">My Notes</h1>

        <% for(Note note: fav_notes) {  %>

        <!-- Sample Cards for Notes -->
        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-2 d-flex align-items-center justify-content-center">
                    <i class="fas fa-file-pdf fa-3x text-danger"></i>
                </div>
                <div class="col-md-10">
                    <div class="card-body">
                        <h5 class="card-title">Lecture Notes: <%= note.getTitle()%></h5>
                        <p class="card-text">
                            <strong>Uploaded on:</strong> <%= note.getUpload_date()%><br>
                            <strong>Uploader:</strong> <%= note.getUploader_name()%><br>
                            <strong>Role:</strong> <%= note.getUploader_type()%>
                        </p>
                    </div>
                    <!-- Card Footer with Actions -->
                    <div class="card-footer d-flex justify-content-between">
                        <a href="<%= request.getContextPath() %>/elearn/notes/<%=note.getFile_url()%>" class="btn btn-primary" download>
                            <i class="fas fa-download me-2"></i>Download
                        </a>
                        <button class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#openNoteModal<%= note.getNote_id() %>">
                            <i class="fas fa-eye me-2"></i>Open Note
                        </button>
                        <a href="<%=request.getContextPath()%>/elearn/UI/my_notes_Handler.jsp?student_id=<%=student.getStudentId()%>&note_id=<%=note.getNote_id()%>&del_note=true" class="btn btn-danger">Remove from my notes</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for displaying the note content -->
        <div class="modal fade" id="openNoteModal<%= note.getNote_id() %>" tabindex="-1" aria-labelledby="openNoteModalLabel<%= note.getNote_id() %>" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="openNoteModalLabel<%= note.getNote_id() %>">Note: <%= note.getTitle() %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <%-- Handle PDF file for viewing --%>
                        <embed src="<%= request.getContextPath() %>/elearn/notes/<%=note.getFile_url()%>" width="100%" height="700px" /> 
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <% } %>

    <%  }  %>

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
</body>
</html>
