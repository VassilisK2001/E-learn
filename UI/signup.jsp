<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="elearn_classes.*" %>
<%@ page import="com.google.gson.Gson" %>

<%
    // Create CourseDAO object
    CourseDAO courseDAO = new CourseDAO();

    // Fetch data from the database
    List<String> courses = courseDAO.getCourseTitles();
    List<String> specializations = courseDAO.getCourseCategoryTitles();
    List<String> subjects = courseDAO.getCourseCategoryTitles();

    // Convert lists to JSON using Gson library
    Gson gson = new Gson();
    String coursesJson = gson.toJson(courses);
    String specializationsJson = gson.toJson(specializations);
    String subjectsJson = gson.toJson(subjects);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/slider_styles.css">
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
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/elearn/UI/signup.jsp"><b>Sign Up</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signin.jsp"><b>Sign In</b></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <main class="container my-5 flex-grow-1">
        <form action="signupController.jsp" method="post" enctype="multipart/form-data">
        <!-- Insert the box with the request message here  -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        <div id="signupCarousel" class="carousel slide mx-auto" style="max-width: 600px;" data-bs-interval="false">
            <div class="carousel-inner shadow-lg p-4 rounded bg-white">
                <!-- Slide 1: Personal Information -->
                <div class="carousel-item active">
                    <h3 class="mb-4">Personal Information</h3>
                        <div class="mb-3">
                            <label for="photo" class="form-label">Photo</label>
                            <input type="file" class="form-control" id="photo" name="photo" accept="image/*" required>
                        </div>
                        <div class="mb-3">
                            <label for="fullname" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullname" name="fullname" required>
                        </div>
                        <div class="mb-3">
                            <label for="age" class="form-label">Age</label>
                            <input type="text" class="form-control" id="age" name="age" required>
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <select class="form-select" id="role" name="role" required onchange="adjustSecondSlide()">
                                <option value="">Select your role</option>
                                <option value="student">Student</option>
                                <option value="teacher">Teacher</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary mt-4" onclick="nextSlide()">Next</button>
                        
                        <!-- Hidden Fields for Tags -->
                        <input type="hidden" id="subjectsOfInterestHidden" name="subjectsOfInterestTags">
                        <input type="hidden" id="teacherSpecializationsHidden" name="teacherSpecializationsTags">
                        <input type="hidden" id="specializationCoursesHidden" name="specializationCoursesTags">

                </div>

                <!-- Slide 2: Dynamic Student/Teacher Information -->
                <div class="carousel-item" id="dynamicSlide">
                    <h3 class="mb-4" id="dynamicTitle"></h3>
                    <div id="dynamicFields"></div>
                    <div id="subjectTags" class="tags-container mb-3"></div>
                    <button type="button" class="btn btn-secondary mt-4 me-2" onclick="prevSlide()">Back</button>
                    <button type="button" class="btn btn-primary mt-4" onclick="nextSlide()">Next</button>
                </div>

                <!-- Slide 3: Submit -->
                <div class="carousel-item">
                    <h3 class="mb-4">Complete Signup</h3>
                    <button type="button" class="btn btn-secondary mt-4 me-2" onclick="prevSlide()">Back</button>
                    <button type="submit" class="btn btn-primary mt-4">Sign Up</button>
                    <p class="mt-3">Already have an account? <a href="<%=request.getContextPath()%>/elearn/UI/signin.jsp">Sign In</a></p>
                </div>
                </form>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0"><b>© 2024 E-Learn. All rights reserved.</b></p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Inject the data into JavaScript as global variables -->
    <script>
        const coursesData = <%= coursesJson %>;
        const specializationsData = <%= specializationsJson %>;
        const subjectsData = <%= subjectsJson %>;
    </script>
    <script src="<%=request.getContextPath()%>/elearn/js/signup.js"></script>
</body>
</html>