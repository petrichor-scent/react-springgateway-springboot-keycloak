window.addEventListener('load', () => {
    const buttons = document.getElementsByClassName('auth-button');
    for (let button of buttons) {
        button.addEventListener("click", () => {
            for (let otherButton of buttons) {
                if (otherButton !== button) {
                    otherButton.onclick = () => {};
                    otherButton.disabled = true;
                }
            }
            // Add loader
            const loader = document.createElement('div');
            loader.classList.add('loader');

            button.innerText = '';
            button.style.cursor = 'auto';
            button.appendChild(loader);
        });
    }
});
