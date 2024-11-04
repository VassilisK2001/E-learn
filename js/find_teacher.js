document.addEventListener('DOMContentLoaded', function() {
    // Initialize the Years of Experience slider with two handles
    const experienceSlider = document.getElementById('experienceRange');
    noUiSlider.create(experienceSlider, {
        start: [0, 40],
        connect: true,
        range: {
            'min': 0,
            'max': 40
        },
        step: 1,
        tooltips: [true, true]
    });
    experienceSlider.noUiSlider.on('update', function(values) {
        document.getElementById('experienceOutput').innerText = `${values[0]} - ${values[1]} years`;
    });

    // Initialize the Price Range slider with two handles
    const priceSlider = document.getElementById('priceRange');
    noUiSlider.create(priceSlider, {
        start: [0, 100],
        connect: true,
        range: {
            'min': 0,
            'max': 100
        },
        step: 1,
        tooltips: [true, true]
    });
    priceSlider.noUiSlider.on('update', function(values) {
        document.getElementById('priceOutput').innerText = `$${values[0]} - $${values[1]}`;
    });

    // Manage carousel navigation
    const carousel = new bootstrap.Carousel(document.getElementById('teacherSearchCarousel'), {
        interval: false,
        wrap: false
    });

    window.nextSlide = () => carousel.next();
    window.prevSlide = () => carousel.prev();

    // Add selected specialty as tag
    window.addTag = function(selectId, tagContainerId) {
        const select = document.getElementById(selectId);
        const tagContainer = document.getElementById(tagContainerId);

        Array.from(select.selectedOptions).forEach(option => {
            // Only add new tags for options that are not already represented in the tag container
            if (!tagContainer.querySelector(`[data-value="${option.value}"]`)) {
                const tag = document.createElement('span');
                tag.className = 'badge bg-secondary me-2';
                tag.dataset.value = option.value;
                tag.innerText = option.text + ' ';

                const removeIcon = document.createElement('i');
                removeIcon.className = 'fas fa-times ms-1';
                removeIcon.style.cursor = 'pointer';
                removeIcon.onclick = () => {
                    tagContainer.removeChild(tag);
                    option.selected = false; // Deselect the option in the select dropdown
                };
                tag.appendChild(removeIcon);

                tagContainer.appendChild(tag);
            }
        });
    }
});
