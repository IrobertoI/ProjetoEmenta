document.getElementById('theme-toggle').addEventListener('click', toggleDarkMode);

function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    document.querySelector('header').classList.toggle('dark-mode');
    document.getElementById('theme-toggle').classList.toggle('dark-mode');
}
