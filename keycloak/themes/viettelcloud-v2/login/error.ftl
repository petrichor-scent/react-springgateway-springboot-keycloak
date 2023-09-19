<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${kcSanitize(msg("errorTitle"))?no_esc}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("errorTitle")}";
        </script>
        <div id="kc-error-message">
            <p class="instruction">${kcSanitize(message.summary)?no_esc}</p>
            <#if skipLink??>
            <#else>
                <div class="form-group" style="margin-top: 32px; display: flex; justify-content: center;">
                    <button class="auth-button primary-button" type="button" id="backToApplication"
                            onclick="location.href = '/realms/viettel-cloud/account/';">
                        ${kcSanitize(msg("backToApplication"))?no_esc}
                    </button>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>