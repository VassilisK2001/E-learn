function updateStatus(selectId) {
    // Get the dropdown, status display, and submit button
    var select = document.getElementById(selectId);
    var statusValue = document.getElementById('statusValue' + selectId.replace('status', ''));
    var submitButton = document.getElementById('submitBtn' + selectId.replace('status', ''));

    // Get the initial value of the dropdown from the data attribute
    var initialValue = select.getAttribute("data-initial-value");

    // Update the status display
    statusValue.textContent = select.value.charAt(0).toUpperCase() + select.value.slice(1);

    // Show or hide the submit button based on the value change
    if (select.value !== initialValue) {
        submitButton.classList.remove("d-none");
    } else {
        submitButton.classList.add("d-none");
    }
}
