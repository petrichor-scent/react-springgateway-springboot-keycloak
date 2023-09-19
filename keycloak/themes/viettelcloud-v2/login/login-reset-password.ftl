<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("emailForgotTitle")}";
        </script>
        <p id="page-subtitle-internal">${msg("emailForgotSubtitle")}</p>
        <img src="${url.resourcesPath}/img/forgot-password.svg" alt="reset password image" width="160" height="160"/>
        <form id="kc-reset-password-form" class="full-screen" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="username" class="form-label">
                    <#if !realm.loginWithEmailAllowed>
                        ${msg("username")}
                    <#elseif !realm.registrationEmailAsUsername>
                        ${msg("usernameOrEmail")}
                    <#else>
                        ${msg("email")}
                    </#if>
                    <span class="red-asterisk"> *</span>
                </label>
                <div class="clear-container">
                    <input type="text" id="username" name="username" class="form-input"
                           maxlength="150"
                           autofocus
                           value="${(auth.attemptedUsername!'')}"
                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                    <button class="clear-button" tabindex="-1" type="button"></button>
                </div>
                <#if messagesPerField.existsError('username')>
                    <span id="input-error-username" class="form-input-wrong" aria-live="polite">
                        ${kcSanitize(msg("emailForgotSubtitle"))?no_esc}
                    </span>
                </#if>
                <script>
                    const username = document.getElementById('username');
                    username.onblur = () => {
                        username.value = username.value.trim();
                    };
                    username.oninput = () => {
                        const usernameError = document.getElementById("input-error-username") ?? {};
                        usernameError.hidden = true;
                        username.setAttribute('aria-invalid', false);
                    };
                </script>
            </div>
            <div class="form-group" style="margin-top: 32px;">
                <button class="auth-button primary-button" type="submit">
                    ${msg("doSubmit")}
                </button>
            </div>
            <div class="form-group">
                <button class="auth-button text-button" type="button" id="backToLogin"
                        onclick="location.href = '${url.loginUrl}';">
                    ← ${msg("backToLogin")}
                </button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
