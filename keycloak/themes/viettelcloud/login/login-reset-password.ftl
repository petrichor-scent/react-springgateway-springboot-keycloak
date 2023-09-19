<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <style>
        h1#page-title {
            font-family: 'Lexend Deca', sans-serif;
            font-style: normal;
            font-weight: 400;
            font-size: 40px;
            text-align: center;

            color: #000000;

            margin-bottom: 0;
        }
    </style>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <p id="page-subtitle-internal">${msg("emailForgotSubtitle")}</p>
        <form id="kc-reset-password-form" class="full-screen" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="username"
                       class="form-label"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                <input type="text" id="username" name="username" class="form-input"
                       placeholder="${msg("emailPlaceholder")}"
                       autofocus value="${(auth.attemptedUsername!'')}"
                       aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                <#if messagesPerField.existsError('username')>
                    <span id="input-error-username" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('username'))?no_esc}
                    </span>
                </#if>
            </div>
            <div class="form-group" style="margin-top: 32px;">
                <input class="auth-button primary-button" type="submit" value="${msg("doSubmit")}"/>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
