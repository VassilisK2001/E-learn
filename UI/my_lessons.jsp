<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
<%@ page import="java.util.*"%>
<%@ page errorPage="AppError.jsp" %>


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

// Initialize LessonRequestDAO object and lessons list 
LessonReqDAO lessonDAO = new LessonReqDAO();
List<LessonRequest> lessons = new ArrayList<LessonRequest>();

// Initialize TeacherDAO object
TeacherDAO teacherDAO = new TeacherDAO();

// Initialize teacher object
Teacher teacher = null;

// Initialize variable for error checking
boolean lesson_req_error = false;

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Lessons</title>
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

    <%
    try {
        lessons = lessonDAO.getLessonRequests(student.getStudentId());
    } catch(Exception e) {
        lesson_req_error = true;
    %>

        <!-- Info Alert Box -->
        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="fas fa-info-circle fa-2x me-3"></i>
            <div> <%= e.getMessage()%> </div>
        </div>

        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>

    <%
    } 
    if (!lesson_req_error) {
    %>
        <h1 class="mb-4">My Lessons</h1>

        <!-- Lessons Cards -->
        <div class="row">

        <% for(LessonRequest lesson: lessons) { 
            teacher = teacherDAO. getTeacherFromName(lesson.getSent_to());
        %>

            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/images/<%=teacherDAO.getTeacherPhoto(lesson.getSent_to())%>" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Lesson Info -->
                        <div class="col-8">
                            <div class="card-body">
                                <h5 class="card-title"><%= lesson.getSent_to()%></h5>
                                <p class="card-text"><strong>Course:</strong> <%= lesson.getCourse()%></p>
                                <p class="card-text"><strong>Lesson Date:</strong> <%= lesson.getSchedule_date()%></p>
                                <p class="card-text"><strong>Status:</strong>
                                    <% if(lesson.getRequest_status().equals("pending")) { %> 
                                    <button class="btn btn-info"> Pending</button>
                                    <% } else if (lesson.getRequest_status().equals("accepted")) { %>
                                    <button class="btn btn-success"> Accepted</button>
                                    <% } else { %>
                                    <button class="btn btn-danger"> Rejected</button>
                                    <% } %>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer text-center">
                        <button class="btn btn-outline-secondary contact-btn"
                            data-bs-toggle="modal" 
                            data-bs-target="#contactTeacherModal" 
                            data-teacher-id="<%= teacher.getTeacher_id() %>" 
                            data-teacher-name="<%= teacher.getName() %>">
                            Contact Teacher 
                        </button>
                    </div>
                </div>
            </div>

            <% } %>  

        </div>

        <!-- Contact Teacher Modal -->
        <div class="modal fade" id="contactTeacherModal" tabindex="-1" aria-labelledby="contactTeacherModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="<%=request.getContextPath()%>/elearn/UI/sendMessageController.jsp" method="POST">
                        <div class="modal-header">
                            <h5 class="modal-title" id="contactTeacherModalLabel">Contact Teacher</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <input type="hidden" id="studentMessage" name="studentMessage" value="1">
                            <input type="hidden" id="mylessons" name="mylessons" value="1">
                            <input type="hidden" id="teacherId" name="teacherId" value="">

                            <!-- Teacher Full Name -->
                            <div class="mb-3">
                                <label for="teacherName" class="form-label">Teacher Full Name</label>
                                <input type="text" class="form-control" id="teacherFullName" name="teacherName" readonly>
                            </div>
                            <!-- Message Subject -->
                            <div class="mb-3">
                                <label for="emailSubject" class="form-label">Message Subject</label>
                                <input type="text" class="form-control" id="messageSubject" name="messageSubject" maxlength="100" placeholder="Enter subject (up to 5 words)" required>
                            </div>
                            <!-- Message Body -->
                            <div class="mb-3">
                                <label for="emailBody" class="form-label">Message Body</label>
                                <textarea class="form-control" id="messageBody" name="messageBody" rows="4" maxlength="200" placeholder="Enter your message (up to 20 words)" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Send Message</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Home
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
    <script> 
    document.addEventListener('click', function (event) {
        // Handle Contact Teacher button
        if (event.target.matches('.contact-btn')) {
            const teacherId = event.target.getAttribute('data-teacher-id');
            const teacherName = event.target.getAttribute('data-teacher-name');
            
            
            // Populate Contact Teacher Modal fields
            document.getElementById('teacherId').value = teacherId;
            document.getElementById('teacherFullName').value = teacherName;
        }
    });  
    </script>
</body>
</html>
