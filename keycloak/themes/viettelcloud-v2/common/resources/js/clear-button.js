window.addEventListener('load', () => {
    const inputs = document.querySelectorAll(`input:enabled:not([type="password"]).form-input`);
    inputs.forEach(input => {
        const button = input.nextElementSibling;
        button.onclick = () => {
            input.value = "";
        }
    })
});
