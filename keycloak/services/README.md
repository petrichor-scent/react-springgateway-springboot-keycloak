## Keycloak provider implementations

### Introduction

This directory contains serveral customized version of some service providers to be suitable for the Viettel Cloud environment.

There are various types of providers that could be extended to allow more flexible implementations of Keycloak features. The list of all possible providers can be found at: https://sso.vcloud.viettel.vn/admin/master/console/#/server-info/providers.

### List of custom providers

1. `custom-event-listener`: An event listener that listens all published events and calls the appropriate handlers. Those handlers are:
    - `RegisterHandler`: Spawn a task to delete spam users (users that are not verified 5 minutes after creation)
    - `UserLockedHandler`: Check if user is locked on login and send an email to them to notify that their account is locked due to too many unsuccessful login attempts.

2. `locale-selector`: A custom locale selector that bypass browser language when determine user locale so that admin can configure default locale for guest users on browsers.

### How to implement a custom provider

First, let's take a look at this directory's structure

```
.
├── pom.xml
├── pom.xml.j2
├── README.md
├── src
│   └── main
│       ├── java
│       │   └── org
│       │       └── viettelcloud
│       │           ├── events
│       │           └── locale
│       └── resources
│           └── META-INF
│               └── services
└── target
    ├── ... 
    └── viettelcloud-services-0.1.0-SNAPSHOT.jar
```

This directory has an identical structure to the `services` directory of the [Keycloak repository](https://github.com/keycloak/keycloak.git).

The most important files and directories are:

- `pom.xml` (generated from `pom.xml.j2`): Contains version and dependencies of our services
- `src/main/java/org/viettelcloud/`:
  - Contains our custom provider code
  - The custom providers are implemnted within the corresponding directory of the Keycloak repos. For example the `events` directory contains our custom event listener providers.
  - Note that the package names in these directories should start with `org.viettelcloud.<directory_name>`
- `resources/META-INF/services`:
  - Registers our custom providers to the global registry
  - To do that, we need to write a file with the name of the factory interface that contains a single line describing the path to our custom factory class.
    
    For example, to register our `CustomEventListenerProviderFactory` class, we create a file named `org.keycloak.events.EventListenerProviderFactory` that has one line: `org.viettelcloud.events.CustomEventListenerProviderFactory`
- `target`: Contains the built artifacts, those artifacts need to be mounted into the `/opt/keycloak/providers` directory in the container to be recognized by the `/opt/keycloak/bin/kc.sh` script