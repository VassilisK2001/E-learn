<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="elearn_classes.*" %>
<%@ page errorPage="AppError.jsp" %>


<%
if((session.getAttribute("studentObj") == null && session.getAttribute("teacherObj") == null)) { 
    request.setAttribute("message","You are not authorized to access this page. Please sign in.");   
%>
            
<jsp:forward page="signin.jsp"/>

<% } 

// Set session timeout to 15 minutes
int sessionTimeoutSeconds = 15 * 60;
session.setMaxInactiveInterval(sessionTimeoutSeconds);

// Get student object from session
Student student = (Student) session.getAttribute("studentObj");

// Get teacher results from session
List<Teacher> teacher_results = (List<Teacher>) session.getAttribute("teacher_results");
String course = (String) session.getAttribute("course");
List<String> specializations = (List<String>) session.getAttribute("specializations"); 

// Initialize CourseDAO object
CourseDAO courseDAO = new CourseDAO();

// Initialize TeacherDAO object
TeacherDAO teacherDAO = new TeacherDAO();

String course_category = "";
String course_title = "";
String teacher_specialties_tags = "";
String min_years_exp = "";
String max_years_exp = "";
String min_price = "";
String max_price = "";

if (teacher_results == null) {
    // Get form data
    course_category = request.getParameter("courseCategory");
    course_title = request.getParameter("courseTitle");
    teacher_specialties_tags = request.getParameter("teacherSpecializationsTags");
    min_years_exp = request.getParameter("minYears");
    max_years_exp = request.getParameter("maxYears");
    min_price = request.getParameter("minPrice");
    max_price = request.getParameter("maxPrice");
}

// Variables for validation and error messages 
List<String> errorMessages = new ArrayList<String>();
int countErrors = 0;
List<String> teacher_specializations = new ArrayList<String>();
int min_exp = 0; 
int max_exp = 0;
double minimum_price = 0;
double maximum_price = 0;
boolean invalid_exp = false;
boolean invalid_price = false;
boolean teacher_error = false;

List<Teacher> teachers = new ArrayList<Teacher>();
%>


<%!

// Method to convert a comma separated String into a list
public static List<String> convertStringToList(String input) {
        List<String> result = new ArrayList<String>();

        // Split the string by commas
        String[] items = input.split(",");

        // Iterate through the array and apply filtering logic
        for (String item : items) {
            result.add(item);
        }
        return result;
}

// Method to check if a string can be converted to an integer
public static boolean isInteger(String str) {
    try {
        // Attempt to parse the string as an integer
        Integer.parseInt(str);
        return true;  // If parsing succeeds, it's a valid integer
    } catch (NumberFormatException e) {
        return false; // If parsing fails, it's not a valid integer
    }
}

// Method to check if a string can be converted to a double
public static boolean isDouble(String str) {
    if (str == null || str.trim().isEmpty()) {
        return false; // Null or empty strings cannot be converted to double
    }
    try {
        Double.parseDouble(str);
        return true; // Conversion succeeded
    } catch (NumberFormatException e) {
        return false; // Conversion failed
    }
}

public static int countDecimals(double number) {
    // Convert the double to a string
    String text = String.valueOf(number);

    // Check if it contains a decimal point
    if (text.contains(".")) {
        // Split the number into the integer and decimal parts
        String[] parts = text.split("\\.");
        
        // Get the decimal part and remove trailing zeros
        String decimalPart = parts[1].replaceAll("0+$", "");
        
        // Return the length of the decimal part
        return decimalPart.length();
    }

    // No decimal point means 0 decimal places
    return 0;
}
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link"><b>Signed in as <%= student.getFullName() %></b></a>
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
        // Validation checks for all fields
        if (teacher_results == null) {

            try {
                courseDAO.checkCourseExists(course_title);
            } catch(Exception e) {
                countErrors++;
                errorMessages.add(e.getMessage());
            }

            // Populate teacher specializations list
            teacher_specializations = convertStringToList(teacher_specialties_tags);

            if (teacher_specializations.size() > 5) {
                countErrors++;
                errorMessages.add("You can select up to <b> 5 teacher specializations.</b>");
            }

            if (!isInteger(min_years_exp) || !isInteger(max_years_exp)) {
                countErrors++;
                invalid_exp = true;
            } else {
                min_exp = Integer.parseInt(min_years_exp);
                max_exp = Integer.parseInt(max_years_exp);
                if (min_exp <= 0 || min_exp >= 70 || max_exp <= 0 || max_exp >= 70) {
                    countErrors++;
                    invalid_exp = true;
                } else {
                    if (min_exp >= max_exp) {
                        countErrors++;
                        errorMessages.add("<b>Minimum years of experience</b> must be lower than <b>maximum years of experience</b>.");
                    }
                }
            }

            if (invalid_exp) {
                errorMessages.add("The value for <b> years of experience </b> must be a positive integer lower than 70");
            }
           
        
            if (!isDouble(min_price) || !isDouble(max_price)) {
                countErrors++;
                invalid_price = true;
            } else {
                minimum_price = Double.parseDouble(min_price);
                maximum_price = Double.parseDouble(max_price);
                if (minimum_price <= 0 || maximum_price <= 0 || minimum_price > 100 || maximum_price > 100 || countDecimals(minimum_price) > 2 || countDecimals(maximum_price) > 2 ) {
                    countErrors++;
                    invalid_price = true;
                } else {
                    if (minimum_price >= maximum_price) {
                        countErrors++;
                        errorMessages.add("<b>Maximum price</b> must be greater than <b>minimum price</b>.");
                    }
                }
            }

            if (invalid_price) {
                errorMessages.add("<b>Price</b> value must be a positive number up to 100 euros with up to 2 decimals.");
            }

            if (countErrors !=  0) { 
    %>

        <!-- Alert Box for General Error -->
        <div class="alert alert-danger" role="alert">
            <strong>Your form has errors.</strong>
        </div>

        <!-- Card to display detailed errors -->
        <div class="card">
            <div class="card-header">
                <strong>Search Teacher Form Errors</strong>
            </div>
            <div class="card-body">
                <ol class="list-group list-group-numbered">
                    <% for (String errorMessage : errorMessages) { %>
                        <li class="list-group-item"><%= errorMessage %></li>
                    <% } %>
                </ol>
            </div>
        </div>

        <!-- Back Button to Signup form -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Form
            </a>
        </div>

    <%  } else {
        
        try {
            teachers = teacherDAO.getTeacherResults(course_category, course_title, teacher_specializations, min_exp, max_exp, minimum_price, maximum_price);   
        } catch(Exception e) {
            teacher_error = true;    
    %>

        <!-- Warning Box for No Available Teachers -->
        <div class="alert alert-warning d-flex align-items-center justify-content-center text-center" role="alert">
            <i class="fas fa-exclamation-triangle fa-lg me-2"></i>
            <span><b><%= e.getMessage()%></b></span>
        </div>

    <%  }  
        if (!teacher_error) { 
            session.setAttribute("teacher_results", teachers);   
            session.setAttribute("course", course_title);   
            session.setAttribute("specializations", teacher_specializations);   
    %>

        <h1 class="mb-4">Available Teachers</h1>

        <!-- Teacher Profile Cards -->
        <div class="row">

            <% for (Teacher teacher: teachers) { %>

            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/images/<%=teacher.getPhoto()%>" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel<%= teacher.getTeacher_id() %>" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <% 
                                                // If teacher has all specializations selected by user, then display "Recommended" badge 
                                                if (teacher.getTeacher_specializations().containsAll(teacher_specializations)) { %>
                                                <span class="badge bg-primary ms-2 d-flex align-items-center text-truncate" style="max-width: 150px;">
                                                    <i class="fa-solid fa-check me-1"></i>Recommended
                                                </span>
                                                <% } %>
                                                <span class="mt-2 d-block">
                                                    <%= teacher.getName() %>
                                                </span>
                                            </h5>     
                                            <p class="card-text"><strong>Age:</strong> <%=teacher.getAge()%></p>
                                            <p class="card-text"><%= teacher.getDesc()%></p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel<%= teacher.getTeacher_id() %>" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specializations:</strong></p>
                                            <% for(String specialization: teacher.getTeacher_specializations()) { %>
                                            <div>
                                                <span class="badge bg-secondary me-2"><%= specialization%></span>
                                            </div>
                                            <% } %>
                                            <p><strong>Specialization courses:</strong></p>
                                            <% for(String crs: teacher.getSpecialization_courses()) { %>
                                            <div>
                                                <span class="badge bg-secondary me-2"><%= crs%></span>
                                            </div>
                                            <% } %>
                                            <p class="mt-2"><strong>Experience:</strong> <%= teacher.getYears_of_experience()%> years</p>
                                            <p><strong>Price Range:</strong> &euro;<%= teacher.getMin_price()%> - &euro;<%= teacher.getMax_price()%></p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel<%= teacher.getTeacher_id() %>" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <button class="btn btn-outline-primary schedule-btn"
                            data-bs-toggle="modal" 
                            data-bs-target="#scheduleModal" 
                            data-teacher-id="<%= teacher.getTeacher_id()%>" 
                            data-teacher-name="<%= teacher.getName()%>">
                            Schedule Lesson
                        </button>
                        <button class="btn btn-outline-primary contact-btn"
                            data-bs-toggle="modal" 
                            data-bs-target="#contactTeacherModal" 
                            data-teacher-id="<%= teacher.getTeacher_id() %>" 
                            data-teacher-name="<%= teacher.getName() %>">
                            Contact Teacher
                        </button>
                    </div>
                </div>
            </div>

        <% }  %>

        </div>

        <%  } %>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to search teacher form
            </a>
        </div>
    <%  }   %>

        <!-- Send lesson request modal -->
        <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="scheduleModalLabel">Schedule Lesson</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="scheduleForm" method="post" action="<%=request.getContextPath()%>/elearn/UI/submit_lesson_request.jsp">
                            <input type="hidden" id="teacherIdInput" name="teacher_id" value="">
                            <input type="hidden" name="student_id" value="<%= student.getStudentId() %>">
                            <input type="hidden" name="course_title" value="<%= course_title %>">
                            <div class="mb-3">
                                <label for="teacherName" class="form-label">Teacher</label>
                                <input type="text" id="teacherName" name="teacherName" class="form-control" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="scheduleDate" class="form-label">Date</label>
                                <input type="date" id="scheduleDate" name="scheduleDate" class="form-control" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
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

    <% } else {  %>

    <h1 class="mb-4">Available Teachers</h1>

        <!-- Teacher Profile Cards -->
        <div class="row">

            <% for (Teacher teacher: teacher_results) { %>

            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/images/<%=teacher.getPhoto()%>" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel<%= teacher.getTeacher_id() %>" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <% 
                                                // If teacher has all specializations selected by user, then display "Recommended" badge 
                                                if (teacher.getTeacher_specializations().containsAll(specializations)) { %>
                                                <span class="badge bg-primary ms-2 d-flex align-items-center text-truncate" style="max-width: 150px;">
                                                    <i class="fa-solid fa-check me-1"></i>Recommended
                                                </span>
                                                <% } %>
                                                <span class="mt-2 d-block">
                                                    <%= teacher.getName() %>
                                                </span>
                                            </h5>     
                                            <p class="card-text"><strong>Age:</strong> <%=teacher.getAge()%></p>
                                            <p class="card-text"><%= teacher.getDesc()%></p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel<%= teacher.getTeacher_id() %>" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specializations:</strong></p>
                                            <% for(String specialization: teacher.getTeacher_specializations()) { %>
                                            <div>
                                                <span class="badge bg-secondary me-2"><%= specialization%></span>
                                            </div>
                                            <% } %>
                                            <p><strong>Specialization courses:</strong></p>
                                            <% for(String course_name: teacher.getSpecialization_courses()) { %>
                                            <div>
                                                <span class="badge bg-secondary me-2"><%= course_name%></span>
                                            </div>
                                            <% } %>
                                            <p class="mt-2"><strong>Experience:</strong> <%= teacher.getYears_of_experience()%> years</p>
                                            <p><strong>Price Range:</strong> &euro;<%= teacher.getMin_price()%> - &euro;<%= teacher.getMax_price()%></p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel<%= teacher.getTeacher_id() %>" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <button class="btn btn-outline-primary schedule-btn"
                            data-bs-toggle="modal" 
                            data-bs-target="#scheduleModal" 
                            data-teacher-id="<%= teacher.getTeacher_id()%>" 
                            data-teacher-name="<%= teacher.getName()%>">
                            Schedule Lesson
                        </button>
                        <button class="btn btn-outline-primary contact-btn"
                            data-bs-toggle="modal" 
                            data-bs-target="#contactTeacherModal" 
                            data-teacher-id="<%= teacher.getTeacher_id() %>" 
                            data-teacher-name="<%= teacher.getName() %>">
                            Contact Teacher
                        </button>
                    </div>
                </div>
            </div>

        <% }  %>

        </div>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/find_teacher.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to search teacher form
            </a>
        </div>

         <!-- Modal to send lesson request -->
        <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="scheduleModalLabel">Schedule Lesson</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="scheduleForm" method="post" action="<%=request.getContextPath()%>/elearn/UI/submit_lesson_request.jsp">
                            <input type="hidden" id="teacherIdInput" name="teacher_id" value="">
                            <input type="hidden" name="student_id" value="<%= student.getStudentId() %>">
                            <input type="hidden" name="course_title" value="<%= course %>">
                            <div class="mb-3">
                                <label for="teacherName" class="form-label">Teacher</label>
                                <input type="text" id="teacherName" name="teacherName" class="form-control" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="scheduleDate" class="form-label">Date</label>
                                <input type="date" id="scheduleDate" name="scheduleDate" class="form-control" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
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
                            <input type="hidden" id="teacherId" name="teacherId" value="">
                            <!-- Teacher Full Name -->
                            <div class="mb-3">
                                <label for="teacherName" class="form-label">Teacher</label>
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
                            <button type="submit" class="btn btn-primary">Send message</button>
                        </div>
                    </form>
                </div>
            </div>
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
        if (performance.navigation.type === performance.navigation.TYPE_BACK_FORWARD) {
            location.reload(true); // Force a reload from the server
        }

        document.addEventListener('click', function (event) {
            // Handle Schedule Lesson button
            if (event.target.matches('.schedule-btn')) {
                const teacherId = event.target.getAttribute('data-teacher-id');
                const teacherName = event.target.getAttribute('data-teacher-name');
                
                // Populate Schedule Modal fields
                document.getElementById('teacherIdInput').value = teacherId;
                document.getElementById('teacherName').value = teacherName;
            }

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
    <script src="<%=request.getContextPath()%>/elearn/js/schedule_lesson.js"></script> 
</body>
</html>
