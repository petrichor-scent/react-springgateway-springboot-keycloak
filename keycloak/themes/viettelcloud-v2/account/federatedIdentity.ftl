<#import "template.ftl" as layout>
<@layout.mainLayout active='social' bodyClass='social'; section>

    <div class="title-container">
        <img src="${url.resourcesPath}/img/icons/title.svg" alt="" height="56">
        <h2 class="content-title">${msg("federatedIdentitiesHtmlTitle")}</h2>
    </div>

    <div id="federated-identities">
        <#list federatedIdentity.identities as identity>
            <#if identity.connected>
                <#if federatedIdentity.removeLinkPossible>
                    <form action="${url.socialUrl}" method="post" class="form-inline">
                        <div class="form-group">
                            <label for="${identity.providerId!}" class="form-label">${identity.displayName!}</label>
                            <div style="display: flex; gap: 16px;<#if !identity?is_last> margin-bottom: 8px;</#if>">
                                <input style="height: 33.33px; flex: 100%; margin-bottom: 0;" disabled class="form-input" value="${identity.userName!}">
                                <button style="height: 33.33px;" id="remove-link-${identity.providerId!}" class="account-button secondary-button">${msg("doRemove")}</button>
                            </div>
                        </div>
                        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                        <input type="hidden" id="action" name="action" value="remove">
                        <input type="hidden" id="providerId" name="providerId" value="${identity.providerId!}">
                    </form>
                </#if>
            <#else>
                <form action="${url.socialUrl}" method="post" class="form-inline">
                    <div class="form-group">
                        <label for="${identity.providerId!}" class="form-label">${identity.displayName!}</label>
                        <div style="display: flex; gap: 16px;<#if !identity?is_last> margin-bottom: 16px;</#if>">
                            <input style="height: 33.33px; flex: 100%; margin-bottom: 0;" disabled class="form-input" value="${identity.userName!}">
                            <button style="height: 33.33px;"  id="add-link-${identity.providerId!}" class="account-button primary-button">${msg("doAdd")}</button>
                        </div>
                    </div>
                    <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                    <input type="hidden" id="action" name="action" value="add">
                    <input type="hidden" id="providerId" name="providerId" value="${identity.providerId!}">
                </form>
            </#if>
        </#list>
    </div>

</@layout.mainLayout>
