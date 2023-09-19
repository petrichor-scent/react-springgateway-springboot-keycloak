<#macro mainLayout active bodyClass>
    <!doctype html>
    <html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <title>Viettel Cloud</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico">
        <#if properties.stylesCommon?has_content>
            <#list properties.stylesCommon?split(' ') as style>
                <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <link href="${url.resourcesPath}/css/blank.css" rel="stylesheet" />
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script type="text/javascript" src="${url.resourcesPath}/${script}"></script>
            </#list>
        </#if>
    </head>
    <body>
        <div id="blank">
            <div class="container">
                <div class="content">
                    <div style="width: 100%; display: flex; justify-content: space-between">
                        <div class="logo-group">
                            <i id="logo-red" aria-hidden="true"></i>
                        </div>
                        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                            <div id="kc-locale">
                                <#if locale.current == locale.supported[0].label>
                                    <div onclick='location.href = "${locale.supported[1].url}"' style="display: flex; align-items: center;">
                                        <i id="locale" class="locale locale-${locale.supported[1].label}" aria-hidden="true"></i>
                                        <p class="locale">${locale.supported[1].label}</p>
                                    </div>
                                <#else>
                                    <div onclick='location.href = "${locale.supported[0].url}"' style="display: flex; align-items: center;">
                                        <i id="locale" class="locale locale-${locale.supported[0].label}" aria-hidden="true"></i>
                                        <p class="locale">${locale.supported[0].label}</p>
                                    </div>
                                </#if>
                            </div>
                        </#if>
                    </div>
                    <header style="text-align: center">
                        <h1 id="page-title">${msg("welcomeTitle")}</h1>
                        <p id="page-subtitle-internal">${msg("welcomeSubtitle")}</p>
                    </header>
                    <div class="form-group" style="margin-top: 40px;">
                        <input class="auth-button primary-button" id="change-layout" type="submit" value="${msg("doContinue")}"/>
                        <script>
                            let changeLayout = document.getElementById('change-layout');
                            changeLayout.onclick = () => {
                                let blank = document.getElementById('blank');
                                blank.classList.toggle('hide');
                                let console = document.getElementById('console');
                                console.classList.toggle('hide');
                            }
                        </script>
                    </div>
                    <div class="form-group">
                        <input class="auth-button secondary-button" onclick="location.href = '${url.getLogoutUrl()}'" type="submit" value="${msg("doSignOut")}"/>
                    </div>
                </div>
            </div>
            <div class="bottom-banner bottom-banner-red"></div>
            <div class="bottom-banner bottom-banner-gray"></div>
        </div>
        <div id="console" class="hide">
            <header class="navbar navbar-default navbar-pf navbar-main header">
                <nav class="navbar" role="navigation">
                    <div class="navbar-header">
                        <div class="container">
                            <h1 class="navbar-title">Keycloak</h1>
                        </div>
                    </div>
                    <div class="navbar-collapse navbar-collapse-1">
                        <div class="container">
                            <ul class="nav navbar-nav navbar-utility">
                                <#if realm.internationalizationEnabled>
                                <li>
                                    <div class="kc-dropdown" id="kc-locale-dropdown">
                                        <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                        <ul>
                                            <#list locale.supported as l>
                                                <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                            </#list>
                                        </ul>
                                    </div>
                                <li>
                                    </#if>
                                <#if referrer?has_content && referrer.url?has_content><li><a href="${referrer.url}" id="referrer">${msg("backTo",referrer.name)}</a></li></#if>
                                <li><a href="${url.getLogoutUrl()}">${msg("doSignOut")}</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </header>
            <div class="container">
                <div class="bs-sidebar col-sm-3">
                    <ul>
                        <li class="<#if active=='account'>active</#if>"><a href="${url.accountUrl}">${msg("account")}</a></li>
                        <#if features.passwordUpdateSupported><li class="<#if active=='password'>active</#if>"><a href="${url.passwordUrl}">${msg("password")}</a></li></#if>
                        <li class="<#if active=='totp'>active</#if>"><a href="${url.totpUrl}">${msg("authenticator")}</a></li>
                        <#if features.identityFederation><li class="<#if active=='social'>active</#if>"><a href="${url.socialUrl}">${msg("federatedIdentity")}</a></li></#if>
                        <li class="<#if active=='sessions'>active</#if>"><a href="${url.sessionsUrl}">${msg("sessions")}</a></li>
                        <li class="<#if active=='applications'>active</#if>"><a href="${url.applicationsUrl}">${msg("applications")}</a></li>
                        <#if features.log><li class="<#if active=='log'>active</#if>"><a href="${url.logUrl}">${msg("log")}</a></li></#if>
                        <#if realm.userManagedAccessAllowed && features.authorization><li class="<#if active=='authorization'>active</#if>"><a href="${url.resourceUrl}">${msg("myResources")}</a></li></#if>
                    </ul>
                </div>

                <div class="col-sm-9 content-area">
                    <#if message?has_content>
                        <div class="alert alert-${message.type}">
                            <#if message.type=='success' ><span class="pficon pficon-ok"></span></#if>
                            <#if message.type=='error' ><span class="pficon pficon-error-circle-o"></span></#if>
                            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                        </div>
                    </#if>

                    <#nested "content">
                </div>
            </div>
        </div>
    </body>
    </body>
    </html>
</#macro>
