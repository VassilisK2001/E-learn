<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="AppError.jsp" %>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>

<%
if((session.getAttribute("teacherObj") == null)) { 
    request.setAttribute("message","You are not authorized to access this page. Please sign in.");   
%>
            
<jsp:forward page="signin.jsp"/>

<% }
// Check if the request method is POST; otherwise, throw an exception
if(!request.getMethod().equals("POST")) {
    throw new Exception("No parameters specified. Please visit <a href='signup.jsp'>registration form</a>");
}

// Prevent browser from caching page
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

// Set session timeout to 15 minutes
int sessionTimeoutSeconds = 15 * 60;
session.setMaxInactiveInterval(sessionTimeoutSeconds);

// Get form data
String request_status = request.getParameter("status");
String request_id = request.getParameter("lessonReqId");

int lesson_request_id = Integer.parseInt(request_id); // Convert request_id to integer

// Initialize LessonReqDAO object
LessonReqDAO lessonReqDAO = new LessonReqDAO();

// Call method to update lesson request status
lessonReqDAO.updateLessonRequestStatus(lesson_request_id, request_status);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lesson Requests</title>
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
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">

    <!-- Success Box with Bootstrap success class -->
        <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
            <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
            <div>
                <strong>You have successfully updated the status of this lesson request.</strong>
            </div>
        </div>

         <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/my_requests.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
            </a>
        </div>

    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=request.getContextPath()%>/elearn/js/my_requests.js"></script>

</body>
</html>
