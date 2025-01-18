<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="elearn_classes.*" %>
<%@ page import="com.google.gson.Gson" %>
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
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Get student object from session
    Student student = (Student) session.getAttribute("studentObj");

    // Get teacher results from session
    List<Teacher> teacher_results = (List<Teacher>) session.getAttribute("teacher_results");
    String course = (String) session.getAttribute("course");
    List<String> specializations = (List<String>) session.getAttribute("specializations");

    if (teacher_results !=  null) {
        session.removeAttribute("teacher_results");
    }

    if (course != null) {
        session.removeAttribute("course");
    }

    if (specializations != null) {
        session.removeAttribute("specializations");
    }

    // Create CourseDAO object
    CourseDAO courseDAO = new CourseDAO();

    // Fetch data from the database
    List<String> courseCategories = courseDAO.getCourseCategoryTitles();
    List<String> courses = courseDAO.getCourseTitles();

    // Convert lists to JSON using Gson library
    Gson gson = new Gson();
    String coursesJson = gson.toJson(courses);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find a Teacher</title>
    <!-- Include Bootstrap and noUiSlider CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Header -->
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

    <!-- Main Content -->
    <main class="container my-5 flex-grow-1">
        <!-- The form now encloses the entire carousel -->
        <form action="<%=request.getContextPath()%>/elearn/UI/find_teacher_Controller.jsp" method="POST">
            <div id="teacherSearchCarousel" class="carousel slide mx-auto" style="max-width: 600px;" data-bs-interval="false">
                <div class="carousel-inner shadow-lg p-4 rounded bg-white">

                    <!-- Slide 1: Course Information -->
                    <div class="carousel-item active">
                        <h3 class="mb-4">Course Information</h3>
                        <div class="mb-3">
                            <label for="courseCategory" class="form-label">Course Category</label>
                            <select id="courseCategory" name="courseCategory" class="form-select" required>
                                <option value="">Select Category</option>
                                <% for (String category : courseCategories) { %>
                                    <option value="<%= category %>"><%= category %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="mb-3 position-relative">
                            <label for="courseTitle" class="form-label">Course Title</label>
                            <input type="text" class="form-control" id="courseTitle" name="courseTitle" placeholder="Enter course title" required oninput="fetchCourseSuggestions(this.value)">
                            <div id="courseSuggestions" class="list-group position-absolute w-100">
                                <!-- Suggestions will be dynamically populated here -->
                            </div>
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-primary mt-4" onclick="nextSlide()">Next</button>
                        </div>
                    </div>

                    <!-- Slide 2: Teacher Filters -->
                    <div class="carousel-item">
                        <h3 class="mb-4">Teacher Filters</h3>
                        <div class="mb-3">
                            <label for="teacherSpecialty" class="form-label">Teacher Specializations (Hold Ctrl key to select)</label>
                            <select class="form-select" id="teacherSpecialty" name="teacherSpecialty" multiple onchange="addTag('teacherSpecialty', 'specialtyTags')">
                                <% for (String category : courseCategories) { %>
                                    <option value="<%= category %>"><%= category %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <h5>Selected Specializations:</h5>
                            <div id="specialtyTags"></div>
                        </div>
                        <div class="mb-3">
                            <label for="experienceRange" class="form-label">Years of Experience range</label>
                            <div class="d-flex gap-2">
                                <input type="text" class="form-control" id="minYears" name="minYears" placeholder="Minimum years of experience"  required>
                                <input type="text" class="form-control" id="maxYears" name="maxYears" placeholder="Maximum years of experience"  required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="priceRange" class="form-label">Price range (&euro;)</label>
                            <div class="d-flex gap-2">
                                <input type="text" class="form-control" id="minPrice" name="minPrice"  placeholder="Minimum price per hour" required>
                                <input type="text" class="form-control" id="maxPrice" name="maxPrice"  placeholder="Maximum price per hour" required>
                            </div>
                        </div>

                        <!-- Hidden Field for Tags -->
                        <input type="hidden" id="teacherSpecializationsHidden" name="teacherSpecializationsTags">

                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-secondary" onclick="prevSlide()">Back</button>
                            <button type="button" class="btn btn-primary" onclick="nextSlide()">Next</button>
                        </div>
                    </div>

                    <!-- Slide 3: Submit -->
                    <div class="carousel-item">
                        <h3 class="mb-4">Submit Criteria</h3>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-secondary" onclick="prevSlide()">Back</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Back Button Below Teacher Cards -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0"><b>© 2024 E-Learn. All rights reserved.</b></p>
    </footer>

    <!-- Include Bootstrap, noUiSlider, and your JavaScript file -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const coursesData = <%= coursesJson %>;

        if (performance.navigation.type === performance.navigation.TYPE_BACK_FORWARD) {
            location.reload(true); // Force a reload from the server
        }
    </script>
    <script src="<%=request.getContextPath()%>/elearn/js/find_teacher.js"></script>
</body>
</html>
