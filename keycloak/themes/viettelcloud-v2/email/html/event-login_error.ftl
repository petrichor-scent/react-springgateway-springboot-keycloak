<html>
<body style="
        font-family: Sarabun, sans-serif;
        font-weight: 400;
        font-size: 18px;
        display: flex;
">
<div style="max-width: 900px; margin: 40px auto;">
    <img src="https://os.viettelcloud.vn/cmp-ui/banner.png" width="100%" height="auto"  alt="banner"/>
    <br/>

    ${kcSanitize(msg("emailGreetingHtml"))?no_esc}
    <div style="margin: 16px 0;">
        ${kcSanitize(msg("eventLoginErrorBodyHtml",event.date,event.ipAddress,realmName))?no_esc}
    </div>
    ${kcSanitize(msg("emailIntroductionHtml"))?no_esc}
    ${kcSanitize(msg("emailFooterHtml"))?no_esc}
</div>
</body>
</html>