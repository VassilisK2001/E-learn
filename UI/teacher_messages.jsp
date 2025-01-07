<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>

<%
// Get Teacher object from session
Teacher teacher = (Teacher) session.getAttribute("teacherObj");

// Initialize MessageDAO object
MessageDAO messageDAO = new MessageDAO();

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
                        <a class="nav-link"><b>Signed in as <%= teacher.getName()%></b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-4 flex-grow-1">

        <div class="container">
            <h1 class="mb-4">Teacher Messages</h1>

            <%
                Map<Student, List<Message>> conversations = messageDAO.getTeacherConversarions(teacher.getTeacher_id());
            %>

            <%
                // Loop through each student's conversation
                for (Map.Entry<Student, List<Message>> entry : conversations.entrySet()) {
                    Student student = entry.getKey();
                    List<Message> messages = entry.getValue();
            %>

            <!-- Student Section -->
            <div class="mb-4">
                <!-- Display Conversation Title Once -->
                <h5>Conversation with <strong><%= student.getFullName() %></strong></h5>

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
                                <img src="<%=request.getContextPath()%>/elearn/images/<%=senderPhoto%>" alt="<%= message.getSenderType().equals("teacher") ? "Your Photo" : student.getFullName() %>"
                                     class="rounded-circle me-3" style="width: 50px; height: 50px; object-fit: cover;">

                                <div>
                                    <!-- Sender Name and Timestamp -->
                                    <strong><%= message.getSenderType().equals("teacher") ? "You" : student.getFullName() %></strong>
                                    <small class="text-muted">(<%= message.getMessageDate() %>)</small>

                                    <!-- Message Content -->
                                    <div class="alert <%= message.getSenderType().equals("teacher") ? "alert-primary" : "alert-secondary" %>">
                                        <strong>Subject:</strong> <%= message.getMessageSubject() %><br>
                                        <strong>Body:</strong> <%= message.getMessageContent() %>

                                        <!-- Reply Information -->
                                        <% if (originalMessage != null) { %>
                                            <hr>
                                            <small class="text-muted">
                                                Reply to: <strong><%= originalMessage.getSenderType().equals("teacher") ? "You" : student.getFullName() %></strong>
                                                (<%= originalMessage.getMessageSubject() %>)
                                            </small>
                                        <% } %>
                                    </div>
                                </div>
                            </div>

                            <!-- Footer Section -->
                            <% if (message.getSenderType().equals("student") && !message.isReplied()) { %>
                                <div class="card-footer text-end">
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#replyModal"
                                            data-student-id="<%= student.getStudentId() %>" 
                                            data-student-name="<%= student.getFullName() %>" 
                                            data-message-id="<%= message.getMessageId() %>"
                                            data-message-subject="<%= message.getMessageSubject() %>">
                                        Reply
                                    </button>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Horizontal Line to Separate Conversations -->
            <hr class="my-4">

            <%
                }
            %>

            <!-- Reply Modal -->
            <div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="<%= request.getContextPath() %>/elearn/UI/sendMessageController.jsp" method="POST">
                            <div class="modal-header">
                                <h5 class="modal-title" id="replyModalLabel">Reply to <span id="studentName"></span></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" id="studentId" name="studentId">
                                <input type="hidden" id="messageId" name="messageId">
                                <input type="hidden" id="teacherReply" name="teacherReply" value="1">
                                <div class="mb-3">
                                    <label for="replySubject" class="form-label">Subject</label>
                                    <!-- Pre-fill subject with "Re: <original subject>" and make it readonly -->
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

        </div>

        <!-- Back Button to message form -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp" class="btn btn-outline-primary">
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
            const studentId = button.getAttribute('data-student-id');
            const messageId = button.getAttribute('data-message-id');
            const studentName = button.getAttribute('data-student-name');
            const originalSubject = button.getAttribute('data-message-subject'); // Retrieve the original subject

            // Debugging: Log the original subject to the console
            console.log('Original Subject:', originalSubject);

            replyModal.querySelector('#studentId').value = studentId;
            replyModal.querySelector('#messageId').value = messageId;
            replyModal.querySelector('#studentName').textContent = studentName;

            // Pre-fill the subject with "Re: <original subject>"
            replyModal.querySelector('#replySubject').value = originalSubject ;
        });
    </script>
</body>
</html>
