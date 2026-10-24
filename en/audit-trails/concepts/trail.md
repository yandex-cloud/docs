---
title: Trail
description: In this tutorial, you will learn about what a trail is, its settings, available event collection areas, and destination objects.
---

# Trail


A trail is an {{ at-name }} resource that collects audit logs of {{ yandex-cloud }} resources and writes them to an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md), {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md), or {{ yds-name }} [data flow](../../data-streams/concepts/glossary.md#stream-concepts).

## Collecting and filtering events {#event-filters}

When [creating](../operations/create-trail.md) or [updating](../operations/manage-trail.md) a trail, you can select which events it should write to the [destination object](#target).

### Collection scope {#collecting-area}

The collection scope determines the source of events for a trail:

* Organization: All clouds or selected clouds within the current organization.
* Cloud: All or selected folders of the current cloud.
* Folder: Current folder.

New resources created in the selected scope are automatically included in event collection. The same collection conditions apply to their events.

### Collecting management events {#control-plane-collection}

[Management events](./control-plane-vs-data-plane.md#control-plane-events) capture operations related to setting up cloud resources, e.g., creating a VM or deleting a database cluster.

For this level, you only need to define the collection scope. Within this scope, the system automatically collects events from all the [supported services](events.md), without filtering for specific services or event names. You can enable or disable collection as a whole.

### Collecting data events {#data-plane-collection}

For [data events](./control-plane-vs-data-plane.md#data-plane-events), you can select services, and for each service, define the collection scope and conditions. You can disable collection globally or for individual services.

There are three event collection types:

* **{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_all }}**: Collect all current and future events.
* **{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_include }}** (`included_events`): Only collect events with the specified names. New names are not added to the list automatically.
* **{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_exclude }}** (`excluded_events`): Collect all events except those specified. New events will be collected automatically.

In a single filter, you can only specify event names in one of the sections: `included_events` or `excluded_events`. If both of the sections are empty, all data events will be collected based on the other filtering conditions.

You can find the event names in the [data event reference](events-data-plane.md). In the CLI, {{ TF }}, or API, use a full name from the `event_type` field of the audit log, e.g., `yandex.cloud.audit.iam.CreateIamToken`.

#### Field value conditions {#field-filters}

When using the CLI, {{ TF }} , and API, you can add field value conditions to the data event filter, e.g., to exclude events of a specific user. These conditions apply together with the selected collection scope and event names.

{% include [field-filter-rules](../../_includes/audit-trails/field-filter-rules.md) %}

For filter examples, see [{#T}](../operations/create-trail.md#filter-examples).

## Pre-installed events {#default}

When creating a trail in the [management console]({{ link-console-main }}), some [data events](./events-data-plane.md) are collected by default. This is done for security in line with the cloud infrastructure protection [standard](../../security/standard/audit-logs.md#audit-trails). If a service is not used, you can disable the events. Delivered events are billed as per the [pricing policy](../pricing.md).

Services for which the sending of events is on by default:

#|
|| **Service** | **Events** ||
|| [{{ certificate-manager-full-name }}](../../certificate-manager/at-ref.md#data-plane-events) | All events ||
|| [{{ iam-full-name }}](../../iam/at-ref.md#data-plane-events) | All events ||
|| [{{ kms-full-name }}](../../kms/at-ref.md#data-plane-events) | All events ||
|| [{{ lockbox-full-name }}](../../lockbox/at-ref.md#data-plane-events) | All events ||
|| [{{ mmy-full-name }}](../../managed-mysql/at-ref.md#data-plane-events) |
* `yandex.cloud.audit.mdb.mysql.CreateDatabase`
* `yandex.cloud.audit.mdb.mysql.CreateUser`
* `yandex.cloud.audit.mdb.mysql.DeleteDatabase`
* `yandex.cloud.audit.mdb.mysql.DeleteUser`
* `yandex.cloud.audit.mdb.mysql.GrantUserPermission`
* `yandex.cloud.audit.mdb.mysql.RevokeUserPermission`
* `yandex.cloud.audit.mdb.mysql.UpdateUser`
||
|| [{{ mpg-full-name }}](../../managed-postgresql/at-ref.md#data-plane-events) |
* `yandex.cloud.audit.mdb.postgresql.CreateDatabase`
* `yandex.cloud.audit.mdb.postgresql.CreateUser`
* `yandex.cloud.audit.mdb.postgresql.DeleteDatabase`
* `yandex.cloud.audit.mdb.postgresql.DeleteUser`
* `yandex.cloud.audit.mdb.postgresql.GrantUserPermission`
* `yandex.cloud.audit.mdb.postgresql.RevokeUserPermission`
* `yandex.cloud.audit.mdb.postgresql.UpdateDatabase`
* `yandex.cloud.audit.mdb.postgresql.UpdateUser`
||
|#

## Destination object {#target}

Each trail uploads audit logs only to a single destination object: a bucket, a log group, or a data stream.

#|
|| **Destination** | **Use for** | **Delay** | **Format** ||
|| Bucket {{ ui-key.yacloud.audit-trails.label_objectStorage }} | Long-term storage and compliance | 5 min | JSON array ||
|| {{ ui-key.yacloud.audit-trails.label_cloudLogging }} log group | Real-time monitoring | Seconds | {{ cloud-logging-name }} log stream: one {{ cloud-logging-name }} log entry corresponds to one {{ at-name }} event ||
|| {{ ui-key.yacloud.audit-trails.label_dataStream }} data stream | Integration with SIEM, analytics | Seconds | JSON object stream ||
|#

Each destination object has its advantages:

* **{{ ui-key.yacloud.audit-trails.label_objectStorage }}**: Provides long-term storage of large amounts of data for further processing.
* **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**: Helps respond to events and analyze logs in real time.
* **{{ ui-key.yacloud.audit-trails.label_dataStream }}**: Enables streaming data to other services and systems.

When uploading audit logs to a bucket, {{ at-name }} generates files about once every 5 minutes. Filtered events from the selected collection scope will be saved into one or multiple files. If there are no matching events during this period, files will not be generated.

{{ at-name }} uploads audit logs to log groups and data stream in near real time.

The type of destination object determines the structure and content of the message used by {{ at-name }} to transmit audit logs:

* If the destination object is a bucket, the message is a file containing a [JSON object](./format.md#scheme) array of the audit log.
* If the destination object is a log group, the message includes a single JSON object of the audit log.
* If the destination object is a data stream, the messages containing JSON objects of the audit log are sent to the stream.

{% include [note-lose-target-when-switch-trail](../../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

Each trail runs independently of one another. Using multiple trails, you can differentiate access to various log groups for users and services according to your information security policy.

## Trail settings {#trail-settings}

In the management console, the following trail settings are available:

* **{{ ui-key.yacloud.common.name }}**: Required parameter.
* **{{ ui-key.yacloud.common.description }}**: Optional parameter.
* **{{ ui-key.yacloud.audit-trails.label_destination }}** section:
    * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`, `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`, or `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
    * For the `{{ ui-key.yacloud.audit-trails.label_objectStorage }}` value:
        * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Bucket.
        * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](./format.md#log-file-name) of the audit log file.
        * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: {{ kms-full-name }} symmetric [encryption key](../../kms/concepts/key.md) for the bucket.
    * For the `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}` value:
        * **{{ ui-key.yacloud.logging.label_loggroup }}**: Log group.
    * For the `{{ ui-key.yacloud.audit-trails.label_dataStream }}` value:
        * **{{ ui-key.yacloud.audit-trails.label_stream-name }}**: Data stream.
        * **Codec**: Event compression method when writing to {{ yds-name }}.

            {% include [yds-compressing-events](../../_includes/audit-trails/yds-compressing-events.md) %}
* **{{ ui-key.yacloud.audit-trails.label_service-account }}** section: Service account to use for uploading audit logs to a bucket, a log group, or a data stream. If the account needs more roles, a warning with a list of roles will show up.
* **{{ ui-key.yacloud.audit-trails.label_control-plane-collection-new }}** section:
    * **Status**: Toggles the collection of management event audit logs.
    * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
    * For the `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` value:
        * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Name of the current organization. The value is populated automatically.
    * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` value:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Name of the cloud hosting the current trail. The value is populated automatically.
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Folders for whose resources the trail will collect management event audit logs. If you do not specify any folder, the trail will collect audit logs from all resources in the cloud.
    * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}` parameter:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Name of the folder hosting the trail. The value is populated automatically.
* **{{ ui-key.yacloud.audit-trails.label_data-plane-collection-new }}** section:
    * **Status**: Toggles the collection of data event audit logs.
    * List of [services](events-data-plane.md), each configured individually for:
        * Data event audit log collection [scope](trail.md#collecting-area).
        * Event filter type:
            * `Receive all`: To receive all events within the service.
            * `Selected`: To only receive the selected events.
            * `Exclude`: To receive all events except for the selected ones.
        * List of [events](events-data-plane.md) is `Selected` or `Exclude` filter type is selected.


## Use cases {#examples}

* [{#T}](../tutorials/search-events-audit-logs/index.md)
* [{#T}](../tutorials/alerts-monitoring.md)
* [{#T}](../tutorials/logging-functions.md)
* [{#T}](../tutorials/audit-trails.md)
* [{#T}](../tutorials/maxpatrol/index.md)
* [{#T}](../tutorials/export-logs-to-splunk.md)
* [{#T}](../tutorials/export-logs-to-arcsight.md)
* [{#T}](../tutorials/audit-trails-events-to-kuma/console.md)


## What's next {#whats-next}

* Learn more about the [audit log format](./format.md).
* See [trail diagnostic logs](./diagnostics.md).
* Learn about [events](./events.md).
