<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("confirmLinkIdpTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("confirmLinkIdpTitle")}";
        </script>
        <form id="kc-register-form" style="display: block; margin-top: 20px;" action="${url.loginAction}" method="post">
            <div class="form-group">
                <button type="submit" class="auth-button primary-button" name="submitAction" id="updateProfile" value="updateProfile">
                    ${msg("confirmLinkIdpReviewProfile")}
                </button>
            </div>
            <div class="form-group">
                <button type="submit" class="auth-button secondary-button" name="submitAction" id="linkAccount" value="linkAccount">
                    ${msg("confirmLinkIdpContinue", idpDisplayName)}
                </button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
