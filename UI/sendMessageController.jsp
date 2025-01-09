<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.Timestamp" %>


<%!
// Helper method to count words in a string
public static int countWords(String value){
    String[] words = value.split("[\\s.,]+");
    int wordCount = words.length;
    return wordCount;
}
%>

<%
// Get Teacher object from session
Teacher teacher = (Teacher) session.getAttribute("teacherObj");

// Get Student object from session
Student student = (Student) session.getAttribute("studentObj");

// Initialize MessageDAO object
MessageDAO messageDAO = new MessageDAO();

// Variables for validation and error messages
List<String> errorMessages = new ArrayList<String>();
int countErrors = 0;
boolean email_error = false;
int student_id = 0;
int teacher_id = 0;
int reply_to_id = 0;
int message_id = 0;

// Get form data for teacher reply
String teacher_reply = request.getParameter("teacherReply");
String recipient_student_id = request.getParameter("studentId");
String reply_to_message_id = request.getParameter("messageId");
String reply_subject = request.getParameter("replySubject");
String reply_body = request.getParameter("replyBody");

// Get form data for student message
String student_message = request.getParameter("studentMessage");
String recipient_teacher_id = request.getParameter("teacherId");
String message_subject = request.getParameter("messageSubject");
String message_body = request.getParameter("messageBody");

// Get form data for marking message as read
String mark_message_read = request.getParameter("markMessageRead");
String message_read_id = request.getParameter("messageId");

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

    <% 

    if (teacher_reply != null) {
        student_id = Integer.parseInt(recipient_student_id);
        reply_to_id = Integer.parseInt(reply_to_message_id);

        if (countWords(reply_body) > 20) {
            countErrors++;
            errorMessages.add("Your <b>message body</b> must be up to 20 words.");
        }

        if (countErrors != 0) { 
    %>

    <!-- Alert Box for General Error -->
    <div class="alert alert-danger" role="alert">
        <strong>Your message has errors.</strong>
    </div>

    <!-- Card to display detailed errors -->
    <div class="card">
        <div class="card-header">
            <strong>Message Errors</strong>
        </div>
        <div class="card-body">
            <ol class="list-group list-group-numbered">
                <% for (String errorMessage : errorMessages) { %>
                    <li class="list-group-item"><%= errorMessage %></li>
                <% } %>
            </ol>
        </div>
    </div>

     <!-- Back Button to message form -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/teacher_messages.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
        </a>
    </div>

    <%
        } else {
            java.time.LocalDateTime currentDateTime = java.time.LocalDateTime.now(); 
            java.sql.Timestamp currentTimestamp = java.sql.Timestamp.valueOf(currentDateTime); 

            messageDAO.insertTeacherReply(reply_to_id, false, teacher.getTeacher_id(), student_id, currentTimestamp, reply_subject, reply_body);
            messageDAO.updateIsReplied(reply_to_id);
    %>

     <!-- Success Box with Bootstrap success class -->
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
        <div>
            <strong>Your message was sent successfully!</strong>
        </div>
    </div>

      <!-- Back Button to message form -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/teacher_messages.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
        </a>
    </div>

    <% }
    } 
    if (student_message != null) {
        teacher_id = Integer.parseInt(recipient_teacher_id);
        if (countWords(message_subject) > 5) {
            countErrors++;
            errorMessages.add("<b>Message subject</b> must be up to <b>5 words</b>.");
        }
        if (countWords(message_body) > 20) {
            countErrors++;
            errorMessages.add("<b>Message body</b> must be up to <b>20 words</b>.");
        }
        if(countErrors != 0) { 
    %>

     <!-- Alert Box for General Error -->
    <div class="alert alert-danger" role="alert">
        <strong>Your message has errors.</strong>
    </div>

    <!-- Card to display detailed errors -->
    <div class="card">
        <div class="card-header">
            <strong>Message Errors</strong>
        </div>
        <div class="card-body">
            <ol class="list-group list-group-numbered">
                <% for (String errorMessage : errorMessages) { %>
                    <li class="list-group-item"><%= errorMessage %></li>
                <% } %>
            </ol>
        </div>
    </div>

     <!-- Back Button to message form -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher_Controller.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
        </a>
    </div>

    <%
        } else {
            java.time.LocalDateTime currentDateTime = java.time.LocalDateTime.now(); 
            java.sql.Timestamp currentTimestamp = java.sql.Timestamp.valueOf(currentDateTime); 

            messageDAO.insertStudentMessage(false, "student", student.getStudentId(), teacher_id, currentTimestamp, message_subject, message_body);
    %>

    <!-- Success Box with Bootstrap success class -->
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
        <div>
            <strong>Your message was sent successfully!</strong>
        </div>
    </div>

    <!-- Back Button to message form -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher_Controller.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
        </a>
    </div>

    <% }
    }

    if (mark_message_read != null) {
        message_id = Integer.parseInt(message_read_id);
        messageDAO.updateIsReadMessage(message_id);
    %>

    <!-- Success Box with Bootstrap success class -->
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
        <div>
            <strong>Message marked as read!</strong>
        </div>
    </div>

    <!-- Back Button to message form -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/teacher_messages.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back
        </a>
    </div>

    <% } %>
    
    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
