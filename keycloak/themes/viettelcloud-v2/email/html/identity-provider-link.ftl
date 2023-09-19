<html xmlns="http://www.w3.org/1999/html">
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
        ${kcSanitize(msg("identityProviderLinkBodyHtml", identityProviderAlias, realmName, identityProviderContext.username, link, linkExpiration, linkExpirationFormatter(linkExpiration)))?no_esc}
    </div>
    ${kcSanitize(msg("emailIntroductionHtml"))?no_esc}
    ${kcSanitize(msg("emailFooterHtml"))?no_esc}
</div>
</body>
</html>

<p>Someone wants to link your <b>{1}</b> account with <b>{0}</b> account of user {2}. If this was you, click the link below to link accounts</p>
<p style="text-align: center"><a href="{3}">Link to confirm account linking</a></p>
<p>This link will expire within {5}.</p>
<p>If you don''t want to link account, just ignore this message. If you link accounts, you will be able to login to {1} through {0}.</p>
