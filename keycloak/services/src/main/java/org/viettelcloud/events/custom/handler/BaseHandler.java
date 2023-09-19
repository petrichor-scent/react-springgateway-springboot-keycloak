package org.viettelcloud.events.custom.handler;

import org.jboss.logging.Logger;
import org.keycloak.events.Event;
import org.keycloak.models.KeycloakSession;


public class BaseHandler implements IEventHandler {
    protected final Logger log = Logger.getLogger(IEventHandler.class);
    protected final Event event;
    protected final KeycloakSession session;

    public BaseHandler(Event event, KeycloakSession session) {
        this.event = event;
        this.session = session;
    }

    @Override
    public void handle() { }
}
