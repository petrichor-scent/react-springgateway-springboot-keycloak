<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','email','firstName','lastName'); section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-update-profile-form" action="${url.loginAction}" method="post">
                    <#if user.editUsernameAllowed>
                        <div class="form-group">
                            <label for="username" class="form-label">${msg("username")}<span
                                        class="red-asterisk"> *</span></label>
                            <input type="text" id="username" class="form-input" name="username"
                                   value="${(user.username!'')}" autocomplete="username"
                                   placeholder="${msg("usernamePlaceholder")}"
                                   aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                            />
                            <#if messagesPerField.existsError('username')>
                                <span id="input-error-username" class="form-input-wrong" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </#if>
                    <div class="form-group">
                        <label for="email" class="form-label">${msg("email")}<span class="red-asterisk"> *</span></label>
                        <input type="text" id="email" class="form-input" name="email"
                               value="${(user.email!'')}" autocomplete="email"
                               placeholder="${msg("passwordPlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                        />

                        <#if messagesPerField.existsError('email')>
                            <span id="input-error-email" class="form-input-wrong" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('email'))?no_esc}
                                </span>
                        </#if>
                    </div>
                    <div class="form-group">
                        <label for="firstName" class="form-label">${msg("firstName")}<span
                                    class="red-asterisk"> *</span></label>
                        <input type="text" id="firstName" class="form-input" name="firstName"
                               value="${(user.firstName!'')}"
                               placeholder="${msg("firstNamePlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                        />
                        <#if messagesPerField.existsError('firstName')>
                            <span id="input-error-firstname" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                            </span>
                        </#if>
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="form-label">${msg("lastName")}<span class="red-asterisk"> *</span></label>
                        <input type="text" id="lastName" class="form-input" name="lastName"
                               value="${(user.lastName!'')}"
                               placeholder="${msg("lastNamePlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                        />
                        <#if messagesPerField.existsError('lastName')>
                            <span id="input-error-lastname" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                            </span>
                        </#if>
                    </div>

                    <div class="form-group" style="margin-top: 40px">
                        <input class="auth-button primary-button" type="submit" value="${msg("doSubmit")}"/>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
