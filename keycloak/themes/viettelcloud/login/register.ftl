<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <style>
            .login-pf-page .card-pf {
                border: none;
                box-shadow: 0 0.5px 60px rgba(108, 94, 94, 0.1);
                min-height: 100vh;
                padding: 100px 150px !important;

                background-image: url(${url.resourcesPath}/img/background.png);
                background-size: cover;
                background-position: center bottom;
                background-repeat: no-repeat;

                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            @media only screen and (max-width: 900px) {
                .login-pf-page .card-pf {
                    padding-left: 100px !important;
                    padding-right: 100px !important;
                }
            }

            @media only screen and (max-height: 1000px) {
                .login-pf-page .card-pf {
                    justify-content: flex-start !important;
                    padding-top: 50px !important;
                    padding-bottom: 50px !important;
                }
            }

            .bottom-banner {
                display: none;
            }
        </style>
        <p id="page-subtitle">${msg("loginAccountSubtitle")}</p>
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
            <div class="form-group">
                <label for="firstName" class="form-label">${msg("firstName")}<span
                            class="red-asterisk"> *</span></label>
                <input type="text" id="firstName" class="form-input" name="firstName"
                       value="${(register.formData.firstName!'')}"
                       placeholder="${msg("firstNamePlaceholder")}"
                       aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                />
                <script>
                    const firstName = document.getElementById('firstName');
                    firstName.onblur = () => {
                        firstName.value = firstName.value.trim();
                    }
                </script>
                <#if messagesPerField.existsError('firstName')>
                    <span id="input-error-firstname" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                    </span>
                    <script>
                        firstName.focus();
                    </script>
                </#if>
            </div>
            <div class="form-group">
                <label for="lastName" class="form-label">${msg("lastName")}<span class="red-asterisk"> *</span></label>
                <input type="text" id="lastName" class="form-input" name="lastName"
                       value="${(register.formData.lastName!'')}"
                       placeholder="${msg("lastNamePlaceholder")}"
                       aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                />
                <script>
                    const lastName = document.getElementById('lastName');
                    lastName.onblur = () => {
                        lastName.value = lastName.value.trim();
                    }
                </script>
                <#if messagesPerField.existsError('lastName')>
                    <span id="input-error-lastname" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                    </span>
                    <script>
                        lastName.focus();
                    </script>
                </#if>
            </div>
            <div class="form-group">
                <label for="email" class="form-label">${msg("email")}<span class="red-asterisk"> *</span></label>
                <input type="text" id="email" class="form-input" name="email"
                       value="${(register.formData.email!'')}" autocomplete="email"
                       placeholder="${msg("emailPlaceholder")}"
                       aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                />
                <script>
                    const email = document.getElementById('email');
                    email.onblur = () => {
                        email.value = email.value.trim();
                    }
                </script>
                <#if messagesPerField.existsError('email')>
                    <span id="input-error-email" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('email'))?no_esc}
                    </span>
                    <script>
                        const inputErrorEmail = document.getElementById('input-error-email');
                        email.focus();
                        if (email.value === '') {
                            inputErrorEmail.innerText = "${msg("requiredFields")}";
                        }
                    </script>
                </#if>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="form-group">
                    <label for="username" class="form-label">${msg("username")}<span
                                class="red-asterisk"> *</span></label>
                    <input type="text" id="username" class="form-input" name="username"
                           value="${(register.formData.username!'')}" autocomplete="username"
                           placeholder="${msg("usernamePlaceholder")}"
                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                    />
                    <script>
                        const username = document.getElementById('username');
                        username.onblur = () => {
                            username.value = username.value.trim();
                        }
                    </script>
                    <#if messagesPerField.existsError('username')>
                        <span id="input-error-username" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('username'))?no_esc}
                        </span>
                        <script>
                            const inputErrorUser = document.getElementById('input-error-username');
                            username.focus();
                            if (username.value === '') {
                                inputErrorUser.innerText = "${msg("requiredFields")}";
                            }
                        </script>
                    </#if>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="form-group">
                    <label for="password" class="form-label">${msg("password")}<span
                                class="red-asterisk"> *</span></label>
                    <div style="display: flex; align-items: center;">
                        <input tabindex="2" id="password" class="form-input" name="password" type="password"
                               autocomplete="off"
                               placeholder="${msg("passwordPlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                        />
                        <i id="show-password" class="show-password icon-eye" aria-hidden="true"></i>
                    </div>

                    <script>
                        const password = document.getElementById('password');
                        const showPassword = document.getElementById('show-password');
                        showPassword.onclick = () => {
                            if (password.getAttribute("type") === "password") {
                                password.setAttribute("type", "text");
                            } else {
                                password.setAttribute("type", "password");
                            }
                            showPassword.classList.toggle("icon-eye");
                            showPassword.classList.toggle("icon-eye-invisible");
                        }
                    </script>

                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
<#--                        <script>-->
<#--                            const inputErrorPassword = document.getElementById('input-error-password');-->
<#--                            password.focus();-->
<#--                            if (password.value === '') {-->
<#--                                inputErrorPassword.innerText = "${msg("requiredFields")}";-->
<#--                            }-->
<#--                        </script>-->
                    </#if>

                </div>
                <div class="form-group">
                    <label for="password-confirm" class="form-label">${msg("passwordConfirm")}<span
                                class="red-asterisk"> *</span></label>
                    <div style="display: flex; align-items: center;">
                        <input tabindex="2" id="password-confirm" class="form-input" name="password-confirm"
                               type="password" autocomplete="off"
                               placeholder="${msg("passwordConfirmPlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                        />
                        <i id="show-password-confirm" class="show-password icon-eye" aria-hidden="true"></i>
                    </div>

                    <script>
                        const passwordConfirm = document.getElementById('password-confirm');
                        const showPasswordConfirm = document.getElementById('show-password-confirm');
                        showPasswordConfirm.onclick = () => {
                            if (passwordConfirm.getAttribute("type") === "password") {
                                passwordConfirm.setAttribute("type", "text");
                            } else {
                                passwordConfirm.setAttribute("type", "password");
                            }
                            showPasswordConfirm.classList.toggle("icon-eye");
                            showPasswordConfirm.classList.toggle("icon-eye-invisible");
                        }
                    </script>

                    <#if messagesPerField.existsError('password-confirm')>
                        <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                        <script>
                            passwordConfirm.focus();
                        </script>
                    </#if>
                </div>
            </#if>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <div class="form-group" style="margin-top: 40px">
                <input class="auth-button primary-button" type="submit" value="${msg("doRegister")}"/>
            </div>
            <div class="form-group">
                <input class="auth-button secondary-button" type="button" value="${msg("doLogIn")}" onclick="location.href = '${url.loginUrl}';"/>
            </div>
        </form>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="social-providers">
                <p class="social-title">${msg("socialTitle")}</p>
                <ul class="social-container">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="social-button icon-${p.displayName!}"
                           type="button" href="${p.loginUrl}">
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>