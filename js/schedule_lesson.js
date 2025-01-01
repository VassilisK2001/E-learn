document.addEventListener('DOMContentLoaded', () => {
    const scheduleModal = new bootstrap.Modal(document.getElementById('scheduleModal'));
    const scheduleForm = document.getElementById('scheduleForm');
    const teacherNameInput = document.getElementById('teacherName');

    document.querySelectorAll('.schedule-btn').forEach(button => {
        button.addEventListener('click', (event) => {
            const teacherName = event.target.getAttribute('data-teacher-name');
            const teacherId = event.target.getAttribute('data-teacher-id');

            // Update the modal with teacher details
            teacherNameInput.value = teacherName;

            // Show the modal
            scheduleModal.show();
        });
    });
});