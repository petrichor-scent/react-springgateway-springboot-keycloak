package org.viettelcloud.events.custom.handler;

import org.keycloak.events.Event;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.timer.TimerProvider;

import java.text.SimpleDateFormat;
import java.util.Date;

public class RegisterHandler extends BaseHandler {
    public RegisterHandler(Event event, KeycloakSession session) {
        super(event, session);
    }

    @Override
    public void handle() {
        try {
            final String USER_ID = event.getUserId();
            final String REALM_ID = event.getRealmId();
            final String EMAIL = event.getDetails().get("email");
            final String TASK_ID = "USER_REGISTRATION_CLEANUP::" + EMAIL;
            final long INTERVAL = 1000 * 60 * 5;

            TimerProvider timer = session.getProvider(TimerProvider.class);
            timer.scheduleTask((KeycloakSession keycloakSession) -> {
                // Keycloak doesn't support task delay yet, so we need to cancel it on the first try
                timer.cancelTask(TASK_ID);
                final RealmModel realmModel = keycloakSession.realms().getRealm(REALM_ID);
                final UserModel user = keycloakSession.users().getUserById(realmModel, USER_ID);
                if (user != null) {
                    if (!user.isEmailVerified()) {
                        keycloakSession.users().removeUser(realmModel, user);
                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        log.info("Delete user " + user.getUsername() + "(" + EMAIL + ") at " + formatter.format(new Date()));
                    }
                } else {
                    log.info("User with email " + EMAIL + " is already deleted.");
                }
            }, INTERVAL, TASK_ID);
        } catch (Exception e) {
            log.error("Exception occurred!", e);
        }
    }
}
