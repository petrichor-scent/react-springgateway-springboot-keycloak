<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("loginAccountTitle")}";
            window.addEventListener('load', () => {
                const username = document.getElementById('username');
                const usernameError = document.getElementById('input-error-username') ?? {};
                const inputError = document.getElementById('input-error') ?? {};
                if (localStorage.getItem('login-username-require') === 'invalid') {
                    inputError.style.display = 'none';
                    username.setAttribute('aria-invalid', true);
                    usernameError.hidden = false;
                    usernameError.innerHTML = "${kcSanitize(msg('missingUsernameMessage'))?no_esc}";
                    localStorage.setItem('login-username-require', 'valid');
                }
                const password = document.getElementById('username');
                const passwordError = document.getElementById('input-error-password') ?? {};
                if (localStorage.getItem('login-password-require') === 'invalid') {
                    inputError.style.display = 'none';
                    password.setAttribute('aria-invalid', true);
                    passwordError.hidden = false;
                    passwordError.innerHTML = "${kcSanitize(msg('missingPasswordMessage'))?no_esc}";
                    localStorage.setItem('login-password-require', 'valid');
                }
            });
        </script>
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
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                        <#if !usernameHidden??>
                            <div class="form-group" style="margin-top: 16px;">
                                <label for="username" class="form-label">${msg("username")}<span
                                            class="red-asterisk"> *</span></label>
                                <div class="clear-container">
                                    <input id="username" class="form-input" name="username"
                                           type="text" autofocus autocomplete="username"
                                           maxlength="150"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                    />
                                    <button class="clear-button" tabindex="-1" type="button"></button>
                                </div>
                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="form-input-wrong" aria-live="polite">
<#--                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}-->
                                        ${msg("wrongUsernameAndPassword")}
                                    </span>
                                </#if>
                                <span id="input-error-username" class="form-input-wrong" aria-live="polite"></span>
                                <script>
                                    const username = document.getElementById('username');
                                    username.onblur = () => {
                                        username.value = username.value.trim();
                                    }
                                </script>
                            </div>
                        </#if>

                        <div class="form-group" style="position: relative">
                            <label for="password" class="form-label">${msg("password")}<span class="red-asterisk"> *</span></label>
                            <div style="display: flex; align-items: center;">
                                <input id="password" class="form-input" name="password" type="password"
                                       autocomplete="password"
                                       maxlength="30"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />
                                <i id="show-password" class="show-password icon-eye" aria-hidden="true"></i>
                                <div id="tooltip-password" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                                    <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                                    <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                                </div>
                            </div>
                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span id="input-error" class="form-input-wrong" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>
                            <span id="input-error-password" class="form-input-wrong" aria-live="polite"></span>
                        </div>
                        <div class="form-group login-action">
                            <#if realm.rememberMe>
                                <div class="checkbox custom-checkbox-container">
                                    <label>
                                        <#if login.rememberMe??>
                                            <input class="custom-checkbox" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                        <#else>
                                            <input class="custom-checkbox" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                        </#if>
                                    </label>
                            </div>
                            </#if>
                            <div class="forgot-password-container">
                                <#if realm.resetPasswordAllowed>
                                    <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <button class="auth-button primary-button" name="login" id="kc-login" type="submit">
                                ${msg("doLogIn")}
                            </button>
                        </div>
                        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                            <div class="form-group">
                                <button class="auth-button secondary-button" name="register" id="kc-register"
                                        type="button" onclick="location.href = '${url.registrationUrl}';">
                                    ${msg("doRegister")}
                                </button>
                            </div>
                        </#if>

                        <script>
                            const inputError = document.getElementById("input-error") ?? {};
                            const usernameError = document.getElementById("input-error-username") ?? {};
                            const passwordError = document.getElementById("input-error-password") ?? {};
                            const password = document.getElementById("password");

                            username.oninput = () => {
                                inputError.hidden = true;
                                usernameError.style.display = 'none';
                                username.setAttribute('aria-invalid', false);
                            };
                            password.oninput = () => {
                                inputError.hidden = true;
                                passwordError.style.display = 'none';
                                password.setAttribute('aria-invalid', false);
                            };

                            const login = document.getElementById('kc-login');
                            if(username.value !== '' && password.value !== '') {
                                login.onclick = () => {
                                    if (username.value === '') {
                                        localStorage.setItem('login-username-require', 'invalid');
                                    }
                                    if (password.value === '') {
                                        localStorage.setItem('login-password-require', 'invalid');
                                    }
                                }
                            } else if (username.value === '') {
                                inputError.style.display = 'none';
                                username.setAttribute('aria-invalid', true);
                                usernameError.hidden = false;
                                usernameError.innerHTML = "${kcSanitize(msg('missingUsernameMessage'))?no_esc}";
                                localStorage.setItem('login-username-require', 'valid');
                            } else if (password.value === '') {
                                inputError.style.display = 'none';
                                password.setAttribute('aria-invalid', true);
                                passwordError.hidden = false;
                                passwordError.innerHTML = "${kcSanitize(msg('missingPasswordMessage'))?no_esc}";
                                localStorage.setItem('login-password-require', 'valid');
                            }      
                        </script>
                    </form>
                </#if>
            </div>
        </div>
    </#if>

</@layout.registrationLayout>
