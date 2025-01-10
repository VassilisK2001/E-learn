<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="AppError.jsp" %>
<%@ page import="elearn_classes.*" %>


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

// Get form data
String teacher = request.getParameter("teacher_id");
String student = request.getParameter("student_id");
String course_title = request.getParameter("course_title");
String lesson_date = request.getParameter("scheduleDate");

int teacher_id = Integer.parseInt(teacher);
int student_id = Integer.parseInt(student);

// Create SimpleDateFormat for inserting lesson request date into database
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date schedule_date = dateFormat.parse(lesson_date);

// Create SimpleDateFormat for desired output format in user page
SimpleDateFormat outputDateFormat = new SimpleDateFormat("EEEE dd MMMM yyyy", Locale.ENGLISH); 
String formattedDate = outputDateFormat.format(schedule_date); 

// Initialiaze LessonReqDAO object
LessonReqDAO lessonReqDAO = new LessonReqDAO();

// Validation variable
boolean request_exists = false;
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
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">

    <%  try {
        lessonReqDAO.checkRequestExists(teacher_id, student_id, course_title, schedule_date);
    } catch(Exception e) {
        request_exists = true;
    %>

        <!-- Info Alert Box -->
        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="fas fa-info-circle fa-2x me-3"></i>
            <div>
                It looks like you have already sent a lesson request to this teacher for <strong><%= formattedDate %></strong>. 
                Check the status of your request <a href="<%=request.getContextPath()%>/elearn/UI/my_lessons.jsp">here</a>.
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher_Controller.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
            </a>
        </div>

    <%   }   
    if (!request_exists) {
        String request_status = "pending";
        lessonReqDAO.insertLessonReq(schedule_date, request_status, course_title, student_id, teacher_id);
    %>

        <!-- Success Box with Bootstrap success class -->
        <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
            <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
            <div>
                <strong>Your lesson request has successfully been sent to the teacher! Check the status of your request <a href="<%=request.getContextPath()%>/elearn/UI/my_lessons.jsp">here</a>.</strong>
            </div>
        </div>

         <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher_Controller.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
            </a>
        </div>

    <%  }  %>
    
    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
