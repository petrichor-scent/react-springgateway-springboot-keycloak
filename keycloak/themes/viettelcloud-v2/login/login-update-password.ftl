<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("updatePasswordTitle")}";
            window.addEventListener('load', () => {
                const password = document.getElementById('password-new');
                const passwordError = document.getElementById('input-error-password') ?? {};
                if (localStorage.getItem('update-password-require') === 'invalid') {
                    password.setAttribute('aria-invalid', true);
                    passwordError.hidden = false;
                    passwordError.innerHTML = "${kcSanitize(msg('missingPasswordMessage'))?no_esc}";
                    localStorage.setItem('update-password-require', 'valid');
                }
                const passwordConfirm = document.getElementById('password-confirm');
                const passwordConfirmError = document.getElementById('input-error-password-confirm') ?? {};
                if (localStorage.getItem('update-password-confirm-require') === 'invalid') {
                    passwordConfirm.setAttribute('aria-invalid', true);
                    passwordConfirmError.hidden = false;
                    passwordConfirmError.innerHTML = "${kcSanitize(msg('missingPasswordConfirmMessage'))?no_esc}";
                    localStorage.setItem('update-password-confirm-require', 'valid');
                }
            });
        </script>
        <p id="page-subtitle-internal">${msg("updatePasswordSubtitle")}</p>
        <img src="${url.resourcesPath}/img/reset-password.svg" alt="reset password image" width="160" height="160"/>
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                    <div class="form-group" style="position: relative">
                        <label for="password-new" class="form-label">
                            ${msg("passwordNew")}
                            <span class="red-asterisk"> *</span>
                        </label>
                        <div style="display: flex; align-items: center;">
                            <input id="password-new" class="form-input" name="password-new"
                                   type="password" autocomplete="new-password"
                                   autofocus
                                   maxlength="30"
                                   aria-invalid="<#if messagesPerField.existsError('password', 'password-confirm')>true</#if>"
                            />
                            <i id="show-password-new" class="show-password icon-eye" aria-hidden="true"></i>
                            <div id="tooltip-password-new" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                                <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                                <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                            </div>
                        </div>
                        <#if messagesPerField.existsError('password')>
                            <span id="input-error-password" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('password'))?no_esc}
                            </span>
                        <#else>
                            <span id="input-error-password" class="form-input-wrong" aria-live="polite"></span>
                        </#if>
                        <script>
                            if (document.getElementsByClassName("alert alert-error pf-c-alert pf-m-inline pf-m-danger").length > 0) {
                                const alert = document.getElementsByClassName("alert alert-error pf-c-alert pf-m-inline pf-m-danger")[0];
                                const inputErrorPassword = document.getElementById("input-error-password");
                                alert.style.display = 'none';
                                inputErrorPassword.style.display = 'block';
                                inputErrorPassword.innerHTML = alert.innerText;
                            }
                        </script>
                    </div>
                    <div class="form-group" style="position: relative">
                        <label for="password-confirm" class="form-label">
                            ${msg("passwordConfirm")}
                            <span class="red-asterisk"> *</span>
                        </label>
                        <div style="display: flex; align-items: center;">
                            <input id="password-confirm" class="form-input" name="password-confirm"
                                   type="password" autocomplete="password-confirm"
                                   maxlength="30"
                                   aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                            />
                            <i id="show-password-confirm" class="show-password icon-eye" aria-hidden="true"></i>
                            <div id="tooltip-password-confirm" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                                <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                                <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                            </div>
                        </div>
                        <#if messagesPerField.existsError('password-confirm')>
                            <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                            </span>
                        <#else>
                            <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite"></span>
                        </#if>
                    </div>

                    <#if isAppInitiatedAction??>
                        <div class="form-group" style="margin-top: 8px;">
                            <div class="checkbox custom-checkbox-container">
                                <label>
                                    <input type="checkbox" class="custom-checkbox" id="logout-sessions" name="logout-sessions" value="on" checked> ${msg("logoutOtherSessions")}
                                </label>
                            </div>
                        </div>
                    </#if>

                    <div class="form-group" style="margin-top: 32px">
                        <button class="auth-button primary-button" type="submit" id="update-password">
                            ${msg("doUpdatePassword")}
                        </button>
                    </div>

                    <#if isAppInitiatedAction??>
                        <div class="form-group">
                            <button class="auth-button text-button" id="backToApplication"
                                    type="submit" name="cancel-aia" value="true">
                                ← ${msg("backToApplication")}
                            </button>
                        </div>
                    </#if>

                    <script>
                        const password = document.getElementById('password-new');
                        const passwordError = document.getElementById('input-error-password') ?? {};

                        const passwordConfirm = document.getElementById('password-confirm');
                        const passwordConfirmError = document.getElementById('input-error-password-confirm') ?? {};

                        password.oninput = () => {
                            passwordError.style.display = 'none';
                            password.setAttribute('aria-invalid', false);
                        };
                        passwordConfirm.oninput = () => {
                            passwordConfirmError.style.display = 'none';
                            passwordConfirm.setAttribute('aria-invalid', false);
                        };

                        const updatePassword = document.getElementById('update-password');
                        updatePassword.onclick = () => {
                            if (password.value === '') {
                                localStorage.setItem('update-password-require', 'invalid');
                            }
                            if (passwordConfirm.value === '') {
                                localStorage.setItem('update-password-confirm-require', 'invalid');
                            }
                        }
                    </script>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>