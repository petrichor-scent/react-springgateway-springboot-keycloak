<#import "template.ftl" as layout>
<@layout.mainLayout active='password' bodyClass='password'; section>

    <div class="title-container">
        <img src="${url.resourcesPath}/img/icons/title.svg" alt="" height="56">
        <h2 class="content-title">${msg("changePasswordHtmlTitle")}</h2>
    </div>

<#--    <script>-->
<#--        const passwordNew = document.getElementById('password-new');-->
<#--        const passwordNewError = document.getElementById('input-error-password-new') ?? {};-->
<#--        passwordNew.value = "";-->
<#--        if (localStorage.getItem('password-new-validation') === 'invalid') {-->
<#--            passwordNew.setAttribute('aria-invalid', true);-->
<#--            passwordNewError.hidden = false;-->
<#--            passwordNewError.innerHTML = "${kcSanitize(msg('missingPasswordMessage'))?no_esc}";-->
<#--            localStorage.setItem('password-new-validation', 'valid');-->
<#--        }-->
<#--        const passwordConfirm = document.getElementById('password-confirm');-->
<#--        const passwordConfirmError = document.getElementById('input-error-password-confirm') ?? {};-->
<#--        passwordConfirm.value = "";-->
<#--        if (localStorage.getItem('password-confirm-validation') !== 'valid') {-->
<#--            passwordConfirm.setAttribute('aria-invalid', true);-->
<#--            passwordConfirmError.hidden = false;-->
<#--            if (localStorage.getItem('password-confirm-validation') === 'empty') {-->
<#--                passwordConfirmError.innerHTML = "${kcSanitize(msg('missingPasswordConfirmMessage'))?no_esc}";-->
<#--            }-->
<#--            else {-->
<#--                passwordConfirmError.innerHTML = "${kcSanitize(msg("notMatchPasswordMessage"))?no_esc}";-->
<#--            }-->
<#--            localStorage.setItem('password-confirm-validation', 'valid');-->
<#--        }-->
<#--    </script>-->

    <form action="${url.passwordUrl}" method="post">
        <input type="text" id="username" name="username" value="${(account.username!'')}" autocomplete="username" readonly="readonly" style="display:none;">

        <#if password.passwordSet>
            <div class="form-group" style="position: relative">
                <label for="password" class="form-label">${msg("currentPassword")}<span
                            class="red-asterisk"> *</span></label>
                <div style="display: flex; align-items: center;">
                    <input id="password" class="form-input" name="password"
                           type="password"
                           maxlength="30"
                           autofocus
<#--                           aria-invalid="<#if messagesPerField.existsError('password', 'password-confirm')>true</#if>"-->
                    />
                    <i id="show-password" class="show-password icon-eye" aria-hidden="true"></i>
                    <div id="tooltip-password" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                        <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                        <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                    </div>
                </div>
<#--                <#if messagesPerField.existsError('password')>-->
<#--                    <span id="input-error-password" class="form-input-wrong" aria-live="polite">-->
<#--                    ${kcSanitize(messagesPerField.get('password'))?no_esc}-->
<#--                </span>-->
<#--                <#else>-->
<#--                    <span id="input-error-password" class="form-input-wrong" aria-live="polite"></span>-->
<#--                </#if>-->
            </div>
        </#if>

        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

        <div class="form-group" style="position: relative">
            <label for="password-new" class="form-label">${msg("passwordNew")}<span
                        class="red-asterisk"> *</span></label>
            <div style="display: flex; align-items: center;">
                <input id="password-new" class="form-input" name="password-new"
                       type="password"
                       maxlength="30"
<#--                       aria-invalid="<#if messagesPerField.existsError('password', 'password-confirm')>true</#if>"-->
                />
                <i id="show-password-new" class="show-password icon-eye" aria-hidden="true"></i>
                <div id="tooltip-password-new" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                    <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                    <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                </div>
            </div>
<#--            <#if messagesPerField.existsError('password')>-->
<#--                <span id="input-error-password-new" class="form-input-wrong" aria-live="polite">-->
<#--                    ${kcSanitize(messagesPerField.get('password'))?no_esc}-->
<#--                </span>-->
<#--            <#else>-->
<#--                <span id="input-error-password-new" class="form-input-wrong" aria-live="polite"></span>-->
<#--            </#if>-->
<#--            <script>-->
<#--                if (document.getElementsByClassName("alert alert-error custom-alert").length > 0) {-->
<#--                    const alert = document.getElementsByClassName("alert alert-error custom-alert")[0];-->
<#--                    const inputErrorPassword = document.getElementById("input-error-password");-->
<#--                    alert.style.display = 'none';-->
<#--                    inputErrorPassword.style.display = 'block';-->
<#--                    inputErrorPassword.innerHTML = alert.innerText;-->
<#--                }-->
<#--            </script>-->
        </div>

        <div class="form-group" style="position: relative">
            <label for="password-confirm" class="form-label">${msg("passwordConfirm")}<span
                        class="red-asterisk"> *</span></label>
            <div style="display: flex; align-items: center;">
                <input id="password-confirm" class="form-input" name="password-confirm"
                       type="password" autocomplete="password-confirm"
                       maxlength="30"
<#--                       aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"-->
                />
                <i id="show-password-confirm" class="show-password icon-eye" aria-hidden="true"></i>
                <div id="tooltip-password-confirm" class="pf-c-tooltip pf-m-bottom-right tooltip-password" role="tooltip">
                    <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                    <div class="pf-c-tooltip__content tooltip-content">${msg("showHidePassword")}</div>
                </div>
            </div>
<#--            <#if messagesPerField.existsError('password-confirm')>-->
<#--                <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite">-->
<#--                    ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}-->
<#--                </span>-->
<#--            <#else>-->
<#--                <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite"></span>-->
<#--            </#if>-->
        </div>

        <div class="button-group">
            <#if url.referrerURI??>
                <a href="${url.referrerURI}">${kcSanitize(msg("backToApplication")?no_esc)}</a>
            </#if>
            <div>
                <button type="button"
                        class="account-button secondary-button"
                        id="cancelTOTPBtn" name="cancelAction" value="Cancel">
                    ${msg("doCancel")}
                </button>
            </div>
            <div>
                <button type="submit"
                        class="account-button primary-button"
                        id="saveTOTPBtn" name="submitAction" value="Save">
                    ${msg("doSave")}
                </button>
            </div>
        </div>
<#--        <script>-->
<#--            passwordNew.oninput = () => {-->
<#--                const passwordNewError = document.getElementById("input-error-password-new") ?? {};-->
<#--                passwordNewError.hidden = true;-->
<#--                passwordNew.setAttribute('aria-invalid', false);-->
<#--            };-->
<#--            passwordConfirm.oninput = () => {-->
<#--                const passwordConfirmError = document.getElementById("input-error-password-confirm") ?? {};-->
<#--                passwordConfirmError.hidden = true;-->
<#--                passwordConfirm.setAttribute('aria-invalid', false);-->
<#--            };-->

<#--            const saveButton = document.getElementsByName('submitAction')[0];-->
<#--            saveButton.addEventListener('click', () => {-->
<#--                if (passwordNew.value === '') {-->
<#--                    localStorage.setItem('password-validation', 'invalid');-->
<#--                }-->
<#--                if (passwordConfirm.value === '') {-->
<#--                    localStorage.setItem('password-confirm-validation', 'empty');-->
<#--                }-->
<#--                else if (passwordConfirm.value !== passwordNew.value) {-->
<#--                    localStorage.setItem('password-confirm-validation', 'not-match');-->
<#--                }-->
<#--            });-->
<#--        </script>-->
            <script>
                const cancelButton = document.getElementsByName('cancelAction')[0];
                cancelButton.addEventListener('click', () => {
                    const alert = document.getElementsByClassName("alert alert-error custom-alert")[0];
                    if (alert?.style) alert.style.display = 'none';

                    const password = document.getElementById("password");
                    const passwordNew = document.getElementById("password-new");
                    const passwordConfirm = document.getElementById("password-confirm");
                    password.value = "";
                    passwordNew.value = "";
                    passwordConfirm.value = "";
                });
            </script>
    </form>

</@layout.mainLayout>
