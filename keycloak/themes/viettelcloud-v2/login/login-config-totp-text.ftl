<#ftl output_format="plainText">
${msg("loginTotpIntro")}

${msg("loginTotpStep1")}

<#list totp.policy.supportedApplications as app>
* ${app}
</#list>

${msg("loginTotpManualStep2")}

<strong>${totp.totpSecretEncoded}</strong>


${msg("loginTotpManualStep3")}

- ${msg("loginTotpType")}: <strong>${msg("loginTotp." + totp.policy.type)}</strong>
- ${msg("loginTotpAlgorithm")}: <strong>${totp.policy.getAlgorithmKey()}</strong>
- ${msg("loginTotpDigits")}: <strong>${totp.policy.digits}</strong>
<#if totp.policy.type = "totp">
- ${msg("loginTotpInterval")}: <strong>${totp.policy.period}</strong>

<#elseif totp.policy.type = "hotp">
- ${msg("loginTotpCounter")}: <strong>${totp.policy.initialCounter}</strong>

</#if>

Enter in your one time password so we can verify you have installed it correctly.



