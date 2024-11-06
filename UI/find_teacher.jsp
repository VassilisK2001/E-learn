<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find a Teacher</title>
    <!-- Include Bootstrap and noUiSlider CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.5.0/nouislider.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/slider_styles.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Header -->
    <nav class="navbar navbar-expand-lg mb-5">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
                <img src="<%=request.getContextPath()%>/elearn/logo.svg" alt="Logo" width="150" height="48">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link">Signed in as John Doe</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/home_student.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  href="<%=request.getContextPath()%>/elearn/UI/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signin.jsp">Sign In</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp"><span>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-5 flex-grow-1">
        <div id="teacherSearchCarousel" class="carousel slide mx-auto" style="max-width: 600px;" data-bs-interval="false">
            <div class="carousel-inner shadow-lg p-4 rounded bg-white">

                <!-- Slide 1: Course Information -->
                <div class="carousel-item active">
                    <h3 class="mb-4">Course Information</h3>
                    <form id="teacherSearchForm">
                        <div class="mb-3">
                            <label for="courseCategory" class="form-label">Course Category</label>
                            <select id="courseCategory" class="form-select" required>
                                <option value="">Select Category</option>
                                <option value="math">Math</option>
                                <option value="science">Science</option>
                                <!-- Add more categories as needed -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="courseTitle" class="form-label">Course Title</label>
                            <input type="text" class="form-control" id="courseTitle" placeholder="Enter course title" required>
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-primary mt-4" onclick="nextSlide()">Next</button>
                        </div>
                    </form>
                </div>

                <!-- Slide 2: Teacher Filters -->
                <div class="carousel-item">
                    <h3 class="mb-4">Teacher Filters</h3>
                    <div class="mb-3">
                        <label for="teacherSpecialty" class="form-label">Teacher Specialty</label>
                        <select class="form-select" id="teacherSpecialty" multiple onchange="addTag('teacherSpecialty', 'specialtyTags')">
                            <option value="Math Expert">Math Expert</option>
                            <option value="Science Expert">Science Expert</option>
                            <option value="Art Instructor">Art Instructor</option>
                            <!-- Add more specialties as needed -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <h5>Selected Specialties:</h5>
                        <div id="specialtyTags"></div>
                    </div>
                    <div class="mb-3">
                        <label for="experienceRange" class="form-label">Years of Experience</label>
                        <div id="experienceRange" class="range-slider"></div>
                        <div>Selected: <span id="experienceOutput">0 - 40 years</span></div>
                    </div>
                    <div class="mb-3">
                        <label for="priceRange" class="form-label">Price Range</label>
                        <div id="priceRange" class="range-slider"></div>
                        <div>Selected: <span id="priceOutput">$0 - $100</span></div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-secondary" onclick="prevSlide()">Back</button>
                        <button type="button" class="btn btn-primary" onclick="nextSlide()">Next</button>
                    </div>
                </div>

                <!-- Slide 3: Schedule Date -->
                <div class="carousel-item">
                    <h3 class="mb-4">Schedule Date</h3>
                    <div class="mb-3">
                        <label for="scheduleDate" class="form-label">Date</label>
                        <input type="date" class="form-control" id="scheduleDate" required>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-secondary" onclick="prevSlide()">Back</button>
                        <button type="button" class="btn btn-primary" onclick="nextSlide()">Next</button>
                    </div>
                </div>

                <!-- Slide 4: Submit -->
                <div class="carousel-item">
                    <h3 class="mb-4">Submit Criteria</h3>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-secondary" onclick="prevSlide()">Back</button>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0">© 2024 E-Learn. All rights reserved.</p>
    </footer>

    <!-- Include Bootstrap, noUiSlider, and your JavaScript file -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.5.0/nouislider.min.js"></script>
    <script src="<%=request.getContextPath()%>/elearn/js/find_teacher.js"></script>
</body>
</html>
