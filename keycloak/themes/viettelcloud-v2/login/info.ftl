<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if messageHeader??>
            ${messageHeader}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">
        <div id="kc-info-message">
            <p class="instruction">
                <#if messageHeader??>
                    ${message.summary}
                </#if>
                <#if requiredActions??>
                    <#list requiredActions>:
                        <b>
                            <#items as reqActionItem>
                                ${msg("requiredAction.${reqActionItem}")}<#sep>,
                            </#items>
                        </b>
                    </#list>
                </#if>
            </p>
            <#if skipLink??>
            <#else>
                <div class="form-group" style="margin-top: 32px; display: flex; justify-content: center;">
                    <#if pageRedirectUri?has_content>
                        <button class="auth-button primary-button" type="button"
                                onclick="location.href = '${pageRedirectUri}';">
                            ${kcSanitize(msg("backToApplication"))?no_esc}
                        </button>
                    <#elseif actionUri?has_content>
                        <button class="auth-button primary-button" type="button"
                                onclick="location.href = '${actionUri}';">
                            ${kcSanitize(msg("proceedWithAction"))?no_esc}
                        </button>
                    <#elseif client?? && (client.baseUrl)?has_content>
                        <button class="auth-button primary-button" type="button"
                                onclick="location.href = '${client.baseUrl}';">
                            ${kcSanitize(msg("backToApplication"))?no_esc}
                        </button>
                    <#else>
                        <button class="auth-button primary-button" type="button" id="backToApplication"
                                onclick="location.href = '/realms/viettel-cloud/account/';">
                            ${kcSanitize(msg("role_manage-account"))?no_esc}
                        </button>
                    </#if>
                </div>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>