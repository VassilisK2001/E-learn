const predefinedCourses = ["Math", "Science", "Computer Science", "History", "Biology", "Physics", "Chemistry"]; // Example courses
const predefinedSpecializations = ["Mathematics", "Science", "Arts", "Engineering", "Languages"]; // Example specializations
const predefinedSubjects = ["Math", "Science", "History", "Geography", "English", "Art", "Biology"]; // Example subjects for students

// Function to navigate to the next slide with role validation on the first slide
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

    dynamicFields.innerHTML = ''; // Clear previous fields

    if (role === "student") {
        // Student-specific fields
        dynamicTitle.innerText = "Student Information";
        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="subjects" class="form-label">Subjects of Interest</label>
                <select class="form-select" id="subjects" multiple>
                    ${predefinedSubjects.map(sub => `<option value="${sub}">${sub}</option>`).join('')}
                </select>
                <div id="subjectTags" class="tags-container mt-2"></div>
            </div>`;

        dynamicFields.innerHTML += `
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" rows="3" placeholder="Describe your background and interests..."></textarea>
        </div>`;
        
        // Initialize Subjects dropdown functionality for student role
        initializeSubjectsDropdown();
    } else if (role === "teacher") {
        // Teacher-specific fields
        dynamicTitle.innerText = "Teacher Information";

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="experience" class="form-label">Years of Experience</label>
                <input type="number" class="form-control" id="experience" min="0" max="10">
            </div>`;

        // Teacher Specializations Field
        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherSpecializations" class="form-label">Teacher Specializations</label>
                <select id="teacherSpecializations" class="form-select" multiple>
                    ${predefinedSpecializations.map(spec => `<option value="${spec}">${spec}</option>`).join('')}
                </select>
                <div id="specializationTags" class="tags-container mt-2"></div>
            </div>`;

        // Specialization Courses Field
        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="specializationInput" class="form-label">Specialization Courses (optional)</label>
                <input type="text" class="form-control" id="specializationInput" placeholder="Type to search courses">
                <div id="suggestions" class="suggestions-list"></div>
            </div>`;
        dynamicFields.innerHTML += `
            <div id="selectedTags" class="tags-container"></div>`;

        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherDescription" class="form-label">Description</label>
                <textarea class="form-control" id="teacherDescription" rows="3" placeholder="Describe your background..."></textarea>
            </div>`;

        // Initialize dropdown and autocomplete functionality
        initializeSpecializationsDropdown();
        initializeSpecializationAutocomplete();
    }
}

// Function to initialize tagging for teacher specializations from dropdown
function initializeSpecializationsDropdown() {
    const specializationSelect = document.getElementById("teacherSpecializations");
    const specializationTagsContainer = document.getElementById("specializationTags");

    // Listen for changes in the dropdown
    specializationSelect.addEventListener("change", () => {
        const selectedOptions = Array.from(specializationSelect.selectedOptions).map(opt => opt.value);

        // Add new tags based on selected options
        selectedOptions.forEach(spec => {
            addTag(spec, specializationTagsContainer, specializationSelect);
        });
    });
}

// Function to initialize autocomplete for specialization courses
function initializeSpecializationAutocomplete() {
    const specializationInput = document.getElementById("specializationInput");
    const suggestionsList = document.getElementById("suggestions");
    const selectedTagsContainer = document.getElementById("selectedTags");

    specializationInput.addEventListener("input", () => {
        const query = specializationInput.value.trim().toLowerCase();
        suggestionsList.innerHTML = ''; // Clear suggestions

        if (query) {
            const matchedCourses = predefinedCourses.filter(course =>
                course.toLowerCase().includes(query)
            );

            matchedCourses.forEach(course => {
                const suggestion = document.createElement("div");
                suggestion.className = "suggestion-item";
                suggestion.textContent = course;

                suggestion.addEventListener("click", () => {
                    addTag(course, selectedTagsContainer);
                    specializationInput.value = ''; // Clear input
                    suggestionsList.innerHTML = ''; // Clear suggestions
                });

                suggestionsList.appendChild(suggestion);
            });
        }
    });

    document.addEventListener("click", (event) => {
        if (!suggestionsList.contains(event.target) && event.target !== specializationInput) {
            suggestionsList.innerHTML = '';
        }
    });
}

// Function to add a tag for a selected course or specialization
function addTag(item, container, selectElement = null) {
    // Check if the tag already exists (avoid duplicates)
    if (Array.from(container.children).some(tag => tag.dataset.value === item)) return;

    // Create a new tag element
    const tag = document.createElement("span");
    tag.className = "tag";
    tag.dataset.value = item;
    tag.textContent = item;

    // Create a remove button for the tag
    const removeButton = document.createElement("span");
    removeButton.className = "remove-tag";
    removeButton.textContent = " ×";
    removeButton.addEventListener("click", () => {
        tag.remove();

        // If the tag relates to a dropdown, deselect the option
        if (selectElement) {
            const option = Array.from(selectElement.options).find(opt => opt.value === item);
            if (option) option.selected = false;
        }
    });

    // Append the remove button to the tag and the tag to the container
    tag.appendChild(removeButton);
    container.appendChild(tag);
}

// Function to initialize tagging for student subjects of interest from dropdown
function initializeSubjectsDropdown() {
    const subjectSelect = document.getElementById("subjects");
    const subjectTagsContainer = document.getElementById("subjectTags");

    // Listen for changes in the dropdown
    subjectSelect.addEventListener("change", () => {
        const selectedOptions = Array.from(subjectSelect.selectedOptions).map(opt => opt.value);

        // Add new tags based on selected options
        selectedOptions.forEach(subject => {
            addTag(subject, subjectTagsContainer, subjectSelect);
        });
    });
}

// Call initializeSubjectsDropdown when the page loads
document.addEventListener("DOMContentLoaded", function () {
    const role = document.getElementById("role").value;
    if (role === "student") {
        initializeSubjectsDropdown();
    }
});
