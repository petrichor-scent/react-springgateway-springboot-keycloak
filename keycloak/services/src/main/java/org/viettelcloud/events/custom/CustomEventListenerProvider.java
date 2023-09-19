package org.viettelcloud.events.custom;

import org.jboss.logging.Logger;
import org.viettelcloud.events.custom.handler.BaseHandler;
import org.viettelcloud.events.custom.handler.IEventHandler;
import org.viettelcloud.events.custom.handler.RegisterHandler;
import org.viettelcloud.events.custom.handler.UserLockedHandler;
import org.keycloak.events.Event;
import org.keycloak.events.EventType;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.KeycloakSession;


public class CustomEventListenerProvider implements EventListenerProvider {

    private static final Logger log = Logger.getLogger(CustomEventListenerProvider.class);
    private final KeycloakSession session;

    public CustomEventListenerProvider(KeycloakSession session) {
        this.session = session;
    }

    @Override
    public void onEvent(Event event) {
        final String EVENT_TYPE = event.getType().toString();
        IEventHandler eventHandler = new BaseHandler(event, session);

        if ("REGISTER".equals(EVENT_TYPE)) {
            eventHandler = new RegisterHandler(event, session);
        }

        if(event.getType() == EventType.LOGIN_ERROR && ("user_disabled".equals(event.getError()) || "user_temporarily_disabled".equals(event.getError()))) {
            eventHandler = new UserLockedHandler(event, session);
        }

        eventHandler.handle();
    }

    @Override
    public void onEvent(AdminEvent adminEvent, boolean includeRepresentation) { }

    @Override
    public void close() { }
}