# Comparing management and data event logs

{{ at-name }} audit logs may contain two types of events: management (control plane) and data (data plane).

## Management events {#control-plane-events}

Management (control plane) events include actions related to {{ yandex-cloud }} resource configuration. {{ at-name }} logs management events for all supported services in your {{ yandex-cloud }} account by default.

Events related to actions such as creating, updating, or deleting infrastructure components, users, or policies belong to this type of events. For instance, creating an instance group, creating a federation in {{ org-name }}, or deleting a database cluster are all management events.

## Data events {#data-plane-events}

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Data (data plane) events include updates and actions related to data and resources inside {{ yandex-cloud }} services. By default, {{ at-name }} does not log data plane events. You need to enable data event audit log collection individually for each supported service.

Data plane events can be logged for the following services:

* {{ dns-full-name }}
* {{ lockbox-full-name }}
* {{ kms-full-name }}
* {{ objstorage-full-name }}
