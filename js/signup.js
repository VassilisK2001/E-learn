function adjustSecondSlide() {
    const role = document.getElementById("role").value;
    console.log("Role selected:", role); // For debugging purposes
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

    // Ensure no photo field is added here for both roles
}
