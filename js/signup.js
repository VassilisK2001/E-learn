// Function to navigate to the next slide with role validation on the first slide
function nextSlide() {
    const carousel = new bootstrap.Carousel(document.querySelector('#signupCarousel'));
    const currentSlide = document.querySelector('.carousel-item.active');
    const isFirstSlide = currentSlide === document.querySelector('.carousel-item:first-child');
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

    dynamicFields.innerHTML = ''; // Clear previous fields

    if (role === "student") {
        dynamicTitle.innerText = "Student Information";

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="subjects" class="form-label">Subjects of Interest</label>
                <select class="form-select" id="subjects" multiple></select>
                <div id="subjectTags" class="tags-container mt-2"></div>
            </div>`;
        
        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" rows="3" placeholder="Describe your background and interests..."></textarea>
            </div>`;
        
        // Populate subjects dropdown and initialize tagging
        populateSubjects();
        initializeSubjectsDropdown();
    } else if (role === "teacher") {
        dynamicTitle.innerText = "Teacher Information";

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="experience" class="form-label">Years of Experience</label>
                <input type="number" class="form-control" id="experience" min="0" max="50">
            </div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherSpecializations" class="form-label">Teacher Specializations</label>
                <select id="teacherSpecializations" class="form-select" multiple></select>
                <div id="specializationTags" class="tags-container mt-2"></div>
            </div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="specializationInput" class="form-label">Specialization Courses (optional)</label>
                <input type="text" class="form-control" id="specializationInput" placeholder="Type to search courses">
                <div id="courseSuggestions" class="suggestions-list"></div>
            </div>`;
        
        dynamicFields.innerHTML += `
            <div id="selectedTags" class="tags-container"></div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="priceRange" class="form-label">Price Range</label>
                <div id="priceRange" class="range-slider"></div>
                <div>Selected: <span id="priceOutput"> 0 - 100</span></div>
            </div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherDescription" class="form-label">Description</label>
                <textarea class="form-control" id="teacherDescription" rows="3" placeholder="Describe your background..."></textarea>
            </div>`;

        // Populate specializations and initialize course suggestions
        populateSpecializations();
        initializeSpecializationsDropdown();
        initializeCourseSuggestions();
        initializeRangeSliders();
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
            const option = Array.from(selectElement.options).find(opt => opt.value === item);
            if (option) option.selected = false;
        }
    });

    tag.appendChild(removeButton);
    container.appendChild(tag);
}

// Function to initialize the range sliders for experience and price
function initializeRangeSliders() {
    const priceSlider = document.getElementById('priceRange');
    
    noUiSlider.create(priceSlider, {
        start: [0, 100],
        connect: true,
        range: {
            'min': 0,
            'max': 100
        },
        step: 0.5
    });

    priceSlider.noUiSlider.on('update', (values) => {
        document.getElementById('priceOutput').textContent = `${values[0]} - ${values[1]} USD`;
    });
}

// Initialize on page load
window.onload = function() {
    populateSubjects();
    populateSpecializations();
};