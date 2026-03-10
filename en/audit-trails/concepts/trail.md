---
title: Trail
description: In this tutorial, you will learn about what a trail is, its settings, available event collection areas, and destination objects.
---

# Trail


A trail is an {{ at-name }} resource that collects the audit logs of {{ yandex-cloud }} resources and writes them to an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md), {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md), {{ yds-name }} [data flow](../../data-streams/concepts/glossary.md#stream-concepts), or {{ er-full-name }} [bus](../../serverless-integrations/concepts/eventrouter/bus.md).

## Audit log collection scope {#collecting-area}

In the trail settings, you can choose where to collect audit logs from:
* Organization: Audit logs of resources of the services in selected clouds of the organization.
* Cloud: Audit logs of resources of the services residing in selected folders of the cloud.
* Folder: Audit logs of the folder.

The trail will collect logs of all the [resources](./events.md) within the specified scope, including those added to the scope after the trail was created.

For resources added to the audit log collection scope after the trail was created, collecting audit logs will start automatically.

For [management events](./control-plane-vs-data-plane.md#control-plane-events), the collection scope includes all supported [{{ yandex-cloud }} services](../../overview/concepts/services.md#list).

For [data events](./control-plane-vs-data-plane.md#data-plane-events), the collection scope is configured on a per-service basis.

You can disable collecting all management or data events for any single service or multiple services whenever you need to.

## Destination object {#target}

Each trail uploads audit logs only to a single destination object: bucket, log group, data stream, or bus.

#|
|| **Destination** | **Use for** | **Delay** | **Format** ||
|| {{ ui-key.yacloud.audit-trails.label_objectStorage }} bucket | Long-term storage and compliance | 5 min | JSON array ||
|| {{ ui-key.yacloud.audit-trails.label_cloudLogging }} log group | Real-time monitoring | Seconds | {{ cloud-logging-name }} log stream: one {{ cloud-logging-name }} log entry corresponds to one {{ at-name }} event ||
|| {{ ui-key.yacloud.audit-trails.label_dataStream }} data stream | Integration with SIEM, analytics | Seconds | JSON object stream ||
|| {{ ui-key.yacloud.audit-trails.label_eventRouter }} bus | Further processing and sending to different [targets](../../serverless-integrations/concepts/eventrouter/rule.md#target) | Seconds | {{ er-name }} event stream: one {{ er-name }} event corresponds to one {{ at-name }} event ||
|#

Each destination object has its advantages:

* **{{ ui-key.yacloud.audit-trails.label_objectStorage }}**: Provides long-term storage of large amounts of data for further processing.
* **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**: Helps respond to events and analyze logs in real time.
* **{{ ui-key.yacloud.audit-trails.label_dataStream }}**: Enables streaming data to other services and systems.
* **{{ ui-key.yacloud.audit-trails.label_eventRouter }}**: Processes and sends data to different handlers and systems depending on event types and other conditions.

When uploading audit logs to a bucket, {{ at-name }} generates audit log files approximately once every 5 minutes. The trail will write all the [events](./events.md) that occurred to the cloud resources during that period to one or more files. If no events occurred during the period, no files are generated.

{{ at-name }} uploads audit logs to a log group, data stream, and bus in near-real time.

The type of destination object determines the structure and content of the message used by {{ at-name }} to transmit audit logs:
* If the destination object is a bucket, the message is a file containing a [JSON object](./format.md#scheme) array of the audit log.
* If the destination object is a log group, the message includes a single JSON object of the audit log.
* If the destination object is a data stream, the messages containing JSON objects of the audit log are sent to the stream.
* If the destination object is a bus, the message includes a single JSON object of the audit log.

{% include [note-lose-target-when-switch-trail](../../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

Each trail runs independently of one another. Using multiple trails, you can differentiate access to various log groups for users and services according to your information security policy.

## Trail settings {#trail-settings}

The trail contains all the audit log settings:
* **{{ ui-key.yacloud.common.name }}**: Required parameter.
* **{{ ui-key.yacloud.common.description }}**: Optional parameter.
* **{{ ui-key.yacloud.audit-trails.label_destination }}** section:
    * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`, `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`, `{{ ui-key.yacloud.audit-trails.label_dataStream }}`, or `{{ ui-key.yacloud.audit-trails.label_eventRouter }}`.
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
    * For the `{{ ui-key.yacloud.audit-trails.label_eventRouter }}` value:
        * **Connector**: {{ er-name }} bus [connector](../../serverless-integrations/concepts/eventrouter/connector.md) with the `{{ at-name }}` source type.
* **{{ ui-key.yacloud.audit-trails.label_service-account }}** section: Service account to use for uploading audit logs to a bucket, a log group, or a data stream. If the account needs more roles, a warning with a list of roles will show up.
* **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** section:
    * **Status**: Toggles the collection of management event audit logs.
    * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
    * For the `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` value:
        * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Name of the current organization. The value is populated automatically.
    * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` value:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Name of the cloud hosting the current trail. The value is populated automatically.
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Folders for whose resources the trail will collect management event audit logs. If you do not specify any folder, the trail will collect audit logs from all resources in the cloud.
    * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}` parameter:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Name of the folder hosting the trail. The value is populated automatically.
* **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** section:
    * **Status**: Toggles the collection of data event audit logs.
    * List of [services](events-data-plane.md#services), each configured individually for:
        * Data event audit log collection [scope](trail.md#collecting-area).
        * Event filter type:
            * `Receive all`: To receive all events within the service.
            * `Selected`: To only receive the selected events.
            * `Exclude`: To receive all events except for the selected ones.
        * List of [events](events-data-plane.md#dns) is `Selected` or `Exclude` filter type is selected.


## Use cases {#examples}

* [{#T}](../tutorials/search-events-audit-logs/index.md)
* [{#T}](../tutorials/alerts-monitoring.md)
* [{#T}](../tutorials/logging-functions.md)
* [{#T}](../tutorials/audit-trails.md)
* [{#T}](../tutorials/maxpatrol.md)
* [{#T}](../tutorials/export-logs-to-splunk.md)
* [{#T}](../tutorials/export-logs-to-arcsight.md)
* [{#T}](../tutorials/audit-trails-events-to-kuma/console.md)


## What's next {#whats-next}

* Learn more about the [audit log format](./format.md).
* See [trail diagnostic logs](./diagnostics.md).
* Learn about [events](./events.md).
