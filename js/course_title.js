const predefinedCourseTitles = [
    "Mathematics 101",
    "Science for Beginners",
    "Advanced Physics",
    "History of Art",
    "Introduction to Programming",
    "Robotics",
    "Advanced Math",
    "Martial Arts",
    "Science",
    "History"
];

function fetchCourseSuggestions(query) {
    const suggestionsContainer = document.getElementById("courseSuggestions");
    
    // Clear previous suggestions
    suggestionsContainer.innerHTML = "";

    if (query.trim() === "") {
        suggestionsContainer.style.display = "none";
        return;
    }

    // Filter suggestions
    const matches = predefinedCourseTitles.filter(title =>
        title.toLowerCase().includes(query.toLowerCase())
    );

    if (matches.length > 0) {
        suggestionsContainer.style.display = "block";

        matches.forEach(title => {
            const item = document.createElement("div");
            item.className = "suggestion-item list-group-item list-group-item-action";
            item.textContent = title;

            // Set value when clicked
            item.onclick = () => {
                document.getElementById("courseTitle").value = title;
                suggestionsContainer.style.display = "none";
            };

            suggestionsContainer.appendChild(item);
        });
    } else {
        suggestionsContainer.style.display = "none";
    }
}

// Close suggestions on outside click
document.addEventListener("click", (e) => {
    const suggestionsContainer = document.getElementById("courseSuggestions");
    const inputField = document.getElementById("courseTitle");
    if (!suggestionsContainer.contains(e.target) && e.target !== inputField) {
        suggestionsContainer.style.display = "none";
    }
});