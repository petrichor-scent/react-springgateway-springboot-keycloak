<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        ${kcSanitize(msg("registerTitle"))?no_esc}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("registerTitle")}";
            window.addEventListener('load', () => {
                const alertText = document.getElementById('alert-notification')?.innerText;
                const captchaShow = alertText === 'Recaptcha không hợp lệ' || alertText === 'Invalid Recaptcha';

                const username = document.getElementById('username');
                const usernameError = document.getElementById('input-error-username') ?? {};
                
                localStorage.setItem('username-validation', 'valid');
                if (localStorage.getItem('username-validation') === 'invalid' && !captchaShow) {
                    username.setAttribute('aria-invalid', true);
                    usernameError.hidden = false;
                    usernameError.innerHTML = "${kcSanitize(msg('error-username-invalid-character'))?no_esc}";
                }
                const password = document.getElementById('password');
                const passwordError = document.getElementById('input-error-password') ?? {};
                password.value = "";
                localStorage.setItem('password-validation', 'valid');
                if (localStorage.getItem('password-validation') === 'invalid' && !captchaShow) {
                    password.setAttribute('aria-invalid', true);
                    passwordError.hidden = false;
                    passwordError.innerHTML = "${kcSanitize(msg('missingPasswordMessage'))?no_esc}";
                }
                const passwordConfirm = document.getElementById('password-confirm');
                const passwordConfirmError = document.getElementById('input-error-password-confirm') ?? {};
                passwordConfirm.value = "";

                if (localStorage.getItem('password-confirm-validation') !== 'valid' && !captchaShow) {
                    passwordConfirm.setAttribute('aria-invalid', true);
                    passwordConfirmError.hidden = false;
                    if (localStorage.getItem('password-confirm-validation-value') === 'empty') {
                        passwordConfirmError.innerHTML = "${kcSanitize(msg('missingPasswordConfirmMessage'))?no_esc}";
                    }
                    else {
                        passwordConfirmError.innerHTML = "${kcSanitize(msg("notMatchPasswordMessage"))?no_esc}";
                    }
                }
                localStorage.setItem('password-confirm-validation', 'valid');
            });
        </script>
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
                    <#if realm.password && social.providers??>
                        <div class="social-providers">
                            <#list social.providers as p>
                                <a id="social-${p.alias}"
                                   type="button" href="${p.loginUrl}">
                                    <div class="icon-social icon-${p.alias}"></div>
                                    ${p.displayName}
                                </a>
                            </#list>
                        </div>
                        <div class="alternative">
                            <hr>
                            <p>${msg("Or")}</p>
                        </div>
                    </#if>
                    <div class="horizontal-form">
                        <div class="form-group" style="width: 100%;">
                            <label for="firstName" class="form-label">${msg("firstName")}<span
                                        class="red-asterisk"> *</span></label>
                            <div class="clear-container">
                                <input type="text" id="firstName" class="form-input" name="firstName"
                                       value="${(register.formData.firstName!'')}"
                                       maxlength="150"
                                       autofocus
                                       aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                                />
                                <button class="clear-button" tabindex="-1" type="button"></button>
                            </div>
                            <span id="input-error-firstname" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                            </span>
                            <script>
                                const firstName = document.getElementById('firstName');
                                firstName.onblur = () => {
                                    firstName.value = firstName.value.trim();
                                }
                            </script>
                        </div>
                        <div class="form-group" style="width: 100%;">
                            <label for="lastName" class="form-label">${msg("lastName")}<span class="red-asterisk"> *</span></label>
                            <div class="clear-container">
                                <input type="text" id="lastName" class="form-input" name="lastName"
                                       value="${(register.formData.lastName!'')}"
                                       maxlength="150"
                                       aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                                />
                                <button class="clear-button" tabindex="-1" type="button"></button>
                            </div>
                            <span id="input-error-lastname" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                            </span>
                            <script>
                                const lastName = document.getElementById('lastName');
                                lastName.onblur = () => {
                                    lastName.value = lastName.value.trim();
                                }
                            </script>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="form-label">${msg("email")}<span class="red-asterisk"> *</span></label>
                        <div class="clear-container">
                            <input type="text" id="email" class="form-input" name="email"
                                   value="${(register.formData.email!'')}" autocomplete="email"
                                   maxlength="150"
                                   aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                            />
                            <button class="clear-button" tabindex="-1" type="button"></button>
                        </div>
                        <span id="input-error-email" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('email'))?no_esc}
                        </span>
                        <script>
                            const email = document.getElementById('email');
                            email.onblur = () => {
                                email.value = email.value.trim();
                            }
                        </script>
                    </div>

                    <#if !realm.registrationEmailAsUsername>
                        <div class="form-group">
                            <label for="username" class="form-label">${msg("username")}<span
                                        class="red-asterisk"> *</span></label>
                            <div class="clear-container">
                                <input type="text" id="username" class="form-input" name="username"
                                       value="${(register.formData.username!'')}" autocomplete="off"
                                       maxlength="150"
                                       aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                                />
                                <button class="clear-button" tabindex="-1" type="button"></button>
                            </div>
                            <span id="input-error-username" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('username'))?no_esc}
                            </span>
                            <script>
                                const username = document.getElementById('username');
                                username.onblur = () => {
                                    username.value = username.value.trim();
                                }
                            </script>
                        </div>
                    </#if>

                    <#if passwordRequired??>
                        <div class="horizontal-form">
                            <div class="form-group" style="width: 100%; position: relative">
                                <label for="password" class="form-label">${msg("password")}<span class="red-asterisk"> *</span></label>
                                <div style="display: flex; align-items: center;">
                                    <input id="password" class="form-input" name="password" type="password"
                                           autocomplete="off"
                                           maxlength="30"
                                           aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                                    />
                                    <i id="show-password" class="show-password icon-eye" aria-hidden="true"></i>
                                    <div id="tooltip-password" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                                        <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                                        <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                                    </div>
                                </div>
                                <span id="input-error-password" class="form-input-wrong" aria-live="polite">
                                    <#if messagesPerField.existsError('password')>
                                        ${kcSanitize(msg("invalidPassword"))?no_esc}
                                    </#if>
                                </span>
                            </div>
                            <div class="form-group" style="width: 100%; position: relative;">
                                <label for="password-confirm" class="form-label">${msg("passwordConfirm")}<span class="red-asterisk"> *</span></label>
                                <div style="display: flex; align-items: center;">
                                    <input id="password-confirm" class="form-input" name="password-confirm"
                                           type="password" autocomplete="off"
                                           maxlength="30"
                                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                    />
                                    <i id="show-password-confirm" class="show-password icon-eye" aria-hidden="true"></i>
                                    <div id="tooltip-password-confirm" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                                        <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                                        <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                                    </div>
                                </div>
                                <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite"></span>
                            </div>
                        </div>
                    </#if>

                    <#if recaptchaRequired??>
                        <div style="margin: 16px 0;">
                            <div class="g-recaptcha" style="display: flex; justify-content: center; border-radius: 12px; width: 100%;" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                        </div>
                    </#if>


                    <div class="form-group" style="margin-top: 32px;">
                        <button class="auth-button primary-button" type="submit" id="register">
                            ${msg("doRegister")}
                        </button>
                    </div>
                    <script>
                        const password = document.getElementById("password");
                        const passwordConfirm = document.getElementById("password-confirm");

                        username.oninput = () => {
                            const usernameError = document.getElementById("input-error-username") ?? {};
                            usernameError.hidden = true;
                            username.setAttribute('aria-invalid', false);
                        };
                        firstName.oninput = () => {
                            const firstNameError = document.getElementById("input-error-firstname") ?? {};
                            firstNameError.hidden = true;
                            firstName.setAttribute('aria-invalid', false);
                        };
                        lastName.oninput = () => {
                            const lastNameError = document.getElementById("input-error-lastname") ?? {};
                            lastNameError.hidden = true;
                            lastName.setAttribute('aria-invalid', false);
                        };
                        email.oninput = () => {
                            const emailError = document.getElementById("input-error-email") ?? {};
                            emailError.hidden = true;
                            email.setAttribute('aria-invalid', false);
                        };
                        password.oninput = () => {
                            const passwordError = document.getElementById("input-error-password") ?? {};
                            passwordError.hidden = true;
                            password.setAttribute('aria-invalid', false);
                        };
                        passwordConfirm.oninput = () => {
                            const passwordConfirmError = document.getElementById("input-error-password-confirm") ?? {};
                            passwordConfirmError.hidden = true;
                            passwordConfirm.setAttribute('aria-invalid', false);
                        };

                        const register = document.getElementById('register');
                        register.addEventListener('click', () => {
                           
                            firstName.value = firstName.value.trim();
                            lastName.value = lastName.value.trim();
                            email.value = email.value.trim();
                            username.value = username.value.trim();

                            const regexUsername = /^[\w.@+_]*$/;
                            if (!regexUsername.test(username.value)) {
                                localStorage.setItem('username-validation', 'invalid');
                            }
                            if (password.value === '') {
                                localStorage.setItem('password-validation', 'invalid');
                            }
                            if (passwordConfirm.value === '') {
                                localStorage.setItem('password-confirm-validation', 'invalid')
                                localStorage.setItem('password-confirm-validation-value', 'empty');
                            }
                            else if (passwordConfirm.value !== password.value) {
                                localStorage.setItem('password-confirm-validation', 'invalid')
                                localStorage.setItem('password-confirm-validation-value', 'not-match');
                            }
                        });
                    </script>
                    <div class="form-group">
                        <button class="auth-button secondary-button" type="button" onclick="location.href = '${url.loginUrl}';">
                            ${msg("backToLogin")}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>