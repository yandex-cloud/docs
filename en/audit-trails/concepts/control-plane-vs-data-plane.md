# Comparing configuration-level and service-level event logs

{{ at-name }} audit logs may contain two types of events: configuration-level (Control Plane) and service-level (Data Plane).

## Configuration-level events {#control-plane-events}

Configuration-level (Control Plane) events include actions related to {{ yandex-cloud }} resource configuration. {{ at-name }} logs configuration-level events for all supported services in your {{ yandex-cloud }} account by default.

Events related to actions such as creating, updating, or deleting infrastructure components, users, or policies belong to this type of events. Examples of configuration-level events are creating an instance group, creating a federation in {{ org-name }}, or deleting a database cluster.

## Service-level events {#data-plane-events}

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Service-level (Data Plane) events include updates and actions related to data and resources inside {{ yandex-cloud }} services. By default, {{ at-name }} does not log Data Plane events. You need to enable service-level audit log collection individually for each supported service.

Data Plane events can be logged for the following services:

* {{ dns-full-name }}
* {{ lockbox-full-name }}
* {{ kms-full-name }}
* {{ objstorage-full-name }}
