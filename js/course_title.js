function fetchCourseSuggestions(query) {
    const suggestionsContainer = document.getElementById("courseSuggestions");
    
    // Clear previous suggestions
    suggestionsContainer.innerHTML = "";

    if (query.trim() === "") {
        suggestionsContainer.style.display = "none";
        return;
    }

    // Ensure `coursesData` is available and filter suggestions
    if (Array.isArray(coursesData)) {
        const matches = coursesData.filter(title =>
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
    } else {
        console.error("coursesData is not defined or is not an array.");
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