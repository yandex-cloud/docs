# Trail


A trail is an {{ at-name }} resource for collecting and delivering audit logs of {{ yandex-cloud }} resources to an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md), a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md), or a {{ yds-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts).

## Audit log collection scope {#collecting-area}

In the trail settings, you can choose where to collect audit logs from:
* Organization: Audit logs of service resources in selected clouds of the organization hosting the trail.
* Cloud: Audit logs of service resources that are located in selected folders of the cloud hosting the trail.
* Folder: Audit logs from the folder hosting the trail.

The trail will collect audit logs of all the [resources](./events.md) within the specified scope, including resources added to this scope after the trail was created, and upload them to a bucket, a log group, or a data stream.

If resources are added to the audit log collection scope after the trail was created, the trail will automatically start collecting audit logs for them.

## Destination object {#target}

Each trail only loads audit logs to a single destination object, such as a bucket, a log group, or a data stream.

{% include [note-lose-target-when-switch-trail](../../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

When uploading audit logs to a bucket, {{ at-name }} generates audit log files approximately once every 5 minutes. The trail will write all the [events](./events.md) that occurred to the cloud resources during that period to one or more files. If no events occurred during the period, no files are generated.

{{ at-name }} loads audit logs to log groups in near real time.

The type of destination object determines the structure and content of the message used by {{ at-name }} to transmit audit logs:
* If the destination object is a bucket, the message is a file containing a [JSON object](./format.md#scheme) array of the audit log.
* If the destination object is a log group, the message includes a single JSON object of the audit log.
* If the destination object is a data stream, the messages containing JSON objects of the audit log are sent to the stream.

Each trail runs independently of one another. Using multiple trails, you can differentiate access to various log groups for users and services according to your information security policy.

## Trail settings {#trail-settings}

The trail contains all the audit log settings:
* **{{ ui-key.yacloud.common.name }}**: Required parameter
* **{{ ui-key.yacloud.common.description }}**: Optional parameter
* **{{ ui-key.yacloud.audit-trails.label_destination }}** section:
   * **{{ ui-key.yacloud.audit-trails.label_destination }}**: Values of `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`, `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`, or `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
   * For the `{{ ui-key.yacloud.audit-trails.label_objectStorage }}` value:
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Bucket name
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](./format.md#log-file-name) of the audit log file.
   * For the `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}` value:
      * **{{ ui-key.yacloud.logging.label_loggroup }}**: Log group name
   * For the `{{ ui-key.yacloud.audit-trails.label_dataStream }}` value:
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}**: Data stream name
* **{{ ui-key.yacloud.audit-trails.label_service-account }}** section: Service account to use for uploading audit logs to a bucket, a log group, or a data stream. If the account needs more roles, a warning with a list of roles will show up.
* **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** section:
   * **Status**: Toggles the collection of management event audit logs.
   * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}` values.
   * For the `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}` value:
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Name of the current organization. The value is populated automatically.
   * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` value:
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Name of the cloud hosting the current trail. The value is populated automatically.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Folders for whose resources the trail will collect management event audit logs. If you do not specify any folder, the trail will collect audit logs from all resources in the cloud.
   * For the `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}` parameter:
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Name of the folder hosting the trail. The value is populated automatically.
* **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** section:
   * **Status**: Toggles the collection of data event audit logs.
   * List of [services](../../audit-trails/concepts/events-data-plane.md#services) for each of which you need to separately set the data event audit log collection [scope](../../audit-trails/concepts/trail.md#collecting-area) and objects.

## What's next {#whats-next}

* Learn more about the [audit log format](./format.md).
* See [trail diagnostic logs](./diagnostics.md).
* Learn about [events](./events.md).
