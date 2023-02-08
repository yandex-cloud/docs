# Trail

A trail is to {{ at-name }} resource responsible for collecting and delivering audit logs of {{ yandex-cloud }} resources to an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md), a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md), or a {{ yds-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts).

## Audit log collection scope {#collecting-area}

In the trail settings, you can choose where to collect audit logs from:
* Organization: Collect audit logs from all resources in all clouds of the organization.
* Cloud: Collect audit logs from the resources hosted in the selected folders of the cloud.
* Folder: Collect audit logs from the folder hosting the trail.

A trail will collect the audit logs of all the [resources](./events.md) found in a specified area, including resources added to this area after the trail was created, and upload them to a bucket, a log group, or a data stream.

If resources are added to the audit log collection scope after a trail is created, the trail will automatically start collecting audit logs for them.

## Destination object {#target}

Each trail only loads audit logs to a single destination object, such as a bucket, a log group, or a data stream.

When uploading audit logs to a bucket, {{ at-name }} generates audit log files approximately once every 5 minutes. The trail will write all the [events](./events.md) that occurred to the cloud resources during that period to one or more files. If no events occurred during the period, no files are generated.

{{ at-name }} loads audit logs to log groups in near real time.

The type of destination object determines the structure and content of the message used by {{ at-name }} to transmit audit logs:
* If the destination object is a bucket, the message is a file containing a [JSON object](./format.md#scheme) array of the audit log.
* If the destination object is a log group, the message includes only one JSON object of the audit log.

Each trail runs independently of one another. Using multiple trails, you can differentiate access to various log groups for users and services according to your information security policy.

## Trail settings {#trail-settings}

The trail contains all the audit log settings:
* **Name**: Required parameter.
* **Description**: Optional parameter.
* **Filter** section:
   * **Resource**: This field can take on the values `Organization`, `Cloud`, or `Folder`.
   * For the `Organization` value:
      * **Organization**: The name of the current organization. The value is populated automatically.
   * For the `Cloud` value:
      * **Cloud**: The name of the cloud hosting the current trail. The value is populated automatically.
      * **Folders** are the folders for whose resources the trail will collect audit logs. If you don't specify any folder, the trail will collect audit logs from all resources in the cloud.
   * For the `Folder` parameter:
      * **Folder** is the name of the folder hosting the trail. The value is populated automatically.
* **Destination** section:
   * **Destination**: Values of `{{ objstorage-name }}`, `{{ cloud-logging-name }}`, or `{{ yds-name }}`.
   * For the `{{ objstorage-name }}` value:
      * **Bucket**: The name of the bucket.
      * **Object prefix**: An optional parameter used in the [full name](./format.md#log-file-name) of the audit log file.
   * For the `{{ cloud-logging-name }}` value:
      * **Log group**: Log group name.
   * For the `{{ yds-name }}` value:
      * **Data stream**: Data stream name.
* **Service account** section: Service account to use to upload audit logs to a bucket , a log group, or a data stream. If the account needs more roles, a warning with a list of the roles will show up.

## Trail status {#status}

A trail can have two statuses: `active` or `error`.

Statuses indicate the state of the trail itself and have nothing to do with events occurring to resources for which the trail collects audit logs:
* `active`: The trail is running and collecting audit logs from the resources in scope.
* `error`: There might be issues with the trail's destination objects or the trail itself.

## What's next {#whats-next}

* Learn more about the [audit log format](./format.md).
* Learn about [events](./events.md).
