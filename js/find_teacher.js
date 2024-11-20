// Use the global coursesData variable from find_teacher.jsp
// This contains the course titles fetched from the database
const courseTitles = coursesData; // coursesData is provided globally by find_teacher.jsp

// Minimum height for the carousel item (to prevent shrinking too much)
const MIN_CAROUSEL_HEIGHT = 300; // Minimum height in pixels to ensure space for the course title field and form

// Function to fetch course suggestions based on user input
function fetchCourseSuggestions(query) {
    const suggestionsContainer = document.getElementById("courseSuggestions");
    const carouselItem = document.querySelector(".carousel-item.active");

    // Filter suggestions based on the user's query
    const matches = courseTitles.filter(title =>
        title.toLowerCase().includes(query.toLowerCase())
    );

    // Clear any previous suggestions
    suggestionsContainer.innerHTML = "";

    if (matches.length > 0) {
        suggestionsContainer.style.display = "block"; // Show the suggestions dropdown

        // Add each matching suggestion as a new item in the dropdown
        matches.forEach(title => {
            const item = document.createElement("div");
            item.className = "list-group-item";
            item.textContent = title;

            // When a suggestion is clicked, set it in the input and hide the suggestions
            item.onclick = () => {
                document.getElementById("courseTitle").value = title; // Set the value in the input field
                suggestionsContainer.style.display = "none"; // Hide the suggestions dropdown
            };

            suggestionsContainer.appendChild(item); // Add the item to the suggestions list
        });

        // Adjust the height of the carousel item based on the number of suggestions
        const suggestionsHeight = matches.length * 40; // Assuming each suggestion is 40px tall
        const newHeight = Math.max(MIN_CAROUSEL_HEIGHT, suggestionsHeight + 200); // Ensure height doesn't go below the minimum
        carouselItem.style.height = `${newHeight}px`; // Adjust the height

    } else {
        suggestionsContainer.style.display = "none"; // Hide the suggestions if no matches
        carouselItem.style.height = `${MIN_CAROUSEL_HEIGHT}px`; // Set height to minimum if no suggestions
    }

    // Reset scroll position to top for each new search
    suggestionsContainer.scrollTop = 0;
}

// Function to navigate to the next slide in the carousel
function nextSlide() {
    const carousel = document.getElementById('teacherSearchCarousel');
    const bootstrapCarousel = new bootstrap.Carousel(carousel);
    bootstrapCarousel.next();
}

// Function to navigate to the previous slide in the carousel
function prevSlide() {
    const carousel = document.getElementById('teacherSearchCarousel');
    const bootstrapCarousel = new bootstrap.Carousel(carousel);
    bootstrapCarousel.prev();
}

// Function to add selected tags for teacher specialties
function addTag(selectId, containerId) {
    const selectElement = document.getElementById(selectId);
    const container = document.getElementById(containerId);
    const selectedOptions = Array.from(selectElement.selectedOptions);

    // Loop through each selected option and create a new tag
    selectedOptions.forEach(option => {
        // Create the tag element
        const tag = document.createElement("span");
        tag.classList.add("tag", "bg-primary", "me-2"); // Added Bootstrap classes for styling
        tag.textContent = option.text;

        // Create a remove button for the tag
        const removeButton = document.createElement("span");
        removeButton.classList.add("remove-tag", "ms-2", "cursor-pointer");
        removeButton.innerHTML = "&times;"; // Cross icon to remove the tag
        
        // Add remove functionality to the tag
        removeButton.onclick = () => {
            tag.remove(); // Remove the tag from the container
            selectElement.querySelector(`option[value="${option.value}"]`).selected = false; // Deselect the option
        };

        // Append the remove button to the tag
        tag.appendChild(removeButton);

        // Append the tag to the container
        container.appendChild(tag);
    });
}

// Function to initialize the range sliders for experience and price
function initializeRangeSliders() {
    const experienceSlider = document.getElementById('experienceRange');
    const priceSlider = document.getElementById('priceRange');
    
    noUiSlider.create(experienceSlider, {
        start: [0, 40],
        connect: true,
        range: {
            'min': 0,
            'max': 40
        },
        step: 1
    });

    noUiSlider.create(priceSlider, {
        start: [0, 100],
        connect: true,
        range: {
            'min': 0,
            'max': 100
        },
        step: 0.5
    });

    experienceSlider.noUiSlider.on('update', (values) => {
        document.getElementById('experienceOutput').textContent = `${values[0]} - ${values[1]} years`;
    });

    priceSlider.noUiSlider.on('update', (values) => {
        document.getElementById('priceOutput').textContent = `${values[0]} - ${values[1]} USD`;
    });
}

// Initialize range sliders when the page is loaded
document.addEventListener('DOMContentLoaded', function () {
    initializeRangeSliders();
});