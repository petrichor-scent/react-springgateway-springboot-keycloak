<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError("totp"); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
              autocomplete="off" method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}" style="margin: 12px 0;">
                    <div class="${properties.kcInputWrapperClass!}" style="display: flex; justify-content: space-between;">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <input id="kc-otp-credential-${otpCredential?index}"
                                   class="${properties.kcLoginOTPListInputClass!}"
                                   type="radio" name="selectedCredentialId"
                                   value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                            <label for="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                      <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <div class="form-group">
                <label for="otp" class="form-label">${msg("loginOtpOneTime")}<span class="red-asterisk"> *</span></label>
                <div class="clear-container">
                    <input id="otp" name="otp" autocomplete="off" type="text" class="form-input"
                           maxlength="6"
                           autofocus
                           aria-invalid="<#if messagesPerField.existsError("totp")>true</#if>"/>
                    <button class="clear-button" tabindex="-1" type="button"></button>
                </div>
                <#if messagesPerField.existsError("totp")>
                    <span id="input-error-otp-code" class="form-input-wrong" aria-live="polite">
                        ${kcSanitize(messagesPerField.get("totp"))?no_esc}
                    </span>
                </#if>
            </div>

            <div class="form-group" style="margin-top: 32px">
                <button class="auth-button primary-button" name="login" type="submit" id="submit-otp">
                    ${msg("doLogIn")}
                </button>
                <script>
                    let otpField = document.getElementById("otp") ?? {};
                    let otpError = document.getElementById("input-error-otp-code") ?? {};

                    if (localStorage.getItem("login-otp-require") === "invalid") {
                        otpField.setAttribute("aria-invalid", true);
                        otpError.innerText = "${msg("missingTotpMessage")}";
                    }
                    let submitOTPButton = document.getElementById("submit-otp") ?? {};
                    submitOTPButton.onclick = () => {
                        if (otpField.value === '') {
                            localStorage.setItem("login-otp-require", "invalid");
                        }
                    }

                    otpField.oninput = () => {
                        otpError.hidden = true;
                        otpField.setAttribute("aria-invalid", false);
                        localStorage.setItem("login-otp-require", "valid");
                    };
                </script>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>