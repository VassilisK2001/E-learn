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
        // Student-specific fields
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
        // Teacher-specific fields
        dynamicTitle.innerText = "Teacher Information";
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
                <label for="priceRange" class="form-label">Price Range</label>
                <div id="priceRange" class="range-slider"></div>
                <div>Selected: <span id="priceOutput">$0 - $100</span></div>
            </div>`;
        dynamicFields.innerHTML += `
            <div class="mb-3">
                <label for="teacherDescription" class="form-label">Description</label>
                <textarea class="form-control" id="teacherDescription" rows="3" placeholder="Describe your background..."></textarea>
            </div>`;

        // Initialize noUiSlider on the priceRange element
        const priceSlider = document.getElementById("priceRange");
        if (priceSlider) {
            noUiSlider.create(priceSlider, {
                start: [0, 100],         // Start range
                connect: true,           // Connect range
                range: {
                    'min': 0,
                    'max': 100
                },
                step: 0.5
            });

            // Update output display for slider values
            priceSlider.noUiSlider.on('update', function(values) {
                document.getElementById("priceOutput").innerText = `$${values[0]} - $${values[1]}`;
            });
        }
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