<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
        <p class="instruction">${msg("emailVerifyInstruction1",user.email)}</p>
        <div class="form-group" style="margin-top: 32px;">
            <button class="auth-button primary-button" type="button" id="backToLogin"
                    onclick="location.href = '${url.loginAction}';">
                ${msg("doClickHere")} ${msg("emailVerifyInstruction3")}
            </button>
        </div>
        <div class="form-group">
            <button class="auth-button secondary-button" type="button" id="backToLogin"
                    onclick="location.href = '${url.loginRestartFlowUrl}';">
                ${msg("backToLogin")}
            </button>
        </div>
    </#if>
</@layout.registrationLayout>
