# Comparing management and data event logs

{{ at-name }} audit logs may contain two types of events: management events and data events.

## Management events {#control-plane-events}

Management events include actions related to {{ yandex-cloud }} resource configuration. {{ at-name }} logs management events for all supported services in your {{ yandex-cloud }} account by default.

Events related to actions such as creating, updating, or deleting infrastructure components, users, or policies belong to this type of events. For instance, creating an instance group, creating a federation in {{ org-name }}, or deleting a database cluster are all management events.

## Data events {#data-plane-events}

Data events include updates and actions related to data and resources within {{ yandex-cloud }} services. By default, {{ at-name }} does not log data events. You need to enable data event audit log collection individually for each supported service.

Data events can be logged for the following services:

* [{{ dns-full-name }}](../../dns/)
* [{{ kms-full-name }}](../../kms/)
* [{{ lockbox-full-name }}](../../lockbox/)
* [{{ mmg-full-name }}](../../managed-mongodb/)
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
* [{{ objstorage-full-name }}](../../storage/)
