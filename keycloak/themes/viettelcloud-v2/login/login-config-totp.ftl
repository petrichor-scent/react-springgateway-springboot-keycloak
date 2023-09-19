<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol id="kc-totp-settings">
            <li>
                <p>
                    ${msg("loginTotpStep1")}
                    <#if totp.policy.supportedApplications?size == 1>
                        <strong>${totp.policy.supportedApplications[0]}</strong>.
                    <#else>
                        <ul>
                            <li><strong>${totp.policy.supportedApplications[0]}</strong></li>
                            <li><strong>${totp.policy.supportedApplications[1]}</strong></li>
                        </ul>
                    </#if>
                </p>
            </li>

            <#if mode?? && mode = "manual">
                <li>
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                        <ul>
                            <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                            <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                            <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                            <#if totp.policy.type = "totp">
                                <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                            <#elseif totp.policy.type = "hotp">
                                <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                            </#if>
                        </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("loginTotpStep2")}</p>
                    <div style="width: 100%; text-align: center;">
                        <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode" width="180px" height="180px">
                    </div>
                    <p style="text-align: center"><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>
            <li>
                <p>${kcSanitize(msg("loginTotpStep3Html"))?no_esc} ${kcSanitize(msg("loginTotpStep3DeviceNameHtml"))?no_esc}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
            <div class="horizontal-form">
                <div class="form-group">
                    <label for="totp" class="form-label">${msg("authenticatorCode")} <span class="required">*</span></label>
                    <div class="clear-container">
                        <input type="text" id="totp" name="totp" autocomplete="off"
                               maxlength="6" class="form-input"
                               aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                        />
                        <button class="clear-button" tabindex="-1" type="button"></button>
                    </div>
                    <#if messagesPerField.existsError('totp')>
                        <span id="input-error-otp-code" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                        </span>
                    </#if>
                    <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                    <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
                </div>

                <div class="form-group">
                    <label for="userLabel" class="form-label">${msg("loginTotpDeviceName")}</label> <#if totp.otpCredentials?size gte 1><span class="required">*</span></#if>
                    <div class="clear-container">
                        <input maxlength="50" type="text" class="form-input" id="userLabel" name="userLabel" autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                        />
                        <button class="clear-button" tabindex="-1" type="button"></button>
                    </div>
                    <#if messagesPerField.existsError('userLabel')>
                        <span id="input-error-otp-label" class="form-input-wrong" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <#if isAppInitiatedAction??>
                <div class="form-group" style="margin-top: 32px;">
                    <input type="submit"
                           class="auth-button primary-button"
                           id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                </div>
                <div class="form-group">
                    <input type="submit"
                            class="auth-button secondary-button"
                            id="cancelTOTPBtn" name="cancel-aia"
                            value="${msg("doCancel")}"
                    />
                </div>
            <#else>
                <div class="form-group" style="margin-top: 32px;">
                    <input type="submit"
                           class="auth-button primary-button"
                           id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                </div>
            </#if>
        </form>
    </#if>
</@layout.registrationLayout>