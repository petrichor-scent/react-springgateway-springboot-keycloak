<#import "template.ftl" as layout>
<@layout.mainLayout active='totp' bodyClass='totp'; section>

    <div class="title-container">
        <img src="${url.resourcesPath}/img/icons/title.svg" alt="" height="56">
        <h2 class="content-title">${msg("authenticatorTitle")}</h2>
    </div>

    <script>
        const clearError = () => {
            const errorHidden = document.querySelector(".alert.alert-error.custom-alert");
            if (errorHidden?.style) errorHidden.style.display = 'none';
        }
        clearError();
        window.addEventListener('load', clearError);
    </script>
    <#if totp.enabled>
        <table class="table custom-table">
            <thead>
                <tr>
                    <td style="padding-left: 24px;">${msg("deviceName")}</td>
                    <td>${msg("deviceId")}</td>
                    <td>${msg("action")}</td>
                </tr>
            </thead>
            <tbody>
                <#list totp.otpCredentials as credential>
                <tr>
                    <td class="provider" style="padding-left: 24px;">${credential.userLabel!}</td>
                    <td class="provider">${credential.id}</td>
                    <td class="action">
                        <form action="${url.totpUrl}" method="post" class="form-inline">
                            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                            <input type="hidden" id="submitAction" name="submitAction" value="Delete">
                            <input type="hidden" id="credentialId" name="credentialId" value="${credential.id}">
<#--                            Just for displaying-->
                            <button id="fake-button" type="button" style="background: none; border: none; margin-bottom: 4px;">
                                <img src="${url.resourcesPath}/img/icons/trash.svg" alt="">
                            </button>
                            <button id="remove-mobile" style="display: none"></button>
                            <div id="tooltip-remove" class="pf-c-tooltip pf-m-right" style="position: absolute; display: none;" role="tooltip">
                                <div class="pf-c-tooltip__arrow tooltip-arrow"></div>
                                <div class="pf-c-tooltip__content tooltip-content">${msg("deleteAuthenticator")}</div>
                            </div>
                            <script>
                                const fakeButton = document.getElementById("fake-button");
                                const removeMobile = document.getElementById("remove-mobile");
                                const tooltipRemove = document.getElementById("tooltip-remove");

                                fakeButton.onclick = (event) => {
                                    event.preventDefault();
                                    if (confirm("${msg("confirmDeleteAuthenticator")}")) {
                                        removeMobile.click();
                                    }
                                }
                                fakeButton.onmouseover = () => {
                                    tooltipRemove.style.display = 'initial';
                                };
                                fakeButton.onmouseout = () => {
                                    tooltipRemove.style.display = 'none';
                                };
                            </script>
                        </form>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <script>
            const mainContent = document.getElementsByClassName("nested-content")[0];
            mainContent.style.marginTop = '120px';
        </script>
        <ol>
            <li>
                <p>
                    ${msg("totpStep1")}
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
                    <p>${msg("totpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("totpScanBarcode")}</a></p>
                </li>
                <li>
                    <p>${msg("totpManualStep3")}</p>
                    <p>
                        <ul>
                            <li id="kc-totp-type">${msg("totpType")}: ${msg("totp." + totp.policy.type)}</li>
                            <li id="kc-totp-algorithm">${msg("totpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                            <li id="kc-totp-digits">${msg("totpDigits")}: ${totp.policy.digits}</li>
                            <#if totp.policy.type = "totp">
                                <li id="kc-totp-period">${msg("totpInterval")}: ${totp.policy.period}</li>
                            <#elseif totp.policy.type = "hotp">
                                <li id="kc-totp-counter">${msg("totpCounter")}: ${totp.policy.initialCounter}</li>
                            </#if>
                        </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("totpStep2")}</p>
                    <div style="width: 100%; text-align: center;">
                        <img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode" width="180px" height="180px">
                    </div>
                    <p style="text-align: center"><a href="${totp.manualUrl}" id="mode-manual">${msg("totpUnableToScan")}</a></p>
                </li>
            </#if>
            <li>
                <p>${kcSanitize(msg("totpStep3Html"))?no_esc}</p>
                <p>${kcSanitize(msg("totpStep3DeviceNameHtml"))?no_esc}</p>
            </li>
        </ol>

        <hr/>

        <form action="${url.totpUrl}" class="form-horizontal" method="post">
            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
            <div class="form-group">
                <label for="totp" class="form-label">${msg("authenticatorCode")}<span class="red-asterisk"> *</span></label>
                <div class="clear-container">
                    <input maxlength="6" type="text" class="form-input" id="totp" name="totp"
                           autocomplete="off" autofocus
                    />
                    <button class="clear-button" tabindex="-1" type="button"></button>
                </div>
                <span id="input-error-otp-code" class="form-input-wrong" aria-live="polite"></span>
                <script>
                    const inputOTP = document.getElementById("totp");
                    const inputErrorOTP = document.getElementById("input-error-otp-code");
                    inputOTP.oninput = () => {
                        inputOTP.removeAttribute("aria-invalid");
                        inputErrorOTP.style.display = 'none';
                    }
                    if (document.getElementsByClassName("alert alert-error custom-alert").length > 0) {
                        const alert = document.getElementsByClassName("alert alert-error custom-alert")[0];
                        alert.style.display = 'none';
                        inputErrorOTP.style.display = 'block';
                        inputErrorOTP.innerHTML = alert.innerText;
                        inputOTP.setAttribute('aria-invalid', "true");
                    }
                </script>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}"/>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('userLabel',properties.kcFormGroupErrorClass!)}">
                <label for="userLabel" class="form-label">${msg("totpDeviceName")}<#if totp.otpCredentials?size gte 1><span class="red-asterisk"> *</span></#if></label>
                <div class="clear-container">
                    <input maxlength="50" type="text" class="form-input" id="userLabel" name="userLabel" autocomplete="off">
                    <button class="clear-button" tabindex="-1" type="button"></button>
                </div>
            </div>

            <div class="button-group">
                <div>
                    <button type="button"
                            class="account-button secondary-button"
                            id="cancelTOTPBtn" name="cancelAction" value="Cancel">
                        ${msg("doCancel")}
                    </button>
                </div>
                <div>
                    <button type="submit"
                            class="account-button primary-button"
                            id="saveTOTPBtn" name="submitAction" value="Save">
                        ${msg("doSave")}
                    </button>
                </div>
            </div>

            <script>
                clearError();

                const cancelButton = document.getElementsByName('cancelAction')[0];
                cancelButton.addEventListener('click', () => {
                    clearError();
                    const totp = document.getElementById("totp");
                    const userLabel = document.getElementById("userLabel");
                    const inputErrorOtpCode = document.getElementById("input-error-otp-code");
                    totp.value = "";
                    userLabel.value = "";
                    totp.removeAttribute("aria-invalid");
                    userLabel.removeAttribute("aria-invalid");
                    inputErrorOtpCode.style.display = 'none';
                });
            </script>
        </form>
    </#if>

</@layout.mainLayout>
