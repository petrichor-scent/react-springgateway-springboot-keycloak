<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("pageExpiredTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("pageExpiredTitle")}";
        </script>
        <div class="form-group" style="margin-top: 32px;">
            <button class="auth-button primary-button" type="button"
                    onclick="location.href = '${url.loginRestartFlowUrl}';">
                ${msg("pageExpiredMsg1")}
            </button>
        </div>
        <div class="form-group">
            <button class="auth-button secondary-button" type="button"
                    onclick="location.href = '${url.loginAction}';">
                ${msg("pageExpiredMsg2")}
            </button>
        </div>
    </#if>
</@layout.registrationLayout>
