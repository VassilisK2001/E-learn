function updateStatus(selectId) {
    var select = document.getElementById(selectId);
    var statusValue = document.getElementById('statusValue' + selectId.charAt(selectId.length - 1));
    statusValue.textContent = select.value.charAt(0).toUpperCase() + select.value.slice(1);

    // Get the submit button for this card
    var submitButton = document.getElementById('submitBtn' + selectId.charAt(selectId.length - 1));
    
    // Show Submit Button if Status is not Pending
    if (select.value !== "pending") {
        submitButton.classList.remove("d-none");
    } else {
        submitButton.classList.add("d-none");
    }
}