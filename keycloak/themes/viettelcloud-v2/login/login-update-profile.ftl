<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','email','firstName','lastName'); section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <script>
            document.title = "${realm.displayName} | ${msg("loginProfileTitle")}";
        </script>
        <form id="kc-update-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <#if user.editUsernameAllowed>
                <div class="form-group">
                    <label for="username-show" class="form-label">${msg("username")}<span class="red-asterisk"> *</span></label>
                    <#if user.username?has_content>
                        <input type="text" id="username" name="username" style="display: none;" value="${(user.username!'')}" />
                        <input type="text" id="username-show" class="form-input" disabled value="${(user.username!'')}" />
                    <#else>
                        <div class="clear-container">
                            <input type="text" id="username" name="username" class="form-input" value="${(user.username!'')}" />
                            <button class="clear-button" tabindex="-1" type="button"></button>
                        </div>
                    </#if>
                </div>
            </#if>
            <div class="form-group">
                <label for="email-show" class="form-label">${msg("email")}<span class="red-asterisk"> *</span></label>
                <#if user.email?has_content>
                    <input type="text" id="email" name="email" style="display: none;" value="${(user.email!'')}" />
                    <input type="text" id="email-show" class="form-input" disabled value="${(user.email!'')}" />
                <#else>
                    <div class="clear-container">
                        <input type="text" id="email" name="email" class="form-input" value="${(user.email!'')}" autofocus />
                        <button class="clear-button" tabindex="-1" type="button"></button>
                    </div>
                </#if>
            </div>
            <div class="form-group">
                <label for="firstName-show" class="form-label">${msg("firstName")}<span class="red-asterisk"> *</span></label>
                <input type="text" id="firstName" name="firstName" style="display: none;" value="${(user.firstName!'')}" />
                <input type="text" id="firstName-show" class="form-input" disabled
                       value="${(user.firstName!'')}"
                />
            </div>
            <div class="form-group">
                <label for="lastName-show" class="form-label">${msg("lastName")}<span class="red-asterisk"> *</span></label>
                <input type="text" id="lastName" name="lastName" style="display: none;" value="${(user.lastName!'')}" />
                <input type="text" id="lastName-show" class="form-input" disabled
                       value="${(user.lastName!'')}"
                />
            </div>

            <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                <div class="${properties.kcFormOptionsWrapperClass!}">
                </div>
            </div>

            <div id="kc-form-buttons">
                <#if isAppInitiatedAction??>
                    <div class="form-group" style="margin-top: 32px;">
                        <#if user.username?has_content && user.email?has_content>
                            <button class="auth-button primary-button" type="submit" value="${msg("doBack")}">
                                ${msg("doBack")}
                            </button>
                        <#else>
                            <button class="auth-button primary-button" id="submit-button" type="submit" value="${msg("doSubmit")}">
                                ${msg("doSubmit")}
                            </button>
                            <script>
                                const email = document.getElementById("email");
                                const submit = document.getElementById("submit-button");
                                const validateEmail = () => {
                                    const content = email.value.trim();
                                    email.value = content;
                                    if (content === "" || !(/^[\w-\.]+@[\w-\.]+$/).exec(content)) {
                                        submit.disabled = true;
                                        submit.classList.remove("primary-button");
                                        submit.classList.add("secondary-button");
                                    }
                                    else {
                                        submit.disabled = false;
                                        submit.classList.add("primary-button");
                                        submit.classList.remove("secondary-button");
                                    }
                                }
                                validateEmail();
                                email.oninput = validateEmail;
                            </script>
                        </#if>
                    </div>
                    <div class="form-group">
                        <button class="auth-button secondary-button" type="submit" name="cancel-aia" value="true">
                            ${msg("doCancel")}
                        </button>
                    </div>
                <#else>
                    <div class="form-group" style="margin-top: 32px;">
                        <#if user.username?has_content && user.email?has_content>
                            <button class="auth-button primary-button" type="submit" value="${msg("doBack")}">
                                ${msg("doBack")}
                            </button>
                        <#else>
                            <button class="auth-button primary-button" id="submit-button" type="submit" value="${msg("doSubmit")}">
                                ${msg("doSubmit")}
                            </button>
                            <script>
                                const email = document.getElementById("email");
                                const submit = document.getElementById("submit-button");
                                const validateEmail = () => {
                                    const content = email.value.trim();
                                    email.value = content;
                                    if (content === "" || !(/^[\w-\.]+@[\w-\.]+$/).exec(content)) {
                                        submit.disabled = true;
                                        submit.classList.remove("primary-button");
                                        submit.classList.add("secondary-button");
                                    }
                                    else {
                                        submit.disabled = false;
                                        submit.classList.add("primary-button");
                                        submit.classList.remove("secondary-button");
                                    }
                                }
                                validateEmail();
                                email.oninput = validateEmail;
                            </script>

                        </#if>
                    </div>
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
