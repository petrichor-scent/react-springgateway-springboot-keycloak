package org.viettelcloud.locale;

import org.keycloak.Config;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;

import org.keycloak.locale.LocaleSelectorProviderFactory;
import org.keycloak.locale.LocaleSelectorProvider;

public class CustomLocaleSelectorProviderFactory implements LocaleSelectorProviderFactory {
    @Override
    public LocaleSelectorProvider create(KeycloakSession session) {
        return new CustomLocaleSelectorProvider(session);
    }

    @Override
    public void init(Config.Scope config) {
    }

    @Override
    public void postInit(KeycloakSessionFactory factory) {
    }

    @Override
    public void close() {
    }

    @Override
    public String getId() {
        return "custom";
    }
}
