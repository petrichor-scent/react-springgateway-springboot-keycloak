<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("logoutConfirmTitle")}";
        </script>
        <div id="kc-logout-confirm" class="content-area">
            <p class="instruction">${msg("logoutConfirmHeader")}</p>

            <form class="form-actions" action="${url.logoutConfirmAction}" method="POST">
                <input type="hidden" name="session_code" value="${logoutConfirm.code}">
                <div id="kc-form-options">
                    <div class="${properties.kcFormOptionsWrapperClass!}"></div>
                </div>
                <div id="kc-form-buttons" class="form-group" style="margin-top: 32px; display: flex; justify-content: center;">
                    <button class="auth-button primary-button" type="button" id="backToApplication"
                            name="confirmLogout" id="kc-logout" type="submit">
                        ${msg("doLogout")}
                    </button>
                </div>
                <#if logoutConfirm.skipLink>
                <#else>
                    <#if client?? && (client.baseUrl)?has_content>
                        <div class="form-group" style="margin-top: 32px; display: flex; justify-content: center;">
                            <button class="auth-button text-button" type="button" id="backToApplication"
                                    onclick="location.href = '${client.baseUrl}';">
                                ← ${kcSanitize(msg("backToApplication"))?no_esc}
                            </button>
                        </div>
                    </#if>
                </#if>
            </form>

            <div class="clearfix"></div>
        </div>
    </#if>
</@layout.registrationLayout>
