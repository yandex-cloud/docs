# Comparing management and data event logs

{{ at-name }} audit logs may contain two types of events: management events and data events. You can specify the types of events to collect, [destination object](./trail.md#target), [audit log collection scopes](./trail.md#collecting-area), and [other settings](./trail.md#trail-settings) when [creating](../operations/create-trail.md) or [modifying](../operations/manage-trail.md#update-trail) a trail.

## Management events {#control-plane-events}

Management events include actions performed to configure {{ yandex-cloud }} resources. By default, {{ at-name }} logs management events for all supported services in your {{ yandex-cloud }} account.

Events related to actions such as creating, updating, or deleting infrastructure components, users, or policies belong to this type of events. For instance, creating an instance group, creating a federation in {{ org-name }}, or deleting a database cluster are all management events.

Management events are logged if the [trail](./trail.md) settings enable the collection of management events and an audit log collection scope is specified.

## Data events {#data-plane-events}

Data events include updates and actions related to data and resources within {{ yandex-cloud }} services. By default, {{ at-name }} does not log data events. You need to enable collection of data event audit logs and customize the collection scope in the trail settings individually for each supported service.

Data events can be logged for the following services:

{% include [dp-events-service-list](../../_includes/audit-trails/dp-events-service-list.md) %}
