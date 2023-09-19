<#macro mainLayout active bodyClass>
<!doctype html>
<html>

<#assign realResourcesCommonPath = url.resourcesCommonPath[0..url.resourcesCommonPath?length - 10]>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <title>${realm.displayName} | ${msg("accountManagementTitle")}</title>
    <link rel="icon" href="${realResourcesCommonPath}/${properties.realm_name!}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${realResourcesCommonPath}/${properties.realm_name!}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scriptsCommon?has_content>
        <#list properties.scriptsCommon?split(' ') as script>
            <script src="${realResourcesCommonPath}/${properties.realm_name!}/${script}" type="module"></script>
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>
<body class="admin-console user ${bodyClass}">
    <div id="mask" style="display: none;"></div>
    <div class="main">
        <div id="sidebar" class="initial">
            <div id="logo">
                <div onclick="location.href = '/realms/viettel-cloud/account/';" style="cursor: pointer; margin-right: 30px;">
                    <img src="${realResourcesCommonPath}/${properties.realm_name!}/img/logo-white.svg" width="145" alt="White Viettel Cloud logo">
                </div>
                <img src="${url.resourcesPath}/img/sidebar/toggle-sidebar.svg" width="28" style="padding-top: 4px;" alt="" id="sidebar-toggle">
            </div>
            <ul>
                <li class="<#if active=='account'>active</#if>" onclick="location.href = '${url.accountUrl}';">
                    <img src="${url.resourcesPath}/img/sidebar/account.svg" alt="">
                    <p>${msg("account")}</p>
                </li>
                <#if features.passwordUpdateSupported>
                    <li class="<#if active=='password'>active</#if>" onclick="location.href = '${url.passwordUrl}';">
                        <img src="${url.resourcesPath}/img/sidebar/password.svg" alt="">
                        <p>${msg("password")}</p>
                    </li>
                </#if>
                <li class="<#if active=='totp'>active</#if>" onclick="location.href = '${url.totpUrl}';">
                    <img src="${url.resourcesPath}/img/sidebar/authenticator.svg" alt="">
                    <p>${msg("authenticator")}</p>
                </li>
                <#if features.identityFederation>
                    <li class="<#if active=='social'>active</#if>" onclick="location.href = '${url.socialUrl}';">
                        <img src="${url.resourcesPath}/img/sidebar/federatedIdentity.svg" alt="">
                        <p>${msg("federatedIdentity")}</p>
                    </li>
                </#if>
                <li class="<#if active=='sessions'>active</#if>" onclick="location.href = '${url.sessionsUrl}';">
                    <img src="${url.resourcesPath}/img/sidebar/sessions.svg" alt="">
                    <p>${msg("sessions")}</p>
                </li>
            </ul>
        </div>

        <div id="content-container">
            <div class="content-navbar">
                <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                    <label class="switch">
                        <#if locale.current == 'EN'>
                            <#if locale.current == locale.supported[0].label>
                                <input type="checkbox" checked="checked" onclick='location.href = "${locale.supported[1].url}"'>
                            <#else>
                                <input type="checkbox" checked="checked" onclick='location.href = "${locale.supported[0].url}"'>
                            </#if>
                        <#else>
                            <#if locale.current == locale.supported[0].label>
                                <input type="checkbox" onclick='location.href = "${locale.supported[1].url}"'>
                            <#else>
                                <input type="checkbox" onclick='location.href = "${locale.supported[0].url}"'>
                            </#if>
                        </#if>
                        <span class="slider round"><p>${locale.current}</p></span>
                    </label>
                </#if>
                <#if referrer?has_content && referrer.url?has_content>
                    <div>
                        <button class="account-button primary-button" onclick="location.href='${referrer.url}';" style="margin: 0" id="referrer">${msg("backTo",referrer.name)}</button>
                    </div>
                </#if>
                <div>
                    <button class="auth-button secondary-button" onclick="location.href='${url.getLogoutUrl()}';" style="margin: 0; width: 120px;">${msg("doSignOut")}</button>
                </div>
            </div>
            <div class="content">
                <#if message?has_content>
                    <div id="alert-notification" class="alert alert-${message.type} custom-alert">
                        <#if message.type=='success'><p class="pficon pficon-ok" style="position: relative; top: 0; left: 0;"></p></#if>
                        <#if message.type=='error'><p class="pficon pficon-error-circle-o" style="position: relative; top: 0; left: 0;"></p></#if>
                        <span class="kc-feedback-text" style="margin-left: 12px">${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                    <script>
                        let alertNotification = document.getElementById("alert-notification");
                        setTimeout(() => {
                            alertNotification.style.display = "none";
                        }, 5000);
                    </script>
                </#if>
                <div class="nested-content">
                    <#nested "content">
                </div>
            </div>
            <div id="footer" class="initial">
                <a href="https://viettelcloud.vn/privacy">${msg("privacy")}</a>
                <a href="https://viettelcloud.vn/term">${msg("terms")}</a>
                <p>${msg("license")}</p>
            </div>
        </div>
    </div>

    <script>
        const sidebar = document.getElementById("sidebar");
        const mask = document.getElementById("mask");
        const contentContainer = document.getElementById("content-container");
        const sidebarToggle = document.getElementById("sidebar-toggle");
        const footer = document.getElementById("footer");

        const toggleAction = () => {
            if (mask.style.display === "none") mask.style.display = "initial";
            else mask.style.display = "none";

            sidebar.classList.remove("initial");
            footer.classList.remove("initial");
            sidebar.classList.toggle("hide-sidebar");
            footer.classList.toggle("hide-sidebar");
            contentContainer.classList.toggle("hide-sidebar");
        }

        sidebarToggle.onclick = toggleAction;
        mask.onclick = toggleAction;
    </script>
</body>
</html>
</#macro>