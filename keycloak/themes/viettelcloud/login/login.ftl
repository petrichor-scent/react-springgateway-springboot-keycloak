<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
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

            @media only screen and (max-height: 900px) {
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
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                        <#if !usernameHidden??>
                            <div class="form-group" style="margin-top: 16px;">
                                <label for="username" class="form-label">${msg("username")}<span
                                            class="red-asterisk"> *</span></label>

                                <input tabindex="1" id="username" class="form-input" name="username"
                                       value="${(login.username!'')}" type="text" autofocus autocomplete="off"
                                       placeholder="${msg("usernamePlaceholder")}"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />

                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="form-input-wrong" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                                </#if>

                            </div>
                        </#if>

                        <div class="form-group">
                            <label for="password" class="form-label">${msg("password")}<span
                                        class="red-asterisk"> *</span></label>

                            <div style="display: flex; align-items: center;">
                                <input tabindex="2" id="password" class="form-input" name="password" type="password"
                                       autocomplete="off"
                                       placeholder="${msg("passwordPlaceholder")}"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
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

                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                        <span id="input-error" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                    </#if>

                        </div>

                        <div class="form-group">
                            <div class="forget-password-container">
                                <#if realm.resetPasswordAllowed>
                                    <span><a tabindex="4"
                                             href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <input tabindex="5" class="auth-button primary-button" name="login" id="kc-login"
                                   type="submit" value="${msg("doLogIn")}"/>
                        </div>
                        <div class="form-group">
                            <input tabindex="6" class="auth-button secondary-button" name="register" id="kc-register"
                                   type="button" value="${msg("doRegister")}"
                                   onclick="location.href = '${url.registrationUrl}';"/>
                        </div>
                    </form>
                </#if>
        </div>

    </div>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div class="social-providers">
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
