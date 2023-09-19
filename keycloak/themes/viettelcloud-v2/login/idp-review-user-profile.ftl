<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginIdpReviewProfileTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("loginIdpReviewProfileTitle")}";
        </script>
        <form id="kc-idp-review-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <@userProfileCommons.userProfileFormFields/>

            <div class="form-group" style="margin-top: 32px">
                <button type="submit" class="auth-button primary-button">
                    ${msg("doSubmit")}
                </button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>