<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="AppError.jsp" %>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>

<%
if((session.getAttribute("studentObj") == null)) { 
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

// Get Student object from session
Student student = (Student) session.getAttribute("studentObj");

// Initialize MessageDAO object
MessageDAO messageDAO = new MessageDAO();

// Check for unread messages
String unreadMessagesAlert = null;
try {
    messageDAO.hasUnreadMessagesStudent(student.getStudentId());
} catch (Exception e) {
    unreadMessagesAlert = e.getMessage(); // Capture the exception message
}

// Get conversations for the student
Map<Teacher, List<Message>> conversations = messageDAO.getStudentConversarions(student.getStudentId());
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
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">

        <%-- Check if there are conversations --%>
        <% if (conversations.isEmpty()) { %>
            <div class="alert alert-info d-flex align-items-center" role="alert">
                <i class="fas fa-info-circle me-2"></i>
                <strong>You do not have any conversations</strong>
            </div>
        <% } else { %>

        <div class="container">

            <!-- Display unread messages alert if exists -->
            <% if (unreadMessagesAlert != null) { %>
                <div class="alert alert-info d-flex align-items-center" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                    <span><%= unreadMessagesAlert %></span>
                </div>
            <% } %>

            <h1 class="mb-4">Student Messages</h1>

                <%-- Loop through each teacher's conversation --%>
                <%
                for (Map.Entry<Teacher, List<Message>> entry : conversations.entrySet()) {
                    Teacher teacher = entry.getKey();
                    List<Message> messages = entry.getValue();
                %>

                <!-- Student Section -->
                <div class="mb-4">
                    <!-- Display Conversation Title Once -->
                    <h5>Conversation with <strong><%= teacher.getName() %></strong></h5>

                    <!-- Messages Section -->
                    <div class="card">
                        <div class="card-body">
                            <% for (Message message : messages) { 
                                String senderPhoto = message.getSenderType().equals("teacher") 
                                    ? teacher.getPhoto() // Assuming `teacher` has a `getPhoto()` method
                                    : student.getPhotoUrl(); // Assuming `student` has a `getPhoto()` method

                                // Find the original message if it's a reply
                                Message originalMessage = messageDAO.findOriginalMessage(messages, message.getReplyToMessageId());
                            %>
                                <div class="mb-3 d-flex">
                                    <!-- Sender Photo -->
                                    <img src="<%=request.getContextPath()%>/elearn/images/<%=senderPhoto%>" alt="<%= message.getSenderType().equals("student") ? "Your Photo" : teacher.getName() %>"
                                         class="rounded-circle me-3" style="width: 50px; height: 50px; object-fit: cover;">

                                    <div>
                                        <!-- Sender Name and Timestamp -->
                                        <strong><%= message.getSenderType().equals("student") ? "You" : teacher.getName() %></strong>
                                        <small class="text-muted">(<%= message.getMessageDate() %>)</small>

                                        <!-- Message Content -->
                                        <div class="alert <%= message.getSenderType().equals("student") ? "alert-primary" : "alert-secondary" %>">
                                            <strong>Subject:</strong> <%= message.getMessageSubject() %><br>
                                            <strong>Body:</strong> <%= message.getMessageContent() %>

                                            <!-- Reply Information -->
                                            <% if (originalMessage != null) { %>
                                                <hr>
                                                <small class="text-muted">
                                                    Reply to: <strong><%= originalMessage.getSenderType().equals("student") ? "You" : teacher.getName() %></strong>
                                                    (<%= originalMessage.getMessageSubject() %>)
                                                </small>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>

                        <!-- Footer Section with Buttons -->
                        <div class="card-footer text-end">
                            <% for (Message message : messages) { %>
                                <% if (message.getSenderType().equals("teacher")) { %>
                                    <% if (message.getIsRead()) { %>
                                        <button class="btn btn-success btn-sm me-2" disabled>
                                            <i class="fas fa-check-circle"></i> Read
                                        </button>
                                    <% } else { %>
                                        <form action="<%= request.getContextPath() %>/elearn/UI/sendMessageController.jsp" method="POST" class="d-inline">
                                            <input type="hidden" name="markMessageRead" value="1">
                                            <input type="hidden" name="messageId" value="<%= message.getMessageId() %>">
                                            <button type="submit" class="btn btn-secondary btn-sm me-2">Mark as Read</button>
                                        </form>
                                    <% } 
                                    if (!message.isReplied()) { %>
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#replyModal"
                                            data-teacher-id="<%= teacher.getTeacher_id() %>" 
                                            data-teacher-name="<%= teacher.getName() %>" 
                                            data-message-id="<%= message.getMessageId() %>"
                                            data-message-subject="<%= message.getMessageSubject() %>">
                                        Reply
                                    </button>
                                    <% } %>
                                <% } %>
                            <% } %>
                        </div>

                    </div>
                </div>

                <!-- Horizontal Line to Separate Conversations -->
                <hr class="my-4">

                <% } %>
            <% } %>

        </div>

        <!-- Reply Modal -->
        <div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="<%= request.getContextPath() %>/elearn/UI/sendMessageController.jsp" method="POST">
                        <div class="modal-header">
                            <h5 class="modal-title" id="replyModalLabel">Reply to <span id="teacherName"></span></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="teacherId" name="teacherId">
                            <input type="hidden" id="messageId" name="messageId">
                            <input type="hidden" id="studentReply" name="studentReply" value="1">
                            <div class="mb-3">
                                <label for="replySubject" class="form-label">Subject</label>
                                <input type="text" id="replySubject" name="replySubject" class="form-control" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="replyBody" class="form-label">Message</label>
                                <textarea id="replyBody" name="replyBody" class="form-control" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Back Button to message form -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>

    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const replyModal = document.getElementById('replyModal');
        replyModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const teacherName = button.getAttribute('data-teacher-name');
            const teacherId = button.getAttribute('data-teacher-id');
            const messageId = button.getAttribute('data-message-id');
            const messageSubject = button.getAttribute('data-message-subject');

            document.getElementById('teacherName').textContent = teacherName;
            document.getElementById('teacherId').value = teacherId;
            document.getElementById('messageId').value = messageId;
            // Conditional check for the message subject
            const replySubject = messageSubject.startsWith("Re") 
                ? messageSubject 
                : "Re: " + messageSubject;

            document.getElementById('replySubject').value = replySubject;
        });
    </script>

</body>
</html>
