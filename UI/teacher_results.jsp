<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signup.jsp">Sign Up</a>
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

    <main class="container my-4 flex-grow-1">
        <h1 class="mb-4">Available Teachers</h1>

        <!-- Teacher Profile Cards -->
        <div class="row">
            <%-- Teacher 1 Card --%>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel1" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">John Doe</h5>
                                            <p class="card-text"><strong>Age:</strong> 30</p>
                                            <p class="card-text">Experienced teacher specializing in personalized learning and skill development.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel1" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specialization:</strong></p>
                                            <div>
                                                <span class="badge bg-secondary me-2">Math</span>
                                                <span class="badge bg-secondary me-2">Science</span>
                                            </div>
                                            <p class="mt-2"><strong>Experience:</strong> 10 years</p>
                                            <p><strong>Price Range:</strong> $30 - $60</p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel1" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <a href="<%=request.getContextPath()%>/elearn/UI/scheduleLesson.jsp?teacherId=1" class="btn btn-outline-primary me-2">Schedule Lesson</a>
                        <a href="<%=request.getContextPath()%>/elearn/UI/contactTeacher.jsp?teacherId=1" class="btn btn-outline-secondary">Contact Teacher</a>
                    </div>
                </div>
            </div>

            <%-- Teacher 2 Card --%>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel2" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">Jane Smith</h5>
                                            <p class="card-text"><strong>Age:</strong> 28</p>
                                            <p class="card-text">Dedicated teacher with a focus on holistic education and student growth.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel2" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specialization:</strong></p>
                                            <div>
                                                <span class="badge bg-secondary me-2">English</span>
                                                <span class="badge bg-secondary me-2">History</span>
                                            </div>
                                            <p class="mt-2"><strong>Experience:</strong> 8 years</p>
                                            <p><strong>Price Range:</strong> $40 - $70</p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel2" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <a href="<%=request.getContextPath()%>/elearn/UI/scheduleLesson.jsp?teacherId=2" class="btn btn-outline-primary me-2">Schedule Lesson</a>
                        <a href="<%=request.getContextPath()%>/elearn/UI/contactTeacher.jsp?teacherId=2" class="btn btn-outline-secondary">Contact Teacher</a>
                    </div>
                </div>
            </div>

            <%-- Teacher 3 Card --%>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel3" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">Emily White</h5>
                                            <p class="card-text"><strong>Age:</strong> 35</p>
                                            <p class="card-text">Experienced educator specializing in language arts and communication.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel3" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specialization:</strong></p>
                                            <div>
                                                <span class="badge bg-secondary me-2">Literature</span>
                                                <span class="badge bg-secondary me-2">Writing</span>
                                            </div>
                                            <p class="mt-2"><strong>Experience:</strong> 12 years</p>
                                            <p><strong>Price Range:</strong> $50 - $80</p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel3" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <a href="<%=request.getContextPath()%>/elearn/UI/scheduleLesson.jsp?teacherId=3" class="btn btn-outline-primary me-2">Schedule Lesson</a>
                        <a href="<%=request.getContextPath()%>/elearn/UI/contactTeacher.jsp?teacherId=3" class="btn btn-outline-secondary">Contact Teacher</a>
                    </div>
                </div>
            </div>

            <%-- Teacher 4 Card --%>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel4" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">David Brown</h5>
                                            <p class="card-text"><strong>Age:</strong> 40</p>
                                            <p class="card-text">Professional tutor with a passion for technology and online education.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel4" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specialization:</strong></p>
                                            <div>
                                                <span class="badge bg-secondary me-2">Programming</span>
                                                <span class="badge bg-secondary me-2">Web Development</span>
                                            </div>
                                            <p class="mt-2"><strong>Experience:</strong> 15 years</p>
                                            <p><strong>Price Range:</strong> $60 - $100</p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel4" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <div class="card-footer text-center">
                        <a href="<%=request.getContextPath()%>/elearn/UI/scheduleLesson.jsp?teacherId=4" class="btn btn-outline-primary me-2">Schedule Lesson</a>
                        <a href="<%=request.getContextPath()%>/elearn/UI/contactTeacher.jsp?teacherId=4" class="btn btn-outline-secondary">Contact Teacher</a>
                    </div>
                    </div>
                </div>
            </div>

            <%-- Teacher 5 Card --%>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card shadow-lg">
                    <div class="row g-0">
                        <!-- Left Side: Teacher Photo -->
                        <div class="col-4">
                            <img src="<%=request.getContextPath()%>/elearn/teacher_photo.jpg" class="img-fluid rounded-start" alt="Teacher Photo">
                        </div>

                        <!-- Right Side: Carousel with Teacher Info -->
                        <div class="col-8">
                            <div id="teacherCarousel5" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">
                                    <!-- Slide 1: Basic Information -->
                                    <div class="carousel-item active">
                                        <div class="card-body">
                                            <h5 class="card-title">Sara Lee</h5>
                                            <p class="card-text"><strong>Age:</strong> 32</p>
                                            <p class="card-text">Creative teacher specializing in arts and design with a focus on student creativity.</p>
                                            <button class="btn btn-primary mt-3" data-bs-target="#teacherCarousel5" data-bs-slide="next">Next</button>
                                        </div>
                                    </div>

                                    <!-- Slide 2: Additional Information -->
                                    <div class="carousel-item">
                                        <div class="card-body">
                                            <p><strong>Specialization:</strong></p>
                                            <div>
                                                <span class="badge bg-secondary me-2">Art</span>
                                                <span class="badge bg-secondary me-2">Design</span>
                                            </div>
                                            <p class="mt-2"><strong>Experience:</strong> 9 years</p>
                                            <p><strong>Price Range:</strong> $45 - $75</p>
                                            <button class="btn btn-secondary mt-3" data-bs-target="#teacherCarousel5" data-bs-slide="prev">Back</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer with Action Buttons -->
                    <div class="card-footer text-center">
                        <div class="card-footer text-center">
                        <a href="<%=request.getContextPath()%>/elearn/UI/scheduleLesson.jsp?teacherId=5" class="btn btn-outline-primary me-2">Schedule Lesson</a>
                        <a href="<%=request.getContextPath()%>/elearn/UI/contactTeacher.jsp?teacherId=5" class="btn btn-outline-secondary">Contact Teacher</a>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            © 2024 E-Learn. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
