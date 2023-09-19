package org.viettelcloud.events.custom.handler;

import org.jboss.logging.Logger;
import org.keycloak.email.DefaultEmailSenderProvider;
import org.keycloak.email.EmailException;
import org.keycloak.email.EmailTemplateProvider;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.UserProvider;
import org.keycloak.theme.Theme;

import java.util.HashMap;
import java.util.Map;

public class UserLockedHandler extends BaseHandler {
    public UserLockedHandler(Event event, KeycloakSession session) {
        super(event, session);
    }

    @Override
    public void handle() {
        RealmModel realm = session.getContext().getRealm();
        UserProvider users = this.session.getProvider(UserProvider.class);
        UserModel user = users.getUserById(event.getUserId(), realm);
        try {
            if(user.getEmail() != null && !user.getEmail().isEmpty()) {
                log.infof("Sending user locked notification email to address %s", user.getEmail());
                sendEmail(user, realm);
                log.infof("Sent user locked notification email to address %s", user.getEmail());
            }
        } catch (EmailException e) {
            log.errorf("Unable to send user locked notfication email to address %s: %s",
                        user.getEmail(), e.getMessage());
            e.printStackTrace();
        }
    }

    private void sendEmail(UserModel user, RealmModel realm) throws EmailException {
        EmailTemplateProvider emailProvider = session.getProvider(EmailTemplateProvider.class);
        emailProvider.setRealm(realm);
        emailProvider.setUser(user);

        Map<String, Object> bodyAttributes = new HashMap<>();
        bodyAttributes.put("user", user.getUsername());
        bodyAttributes.put("realmName", realm.getDisplayName());

        emailProvider.send("emailNotifyUserDisableSubject", "email-notify-user-disable.ftl", bodyAttributes);
    }
}