package org.viettelcloud.locale;

import org.jboss.logging.Logger;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.sessions.AuthenticationSessionModel;

import javax.ws.rs.core.Cookie;
import javax.ws.rs.core.HttpHeaders;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import org.keycloak.locale.LocaleSelectorProvider;

public class CustomLocaleSelectorProvider implements LocaleSelectorProvider {

    private static final Logger logger = Logger.getLogger(LocaleSelectorProvider.class);

    private KeycloakSession session;

    public CustomLocaleSelectorProvider(KeycloakSession session) {
        this.session = session;
    }

    @Override
    public Locale resolveLocale(RealmModel realm, UserModel user) {
        HttpHeaders requestHeaders = session.getContext().getRequestHeaders();
        AuthenticationSessionModel session = this.session.getContext().getAuthenticationSession();

        if (!realm.isInternationalizationEnabled()) {
            return Locale.ENGLISH;
        }

        Locale userLocale = getUserLocale(realm, session, user, requestHeaders);
        if (userLocale != null) {
            return userLocale;
        }

        String realmDefaultLocale = realm.getDefaultLocale();
        if (realmDefaultLocale != null) {
            return Locale.forLanguageTag(realmDefaultLocale);
        }

        return Locale.ENGLISH;
    }

    private Locale getUserLocale(RealmModel realm, AuthenticationSessionModel session, UserModel user, HttpHeaders requestHeaders) {
        Locale locale;

        locale = getUserSelectedLocale(realm, session);
        if (locale != null) {
            return locale;
        }

        locale = getUserProfileSelection(realm, user);
        if (locale != null) {
            return locale;
        }

        locale = getClientSelectedLocale(realm, session);
        if (locale != null) {
            return locale;
        }

        locale = getLocaleCookieSelection(realm, requestHeaders);
        if (locale != null) {
            return locale;
        }

        locale = getAcceptLanguageHeaderLocale(realm, requestHeaders);
        if (locale != null) {
            return locale;
        }

        return null;
    }

    private Locale getUserSelectedLocale(RealmModel realm, AuthenticationSessionModel session) {
        if (session == null) {
            return null;
        }

        String locale = session.getAuthNote(USER_REQUEST_LOCALE);
        if (locale == null) {
            return null;
        }

        return findLocale(realm, locale);
    }

    private Locale getUserProfileSelection(RealmModel realm, UserModel user) {
        if (user == null) {
            return null;
        }

        String locale = user.getFirstAttribute(UserModel.LOCALE);
        if (locale == null) {
            return null;
        }

        return findLocale(realm, locale);
    }

    private Locale getClientSelectedLocale(RealmModel realm, AuthenticationSessionModel session) {
        if (session == null) {
            return null;
        }

        String locale = session.getAuthNote(LocaleSelectorProvider.CLIENT_REQUEST_LOCALE);
        if (locale == null) {
            return null;
        }

        return findLocale(realm, locale.split(" "));
    }

    private Locale getLocaleCookieSelection(RealmModel realm, HttpHeaders httpHeaders) {
        if (httpHeaders == null) {
            return null;
        }

        Cookie localeCookie = httpHeaders.getCookies().get(LOCALE_COOKIE);
        if (localeCookie == null) {
            return null;
        }

        return findLocale(realm, localeCookie.getValue());
    }

    private Locale getAcceptLanguageHeaderLocale(RealmModel realm, HttpHeaders httpHeaders) {
        return null;
    }

    private Locale findLocale(RealmModel realm, String... localeStrings) {
        List<Locale> supportedLocales = realm.getSupportedLocalesStream()
                .map(Locale::forLanguageTag).collect(Collectors.toList());
        for (String localeString : localeStrings) {
            if (localeString != null) {
                Locale result = null;
                Locale search = Locale.forLanguageTag(localeString);
                for (Locale supportedLocale : supportedLocales) {
                    if (supportedLocale.getLanguage().equals(search.getLanguage())) {
                        if (search.getCountry().equals("") ^ supportedLocale.getCountry().equals("") && result == null) {
                            result = supportedLocale;
                        }
                        if (supportedLocale.getCountry().equals(search.getCountry())) {
                            return supportedLocale;
                        }
                    }
                }
                if (result != null) {
                    return result;
                }
            }
        }
        return null;
    }

    @Override
    public void close() { }

}
