<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginIdpReviewProfileTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-idp-review-profile-form" action="${url.loginAction}"
                      method="post">

                    <div class="form-group">
                        <label for="firstName" class="form-label">${msg("firstName")}<span
                                    class="red-asterisk"> *</span></label>
                        <input type="text" id="firstName" class="form-input" name="firstName"
                               value="${(register.formData.firstName!'')}"
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
                               value="${(register.formData.lastName!'')}"
                               placeholder="${msg("lastNamePlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                        />
                        <#if messagesPerField.existsError('lastName')>
                            <span id="input-error-lastname" class="form-input-wrong" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                            </span>
                        </#if>
                    </div>
                    <div class="form-group">
                        <label for="email" class="form-label">${msg("email")}<span class="red-asterisk"> *</span></label>
                        <input type="text" id="email" class="form-input" name="email"
                               value="${(register.formData.email!'')}" autocomplete="email"
                               placeholder="${msg("passwordPlaceholder")}"
                               aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                        />

                        <#if messagesPerField.existsError('email')>
                            <span id="input-error-email" class="form-input-wrong" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('email'))?no_esc}
                                </span>
                        </#if>
                    </div>

                    <#if !realm.registrationEmailAsUsername>
                        <div class="form-group">
                            <label for="username" class="form-label">${msg("username")}<span
                                        class="red-asterisk"> *</span></label>
                            <input type="text" id="username" class="form-input" name="username"
                                   value="${(register.formData.username!'')}" autocomplete="username"
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

                    <#if passwordRequired??>
                        <div class="form-group">
                            <label for="password" class="form-label">${msg("password")}<span
                                        class="red-asterisk"> *</span></label>
                            <div style="display: flex; align-items: center;">
                                <input tabindex="2" id="password" class="form-input" name="password" type="password"
                                       autocomplete="off"
                                       placeholder="${msg("passwordPlaceholder")}"
                                       aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                                />
                                <i id="show-password" class="show-password icon-eye" aria-hidden="true"></i>
                            </div>

                            <script>
                                const password = document.getElementById('password');
                                const showPassword = document.getElementById('show-password');
                                showPassword.onclick = () => {
                                    if (password.getAttribute("type") === "password") {
                                        password.setAttribute("type", "text");
                                    } else {
                                        password.setAttribute("type", "password");
                                    }
                                    showPassword.classList.toggle("icon-eye");
                                    showPassword.classList.toggle("icon-eye-invisible");
                                }
                            </script>

                            <#if usernameHidden?? && messagesPerField.existsError('password')>
                                <span id="input-error" class="form-input-wrong" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                                </span>
                            </#if>

                        </div>
                        <div class="form-group">
                            <label for="password-confirm" class="form-label">${msg("passwordConfirm")}<span
                                        class="red-asterisk"> *</span></label>
                            <div style="display: flex; align-items: center;">
                                <input tabindex="2" id="password-confirm" class="form-input" name="password-confirm"
                                       type="password" autocomplete="off"
                                       placeholder="${msg("passwordConfirmPlaceholder")}"
                                       aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                />
                                <i id="show-password-confirm" class="show-password icon-eye" aria-hidden="true"></i>
                            </div>

                            <script>
                                const passwordConfirm = document.getElementById('password-confirm');
                                const showPasswordConfirm = document.getElementById('show-password-confirm');
                                showPasswordConfirm.onclick = () => {
                                    if (passwordConfirm.getAttribute("type") === "password") {
                                        passwordConfirm.setAttribute("type", "text");
                                    } else {
                                        passwordConfirm.setAttribute("type", "password");
                                    }
                                    showPasswordConfirm.classList.toggle("icon-eye");
                                    showPasswordConfirm.classList.toggle("icon-eye-invisible");
                                }
                            </script>

                            <#if messagesPerField.existsError('password-confirm')>
                                <span id="input-error-password-confirm" class="form-input-wrong" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                    </span>
                            </#if>
                        </div>
                    </#if>

                    <div class="form-group">
                        <input type="submit" class="auth-button primary-button" value="${msg("doSubmit")}"/>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>