<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>

    <div class="title-container">
        <img src="${url.resourcesPath}/img/icons/title.svg" alt="" height="56">
        <h2 class="content-title">${msg("editAccountHtmlTitle")}</h2>
    </div>

    <script>
        const clearError = () => {
            const errorHidden = document.querySelector(".alert.alert-error.custom-alert");
            if (errorHidden?.style) errorHidden.style.display = 'none';
        }
        clearError();
        window.addEventListener('load', clearError);
    </script>
    <form action="${url.accountUrl}" method="post">

        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

        <#if !realm.registrationEmailAsUsername>
            <div class="form-group">
                <label for="username" class="form-label">${msg("username")}<span
                            class="red-asterisk"> *</span></label>
                <#if realm.editUsernameAllowed>
                    <div class="clear-container">
                        <input type="text" id="username" class="form-input" name="username"
                               value="${(account.username!'')}" autocomplete="username"
                               maxlength="150"
                               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                        />
                        <button class="clear-button" tabindex="-1" type="button"></button>
                    </div>
                <#else>
                    <input type="text" id="username" class="form-input" name="username"
                           value="${(account.username!'')}" autocomplete="username"
                           maxlength="150" disabled
                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                    />
                </#if>
                <script>
                    const username = document.getElementById('username');
                    username.onblur = () => {
                        username.value = username.value.trim();
                    }
                </script>
            </div>
        </#if>

        <div class="form-group">
            <label for="email" class="form-label">${msg("email")}<span class="red-asterisk"> *</span></label>
            <div class="clear-container">
                <input type="text" id="email" class="form-input" name="email"
                       value="${(account.email!'')}" autocomplete="email"
                       maxlength="150"
                       autofocus
                       aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                />
                <button class="clear-button" tabindex="-1" type="button"></button>
            </div>
            <#if messagesPerField.existsError('email')>
                <span id="input-error-email" class="form-input-wrong" aria-live="polite">
                    ${kcSanitize(messagesPerField.get('email'))?no_esc}
                </span>
            </#if>
            <script>
                const email = document.getElementById('email');
                email.onblur = () => {
                    email.value = email.value.trim();
                }
            </script>
        </div>

        <div class="horizontal-form">
            <div class="form-group">
                <label for="firstName" class="form-label">${msg("firstName")}<span
                            class="red-asterisk"> *</span></label>
                <div class="clear-container">
                    <input type="text" id="firstName" class="form-input" name="firstName"
                           value="${(account.firstName!'')}"
                           maxlength="150"
                           aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                    />
                    <button class="clear-button" tabindex="-1" type="button"></button>
                </div>
                <#if messagesPerField.existsError('firstName')>
                    <span id="input-error-firstname" class="form-input-wrong" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                    </span>
                </#if>
                <script>
                    const firstName = document.getElementById('firstName');
                    firstName.onblur = () => {
                        firstName.value = firstName.value.trim();
                    }
                </script>
            </div>
            <div class="form-group">
                <label for="lastName" class="form-label">${msg("lastName")}<span class="red-asterisk"> *</span></label>
                <div class="clear-container">
                    <input type="text" id="lastName" class="form-input" name="lastName"
                           value="${(account.lastName!'')}"
                           maxlength="150"
                           aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                    />
                    <button class="clear-button" tabindex="-1" type="button"></button>
                </div>
                <#if messagesPerField.existsError('lastName')>
                    <span id="input-error-lastname" class="form-input-wrong" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                    </span>
                </#if>
                <script>
                    const lastName = document.getElementById('lastName');
                    lastName.onblur = () => {
                        lastName.value = lastName.value.trim();
                    }
                </script>
            </div>
        </div>

        <div class="button-group">
            <#if url.referrerURI??>
                <a href="${url.referrerURI}">${kcSanitize(msg("backToApplication")?no_esc)}</a>
            </#if>
            <div>
                <button type="button"
                        class="account-button secondary-button"
                        name="cancelAction" value="Cancel">
                    ${msg("doCancel")}
                </button>
            </div>
            <div>
                <button type="submit"
                        class="account-button primary-button"
                        name="submitAction" value="Save">
                    ${msg("doSave")}
                </button>
            </div>
        </div>

        <script>
            clearError();

            firstName.oninput = () => {
                const firstNameError = document.getElementById("input-error-firstname") ?? {};
                firstNameError.hidden = true;
                firstName.setAttribute('aria-invalid', false);
            };
            lastName.oninput = () => {
                const lastNameError = document.getElementById("input-error-lastname") ?? {};
                lastNameError.hidden = true;
                lastName.setAttribute('aria-invalid', false);
            };
            email.oninput = () => {
                const emailError = document.getElementById("input-error-email") ?? {};
                emailError.hidden = true;
                email.setAttribute('aria-invalid', false);
            };

            const cancelButton = document.getElementsByName('cancelAction')[0];
            cancelButton.addEventListener('click', () => {
                clearError();
                firstName.value = "${(account.firstName!'')}";
                lastName.value = "${(account.lastName!'')}";
                email.value = "${(account.email!'')}";
            });
        </script>
    </form>

</@layout.mainLayout>
