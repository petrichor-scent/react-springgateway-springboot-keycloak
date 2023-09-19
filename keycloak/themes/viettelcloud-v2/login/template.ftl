<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}">

<#assign realResourcesCommonPath = url.resourcesCommonPath[0..url.resourcesCommonPath?length - 10]>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${realm.displayName!'Viettel Cloud'}</title>
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
    <#if recaptchaRequired??>
        <#--Only show in Register page-->
        <script src="//www.google.com/recaptcha/api.js?hl=${locale.current?lower_case}"></script>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
<div class="outer-locale">
    <div onclick="location.href = '/realms/viettel-cloud/account/';" style="cursor: pointer;">
        <img src="${realResourcesCommonPath}/${properties.realm_name!}/img/logo-white.svg" width="240" alt="White Viettel Cloud logo" />
    </div>
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
</div>
<div class="login-pf-page" style="z-index: 2;">
    <div class="${properties.kcFormCardClass!}">
        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
            <div class="inner-locale">
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
            </div>
        </#if>
        <div class="logo-container">
            <div onclick="location.href = '/realms/viettel-cloud/account/';">
                <img src="${url.resourcesPath}/img/logo-black.png" width="200" alt="Black Viettel Cloud logo" />
            </div>
        </div>
        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div id="alert-notification" class="alert alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>" style="margin-top: 24px; margin-bottom: -12px;">
                <div class="pf-c-alert__icon">
                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                </div>
                <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
            </div>
        </#if>
        <header>
            <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                <#if displayRequiredFields>
                    <div class="${properties.kcContentWrapperClass!}">
                        <div class="${properties.kcLabelWrapperClass!} subtitle">
                            <span class="subtitle"><span class="required">*</span>${msg("requiredFields")}</span>
                        </div>
                        <div class="col-md-10">
                            <h1 id="kc-page-title"><#nested "header"></h1>header
                            <p>${msg("subtitle")}</p>
                        </div>
                    </div>
                <#else>
                    <h1 id="page-title"><#nested "header"></h1>
                </#if>
            <#else>
                <#if displayRequiredFields>
                    <h1 id="page-title"><#nested "header"></h1>
                    <p style="text-align: center; font-size: 16px;">${msg("signInAs")} <strong>${auth.attemptedUsername}</strong></p>
                    <div class="form-group">
                        <button id="reset-login" class="auth-button text-button" type="button" onclick="location.href = '${url.loginRestartFlowUrl}';">
                            ← ${msg("restartLoginTooltip")}
                        </button>
                    </div>
                <#else>
                    <h1 id="page-title"><#nested "header"></h1>
                    <#nested "show-username">
                    <p style="text-align: center; font-size: 16px;">${msg("signInAs")} <strong>${auth.attemptedUsername}</strong></p>
                </#if>
            </#if>
        </header>
        <div id="kc-content">
            <div id="kc-content-wrapper">
                <#nested "form">
                <#if auth?has_content && auth.showUsername() && !auth.showResetCredentials()>
                    <div class="form-group">
                        <button id="reset-login" class="auth-button text-button" type="button" onclick="location.href = '${url.loginRestartFlowUrl}';">
                            ← ${msg("restartLoginTooltip")}
                        </button>
                    </div>
                </#if>
            </div>
        </div>
    </div>
</div>
<script type="module">
    (async function() {
        if ("${properties.ga_enable!}" === "enable") {
            let  { initializeApp } = await import("https://www.gstatic.com/firebasejs/9.10.0/firebase-app.js");
            let  { getAnalytics, logEvent } = await import("https://www.gstatic.com/firebasejs/9.10.0/firebase-analytics.js");

            const firebaseConfig = {
                apiKey: "${properties.ga_apiKey!}",
                authDomain: "${properties.ga_authDomain!}",
                projectId: "${properties.ga_projectId!}",
                storageBucket: "${properties.ga_storageBucket!}",
                messagingSenderId: "${properties.ga_messagingSenderId!}",
                appId: "${properties.ga_appId!}",
                measurementId: "${properties.ga_measurementId!}"
            };

            const app = initializeApp(firebaseConfig);
            const analytics = getAnalytics(app);

            function sendToGoogleAnalytics({name, delta, id, rating}) {
                logEvent(analytics, name, {
                    event_category: 'Web Vitals',
                    name,
                    event_label: id,
                    value: Math.round(name === 'CLS' ? delta * 1000 : delta),
                    rating,
                })
            }

            (function () {
                let script = document.createElement('script');
                script.src = "${url.resourcesPath}/js/web-vitals.iife.js";
                script.onload = function () {
                    webVitals.onCLS(sendToGoogleAnalytics);
                    webVitals.onFID(sendToGoogleAnalytics);
                    webVitals.onLCP(sendToGoogleAnalytics);
                    webVitals.onTTFB(sendToGoogleAnalytics);
                    webVitals.onFCP(sendToGoogleAnalytics);
                    webVitals.onINP(sendToGoogleAnalytics);
                };
                document.head.appendChild(script);
            }());
        }
    })();
</script>
</body>
</html>
</#macro>
