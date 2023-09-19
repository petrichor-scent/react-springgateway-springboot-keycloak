window.addEventListener('load', () => {
    const password = document.getElementById('password') ?? {};
    const showPassword = document.getElementById('show-password') ?? {};
    const tooltipPassword = document.getElementById('tooltip-password') ?? {};
    showPassword.onclick = () => {
        if (password.getAttribute("type") === "password") {
            password.setAttribute("type", "text");
        } else {
            password.setAttribute("type", "password");
        }
        showPassword.classList.toggle("icon-eye");
        showPassword.classList.toggle("icon-eye-invisible");
    };
    showPassword.onmouseover = () => {
        tooltipPassword.style.display = 'initial';
    };
    showPassword.onmouseout = () => {
        tooltipPassword.style.display = 'none';
    };

    const passwordConfirm = document.getElementById('password-confirm') ?? {};
    const showPasswordConfirm = document.getElementById('show-password-confirm') ?? {};
    const tooltipPasswordConfirm = document.getElementById('tooltip-password-confirm') ?? {};
    showPasswordConfirm.onclick = () => {
        if (passwordConfirm.getAttribute("type") === "password") {
            passwordConfirm.setAttribute("type", "text");
        } else {
            passwordConfirm.setAttribute("type", "password");
        }
        showPasswordConfirm.classList.toggle("icon-eye");
        showPasswordConfirm.classList.toggle("icon-eye-invisible");
    };
    showPasswordConfirm.onmouseover = () => {
        tooltipPasswordConfirm.style.display = 'initial';
    };
    showPasswordConfirm.onmouseout = () => {
        tooltipPasswordConfirm.style.display = 'none';
    };


    const passwordNew = document.getElementById('password-new') ?? {};
    const showPasswordNew = document.getElementById('show-password-new') ?? {};
    const tooltipPasswordNew = document.getElementById('tooltip-password-new') ?? {};
    showPasswordNew.onclick = () => {
        if (passwordNew.getAttribute("type") === "password") {
            passwordNew.setAttribute("type", "text");
        } else {
            passwordNew.setAttribute("type", "password");
        }
        showPasswordNew.classList.toggle("icon-eye");
        showPasswordNew.classList.toggle("icon-eye-invisible");
    };
    showPasswordNew.onmouseover = () => {
        tooltipPasswordNew.style.display = 'initial';
    };
    showPasswordNew.onmouseout = () => {
        tooltipPasswordNew.style.display = 'none';
    };
});
