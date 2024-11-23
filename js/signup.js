function nextSlide() {
    const carousel = new bootstrap.Carousel(document.querySelector('#signupCarousel'));
    const currentSlide = document.querySelector('.carousel-item.active');
    const isFirstSlide = currentSlide === document.querySelector('.carousel-item:first-child');
    const role = document.getElementById("role").value;

    // Check if on the first slide and validate the role field
    if (isFirstSlide && !role) {
        alert("Please select a role (Student or Teacher) before proceeding.");
        return;
    }

    // Collect all required fields on the current slide
    const requiredFields = currentSlide.querySelectorAll("input[required], textarea[required], select[required]");
    let allFieldsFilled = true;
    let emailValid = true;

    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            allFieldsFilled = false; // Mark as invalid if any required field is empty
        }

        // Check for email validity specifically if it's an email field
        if (field.id === "email") {
            const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
            if (!emailRegex.test(field.value.trim())) {
                emailValid = false;
            }
        }
    });

    // Show appropriate alert message based on validation results
    if (!allFieldsFilled && !emailValid) {
        alert("Please fill out all fields and enter a valid email.");
        return;
    } else if (!allFieldsFilled) {
        alert("Please fill out all fields.");
        return;
    } else if (!emailValid) {
        alert("Please enter a valid email.");
        return;
    }

    // Update hidden inputs before moving to the next slide
    updateHiddenInputs();

    // Log values of specializations, specialization courses, and subjects of interest
    logSelectedValues();

    // Navigate to the next slide
    carousel.next();
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

    dynamicFields.innerHTML = ''; // Clear previous fields

    if (role === "student") {
        dynamicTitle.innerText = "Student Information";

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="subjects" class="form-label">Subjects of Interest (Hold Ctrl key to select)</label>
                <select class="form-select" id="subjects" name="subjectsOfInterest" multiple required></select>
                <div id="subjectTags" class="tags-container mt-2"></div>
            </div>`;
        
        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3" placeholder="Describe your background and interests..." required></textarea>
            </div>`;
        
        // Populate subjects dropdown and initialize tagging
        populateSubjects();
        initializeSubjectsDropdown();
    } else if (role === "teacher") {
        dynamicTitle.innerText = "Teacher Information";

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="experience" class="form-label">Years of Experience</label>
                <input type="text" class="form-control" id="experience" name="experience" required>
            </div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherSpecializations" class="form-label">Teacher Specializations (Hold Ctrl key to select)</label>
                <select id="teacherSpecializations" name="teacherSpecializations" class="form-select" multiple required></select>
                <div id="specializationTags" class="tags-container mt-2"></div>
            </div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="specializationInput" class="form-label">Specialization Courses</label>
                <input type="text" class="form-control" id="specializationInput" name="specializationCourses" placeholder="Type to search courses">
                <div id="courseSuggestions" class="suggestions-list"></div>
            </div>`;
        
        dynamicFields.innerHTML += `
            <div id="selectedTags" class="tags-container"></div>`;


        dynamicFields.innerHTML += `
        <div class="mb-3">
            <label for="priceRange" class="form-label">Price Range</label>
            <div class="d-flex gap-2">
                <input type="text" class="form-control" id="minPrice" name="minPrice" placeholder="Minimum price for your services" required> 
                <input type="text" class="form-control" id="maxPrice" name="maxPrice" placeholder="Maximum price for your services" required>
            </div>
        </div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherDescription" class="form-label">Description</label>
                <textarea class="form-control" id="teacherDescription" name="teacherDescription" rows="3" placeholder="Describe your background..." required></textarea>
            </div>`;

        // Populate specializations and initialize course suggestions
        populateSpecializations();
        initializeSpecializationsDropdown();
        initializeCourseSuggestions();
    }
}

// Populate the subjects dropdown
function populateSubjects() {
    const subjectsDropdown = document.getElementById("subjects");
    subjectsDropdown.innerHTML = ''; // Clear previous options

    if (subjectsData && subjectsData.length) {
        subjectsData.forEach(subject => {
            const option = document.createElement("option");
            option.value = subject;
            option.textContent = subject;
            subjectsDropdown.appendChild(option);
        });
    }
}

// Populate the teacher specializations dropdown
function populateSpecializations() {
    const specializationDropdown = document.getElementById("teacherSpecializations");
    specializationDropdown.innerHTML = ''; // Clear previous options

    if (specializationsData && specializationsData.length) {
        specializationsData.forEach(spec => {
            const option = document.createElement("option");
            option.value = spec;
            option.textContent = spec;
            specializationDropdown.appendChild(option);
        });
    }
}

// Initialize course suggestions functionality
function initializeCourseSuggestions() {
    const specializationInput = document.getElementById("specializationInput");
    const courseSuggestions = document.getElementById("courseSuggestions");
    const selectedTagsContainer = document.getElementById("selectedTags");

    specializationInput.addEventListener("input", () => {
        const query = specializationInput.value.trim().toLowerCase();
        courseSuggestions.innerHTML = ''; // Clear previous suggestions

        if (query && coursesData) {
            const matchedCourses = coursesData.filter(course =>
                course.toLowerCase().includes(query)
            );

            matchedCourses.forEach(course => {
                const suggestion = document.createElement("div");
                suggestion.className = "list-group-item";
                suggestion.textContent = course;

                suggestion.addEventListener("click", () => {
                    addTag(course, selectedTagsContainer);
                    specializationInput.value = ''; // Clear input
                    courseSuggestions.innerHTML = ''; // Clear suggestions
                    courseSuggestions.style.display = 'none'; // Hide suggestions after selection
                });

                courseSuggestions.appendChild(suggestion);
            });

            if (matchedCourses.length > 0) {
                courseSuggestions.style.display = 'block';
            }
        } else {
            courseSuggestions.style.display = 'none';
        }
    });

    document.addEventListener("click", (event) => {
        if (!courseSuggestions.contains(event.target) && event.target !== specializationInput) {
            courseSuggestions.innerHTML = '';
            courseSuggestions.style.display = 'none'; // Hide suggestion list when clicked outside
        }
    });
}

// Initialize tagging for student subjects of interest
function initializeSubjectsDropdown() {
    const subjectSelect = document.getElementById("subjects");
    const subjectTagsContainer = document.getElementById("subjectTags");

    subjectSelect.addEventListener("change", () => {
        const selectedOptions = Array.from(subjectSelect.selectedOptions).map(opt => opt.value);
        selectedOptions.forEach(subject => addTag(subject, subjectTagsContainer, subjectSelect));
    });
}

// Initialize tagging for teacher specializations
function initializeSpecializationsDropdown() {
    const specializationSelect = document.getElementById("teacherSpecializations");
    const specializationTagsContainer = document.getElementById("specializationTags");

    specializationSelect.addEventListener("change", () => {
        const selectedOptions = Array.from(specializationSelect.selectedOptions).map(opt => opt.value);
        selectedOptions.forEach(spec => addTag(spec, specializationTagsContainer, specializationSelect));
    });
}

// Add a tag for selected items (subjects, specializations, or courses)
function addTag(item, container, selectElement = null) {
    // Prevent adding duplicate tags
    if (Array.from(container.children).some(tag => tag.dataset.value === item)) return;

    const tag = document.createElement("span");
    tag.className = "tag";
    tag.dataset.value = item;
    tag.textContent = item;

    const removeButton = document.createElement("span");
    removeButton.className = "remove-tag";
    removeButton.textContent = " ×";
    removeButton.addEventListener("click", () => {
        tag.remove();

        if (selectElement) {
            // Deselect the corresponding option in the select dropdown
            const option = Array.from(selectElement.options).find(opt => opt.value === item);
            if (option) option.selected = false; // Deselect option without removing it
        }
    });

    tag.appendChild(removeButton);
    container.appendChild(tag);

    // If there's a select element (for teacher specializations), select the corresponding option
    if (selectElement) {
        const option = Array.from(selectElement.options).find(opt => opt.value === item);
        if (option && !option.selected) {
            option.selected = true; // Select the option in the dropdown
        }
    }
}

// Helper to update hidden inputs with tag values
function updateHiddenInputs() {
    const subjectsTags = Array.from(document.querySelectorAll("#subjectTags .tag")).map(tag => tag.dataset.value);
    const specializationsTags = Array.from(document.querySelectorAll("#specializationTags .tag")).map(tag => tag.dataset.value);
    const courseTags = Array.from(document.querySelectorAll("#selectedTags .tag")).map(tag => tag.dataset.value);

    document.getElementById("subjectsOfInterestHidden").value = subjectsTags.join(","); // Convert array to comma-separated string
    document.getElementById("teacherSpecializationsHidden").value = specializationsTags.join(",");
    document.getElementById("specializationCoursesHidden").value = courseTags.join(",");   
}

// Function to log values to the console
function logSelectedValues() {
    // Log Specializations
    const specializationsTags = Array.from(document.querySelectorAll("#specializationTags .tag")).map(tag => tag.dataset.value);
    console.log("Selected Specializations: ", specializationsTags);

    // Log Specialization Courses
    const courseTags = Array.from(document.querySelectorAll("#selectedTags .tag")).map(tag => tag.dataset.value);
    console.log("Selected Specialization Courses: ", courseTags);

    // Log Subjects of Interest
    const subjectTags = Array.from(document.querySelectorAll("#subjectTags .tag")).map(tag => tag.dataset.value);
    console.log("Selected Subjects of Interest: ", subjectTags);
}
