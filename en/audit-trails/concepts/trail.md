# Trail

A trail is an {{ at-name }} resource responsible for collecting and delivering audit logs of {{ yandex-cloud }} resources to a [bucket](../../storage/concepts/bucket.md) in {{ objstorage-name }} or a [log group](../../logging/concepts/log-group.md) in {{ cloud-logging-name }}.

## Audit log collection scope {#collecting-area}

In the trail settings, you can choose where to collect audit logs from:
* Organization: Audit logs of all resources in all clouds of the organization.
* Cloud: Audit logs of resources in all folders in a given cloud.
* Individual folders: Audit logs of specific folders in a cloud.

The trail will collect the audit logs of all [resources](./events.md) in the specified audit log collection scope, including the resources added to the scope after trail creation, and upload them to a bucket or log group.

If resources are added to the audit log collection scope after a trail is created, the trail will automatically start collecting audit logs for them.

## Destination object {#target}

Each trail only uploads audit logs to one destination object: a bucket or a log group.

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
* **Service account**: The account on behalf of which audit logs will be uploaded to a bucket or a log group. To determine the available audit log collection scope, the access rights of this account are checked.
* **Destination**:
   * **Destination**: {{ objstorage-name }} or {{ cloud-logging-name }}.
   * For {{ objstorage-name }}:
      * **Bucket**: The name of the bucket.
      * **Object prefix**: An optional parameter used in the [full name](./format.md#log-file-name) of the audit log file.
   * For {{ cloud-logging-name }}:
      * **Group**: The name of the log group.
* **Filter**:
   * **Resource**: `Cloud` or `Organization`.
   * For `Cloud`:
      * **Cloud**: The name of the cloud hosting the current trail, must be selected manually.
      * **Folders**: The folders whose resources the trail is going to collect audit logs for. If no folder is specified, the trail collects audit logs for every resource in the cloud.
   * For `Organization`:
      * **Organization**: The name of the organization.

## Trail status {#status}

A trail can have two statuses: `active` or `error`.

Statuses indicate the state of the trail itself and have nothing to do with events occurring to resources for which the trail collects audit logs:
* `active`: The trail is running and collecting audit logs from the resources in scope.
* `error`: There might be issues with the trail's destination objects or the trail itself.

## What's next {#whats-next}

* Learn more about the [audit log format](./format.md).
* Learn about [events](./events.md).
