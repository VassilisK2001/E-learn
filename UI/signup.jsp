<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/index.css">
    <style>
        .tag {
            display: inline-block;
            padding: 5px 10px;
            margin: 5px;
            background-color: #007bff;
            color: white;
            border-radius: 20px;
        }
        .tag .remove-tag {
            margin-left: 8px;
            cursor: pointer;
            color: #fff;
        }
    </style>
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
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/signin.jsp">Sign In</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-5 flex-grow-1">
        <div id="signupCarousel" class="carousel slide mx-auto" style="max-width: 600px;" data-bs-interval="false">
            <div class="carousel-inner shadow-lg p-4 rounded bg-white">

                <!-- Slide 1: Personal Information -->
                <div class="carousel-item active">
                    <h3 class="mb-4">Personal Information</h3>
                    <form id="signupForm">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <select class="form-select" id="role" required onchange="adjustSecondSlide()">
                                <option value="">Select your role</option>
                                <option value="student">Student</option>
                                <option value="teacher">Teacher</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary mt-4" onclick="nextSlide()">Next</button>
                    </form>
                </div>

                <!-- Slide 2: Dynamic Student/Teacher Information -->
                <div class="carousel-item" id="dynamicSlide">
                    <h3 class="mb-4" id="dynamicTitle"></h3>
                    <div id="dynamicFields"></div>
                    <div id="selectedTags" class="mb-3"></div>
                    <button type="button" class="btn btn-secondary mt-4 me-2" onclick="prevSlide()">Back</button>
                    <button type="button" class="btn btn-primary mt-4" onclick="nextSlide()">Next</button>
                </div>

                <!-- Slide 3: Submit -->
                <div class="carousel-item">
                    <h3 class="mb-4">Complete Signup</h3>
                    <button type="button" class="btn btn-secondary mt-4 me-2" onclick="prevSlide()">Back</button>
                    <button type="submit" class="btn btn-success mt-4">Sign Up</button>
                    <p class="mt-3">Already have an account? <a href="<%=request.getContextPath()%>/signin.jsp">Sign In</a></p>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0">© 2024 E-Learn. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to navigate to the next slide with role validation on first slide
        function nextSlide() {
            const carousel = new bootstrap.Carousel(document.querySelector('#signupCarousel'));
            const currentSlide = document.querySelector('.carousel-item.active');
            const isFirstSlide = currentSlide === document.querySelector('.carousel-item.active:first-child');
            const role = document.getElementById("role").value;

            if (isFirstSlide && !role) {
                alert("Please select a role (Student or Teacher) before proceeding.");
            } else {
                carousel.next(); // Move to the next slide
            }
        }

        // Function to navigate to the previous slide
        function prevSlide() {
            const carousel = new bootstrap.Carousel(document.querySelector('#signupCarousel'));
            carousel.prev();
        }

        // Adjust fields on the second slide based on role selection
        function adjustSecondSlide() {
            const role = document.getElementById("role").value;
            const dynamicFields = document.getElementById("dynamicFields");
            const dynamicTitle = document.getElementById("dynamicTitle");
            const selectedTags = document.getElementById("selectedTags");

            dynamicFields.innerHTML = ''; // Clear previous fields
            selectedTags.innerHTML = ''; // Clear selected tags

            if (role === "student") {
                dynamicTitle.innerText = "Student Information";

                dynamicFields.innerHTML += `
                    <div class="mb-3">
                        <label for="subjects" class="form-label">Subjects of Interest</label>
                        <select class="form-select" id="subjects" multiple onchange="updateTags('subjects')">
                            <option value="Math">Math</option>
                            <option value="Science">Science</option>
                            <option value="History">History</option>
                        </select>
                    </div>`;
                
                dynamicFields.innerHTML += `
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" rows="3" placeholder="Describe your interests..."></textarea>
                    </div>`;
            } else if (role === "teacher") {
                dynamicTitle.innerText = "Teacher Information";

                dynamicFields.innerHTML += `
                    <div class="mb-3">
                        <label for="photo" class="form-label">Photo (optional)</label>
                        <input type="file" class="form-control" id="photo">
                    </div>`;
                
                dynamicFields.innerHTML += `
                    <div class="mb-3">
                        <label for="experience" class="form-label">Years of Experience</label>
                        <input type="number" class="form-control" id="experience" min="0" max="10">
                    </div>`;
                
                dynamicFields.innerHTML += `
                    <div class="mb-3">
                        <label for="specializations" class="form-label">Specialization Courses</label>
                        <select class="form-select" id="specializations" multiple onchange="updateTags('specializations')">
                            <option value="Math">Math</option>
                            <option value="Science">Science</option>
                            <option value="Computer Science">Computer Science</option>
                        </select>
                    </div>`;

                dynamicFields.innerHTML += `
                    <div class="mb-3">
                        <label for="teacherDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="teacherDescription" rows="3" placeholder="Describe your background..."></textarea>
                    </div>`;
            }
        }

        // Function to update tags based on selections
        function updateTags(type) {
            const selectedTags = document.getElementById("selectedTags");
            const selectedOptions = document.getElementById(type === 'subjects' ? 'subjects' : 'specializations').selectedOptions;

            // Create an array of currently selected tags
            const currentTags = Array.from(selectedTags.children).map(tag => tag.innerText.replace('×', '').trim());

            // Add new tags for each selected option
            Array.from(selectedOptions).forEach(option => {
                const optionValue = option.value;

                // Avoid duplicates
                if (!currentTags.includes(optionValue)) {
                    const tagElement = document.createElement("span");
                    tagElement.className = "tag";
                    tagElement.textContent = optionValue;
                    tagElement.innerHTML += `<span class="remove-tag" onclick="removeTag(this)">×</span>`; // Remove icon
                    selectedTags.appendChild(tagElement);
                }
            });
        }

        // Function to remove a tag
        function removeTag(tagElement) {
            tagElement.parentElement.remove();
        }
    </script>
</body>
</html>
