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

// Get Teacher object from session
Teacher teacher = (Teacher) session.getAttribute("teacherObj");

//Initialize LessonReqDAO object
LessonReqDAO lessonreqDAO = new LessonReqDAO();

// Initialize StudentDAO and Student objects
StudentDAO studentDAO = new StudentDAO();
Student student = null;

// Initialize list with teacher lesson requests
List<LessonRequest> lesson_requests = new ArrayList<LessonRequest>();

// Variable for checking error
boolean req_error = false;

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

    <%  try {
        lesson_requests = lessonreqDAO.getTeacherLessonRequests(teacher.getTeacher_id());
    } catch(Exception e) { 
        req_error = true;
    %>

        <!-- Info Alert Box -->
        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="fas fa-info-circle fa-2x me-3"></i>
            <div> <%= e.getMessage()%> </div>
        </div>

        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>


    <% }
    if(!req_error) { 
    %>
        <h1 class="mb-4">Lesson Requests</h1>

        <!-- Lesson Request Cards -->
        <div class="row">
        <% for (LessonRequest req: lesson_requests) { 
            student = studentDAO.getStudentDetails(studentDAO.getStudentIdByName(req.getSent_from())); 
        %>

            <!-- Lesson Request 1: Pending -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Student Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/images/<%= student.getPhotoUrl()%>" class="img-fluid rounded-start" alt="Student Photo">
                        </div>

                        <!-- Right Side: Carousel with Student Info and Lesson Info -->
                        <div class="col-8">
                            <div id="studentCarousel<%=req.getLesson_req_id()%>" class="carousel slide" data-bs-ride="false" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Student Info -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title"><%= req.getSent_from()%></h5>
                                            <p class="card-text"><strong>Age:</strong> <%= student.getAge()%></p>
                                            <p class="card-text"><%= student.getDescription()%></p>
                                            <button class="btn btn-primary mt-3" 
                                                data-bs-target="#studentCarousel<%=req.getLesson_req_id()%>"
                                                data-bs-slide="next">Next
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Lesson Info -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Course:</strong> <%= req.getCourse()%></p>
                                            <p><strong>Lesson Date:</strong> <%= req.getSchedule_date()%></p>
                                            <div class="mb-3">
                                                <form action="<%=request.getContextPath()%>/elearn/UI/updateLessonRequest.jsp" method="POST">
                                                    <label for="status<%=req.getLesson_req_id()%>" class="form-label">Update request state</label>
                                                    <select class="form-select" 
                                                        id="status<%=req.getLesson_req_id()%>" 
                                                        name="status" 
                                                        data-initial-value="<%=req.getRequest_status()%>" 
                                                        onchange="updateStatus('status<%=req.getLesson_req_id()%>')">
                                                        <% if(req.getRequest_status().equals("pending")) { %>
                                                        <option value="pending" selected>Pending</option>
                                                        <option value="accepted">Accepted</option>
                                                        <option value="rejected">Rejected</option>
                                                        <% } else if (req.getRequest_status().equals("accepted")) { %>
                                                        <option value="accepted" selected>Accepted</option>
                                                        <option value="rejected">Rejected</option>
                                                        <% } else { %>
                                                        <option value="rejected" selected>Rejected</option>
                                                        <option value="accepted">Accepted</option>
                                                        <% } %>
                                                    </select>

                                                    <!-- Hidden Input to Pass Additional Data -->
                                                    <input type="hidden" name="lessonReqId" value="<%=req.getLesson_req_id()%>">

                                            </div>
                                            <p>Status: <span id="statusValue<%=req.getLesson_req_id()%>"><%= req.getRequest_status()%></span></p>
                                           <button class="btn btn-secondary mt-3" 
                                                data-bs-target="#studentCarousel<%=req.getLesson_req_id()%>"
                                                data-bs-slide="prev">Back
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer: Conditional Buttons -->
                    <div class="card-footer text-center">
                        <button type="submit" id="submitBtn<%=req.getLesson_req_id()%>" class="btn btn-primary d-none">Submit</button>
                        </form>
                         <button class="btn btn-outline-secondary contact-btn"
                            data-bs-toggle="modal" 
                            data-bs-target="#contactStudentModal" 
                            data-student-id="<%= student.getStudentId() %>" 
                            data-student-name="<%= student.getFullName() %>">
                            Contact Student
                        </button>
                    </div>
                </div>
            </div>

            <% } %>

        </div>

         <!-- Contact Student Modal -->
        <div class="modal fade" id="contactStudentModal" tabindex="-1" aria-labelledby="contactStudentModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="<%=request.getContextPath()%>/elearn/UI/sendMessageController.jsp" method="POST">
                        <div class="modal-header">
                            <h5 class="modal-title" id="contactStudentModalLabel">Contact Student</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <input type="hidden" id="teacherMessage" name="teacherMessage" value="1">
                            <input type="hidden" id="studentId" name="studentId" value="">

                            <!-- Student Full Name -->
                            <div class="mb-3">
                                <label for="studentName" class="form-label">Student Full Name</label>
                                <input type="text" class="form-control" id="studentFullName" name="studentName" readonly>
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
            <a href="<%=request.getContextPath()%>/elearn/UI/home_teacher.jsp" class="btn btn-outline-primary">
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
    <script src="<%=request.getContextPath()%>/elearn/js/my_requests.js"></script>
    <script>  
        document.addEventListener('click', function (event) {
            // Handle Contact Student button
            if (event.target.matches('.contact-btn')) {

                const studentId = event.target.getAttribute('data-student-id');
                const studentName = event.target.getAttribute('data-student-name');
                
                
                // Populate Contact Student Modal fields
                document.getElementById('studentId').value = studentId;
                document.getElementById('studentFullName').value = studentName;
            }
        });
    </script>

</body>
</html>
