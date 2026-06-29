# Getting started with {{ at-name }}

{{ at-name }} collects [audit logs](./concepts/format.md) of {{ yandex-cloud }} resources to monitor actions with resources and access events. You can upload logs to a {{ objstorage-full-name }} [bucket](../storage/concepts/bucket.md), {{ cloud-logging-full-name }} [log group](../logging/concepts/log-group.md), or {{ yds-full-name }} [data stream](../data-streams/concepts/glossary.md#stream-concepts).

Audit logs are collected and delivered to {{ at-name }} using [trails](./concepts/trail.md). You need a separate trail for each storage type.

Follow this guide to create a trail to upload the audit logs of your organization’s resources. Select the destination object, depending on your goal:
* {{ objstorage-name }} [bucket](../storage/concepts/bucket.md) for long-term storage of audit logs and their future analysis.
* {{ cloud-logging-name }} [log group](../logging/concepts/log-group.md) to quickly view and search logs in real time. A good option for your first introduction to the service.

## Getting started {#before-you-begin}

This guide assumes that you already have {{ yandex-cloud }} resources, so first make sure that:

* You have a [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud).
* Your cloud has a linked [billing account](../billing/concepts/billing-account.md) with the `ACTIVE` or `TRIAL_ACTIVE` status.

To create a trail, you will need the following roles:

* `iam.serviceAccounts.user` for the service account to collect audit logs. You can create this service account when creating the trail.
* `audit-trails.editor` for the folder to host the trail.
* `audit-trails.viewer` for the organization whose audit logs will be collected.
* If using a bucket:
   * `kms.editor` for the folder the bucket encryption key will be created in.
   * `storage.viewer` for the bucket or folder.
* If using a log group: `logging.viewer` for the log group or folder.

{% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

## Creating a trail {#the-trail-creation}

{% list tabs group=audit-trails-destination %}

- Bucket {#bucket}

  1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Select the bucket to upload audit logs to. If you do not have a bucket yet, click **{{ ui-key.yacloud.common.create }}** and [create a new bucket](../storage/quickstart.md#the-first-bucket) with restricted access.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](./concepts/format.md#log-file-name) of the audit log file.
      
      {% include [note-bucket-prefix](../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: If the bucket you selected is [encrypted](../storage/concepts/encryption.md), specify the encryption key.
      
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select an existing [service account](../iam/concepts/users/service-accounts.md) or create a new one. The trail will use this account to upload audit log files to the bucket.
      If you are creating a new account, click **{{ ui-key.yacloud.common.create }}**, name the account, and and assign the following roles to it:
      * `storage.uploader` for the bucket.
      * `audit-trails.viewer` for the folder if planning to collect events from the folder.
      * `kms.keys.encrypter` for the encryption key if the bucket is encrypted.

  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up the following:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Event collection level: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * Depending on the event collection level you select:
          * Assign relevant roles to the service account. For example, if you select the **Folder** level, it will need the `audit-trails.viewer` role for this folder.
          * Specify an organization, cloud, or folder to collect audit logs from.

  1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- Log group {#log-group}

  1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
  1. [Navigate](../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`.
      * **{{ ui-key.yacloud.audit-trails.label_log-group }}**: Select a log group to upload audit logs to. If you do not have a log group yet, click **{{ ui-key.yacloud.common.create }}** and [create a new log group](../logging/quickstart.md).

  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select an existing [service account](../iam/concepts/users/service-accounts.md) or create a new one. The trail will use this account to upload audit log files to the log group.
      If you are creating a new account, click **{{ ui-key.yacloud.common.create }}**, name the account, and and assign the following roles to it:
      * `logging.writer` for the log group.
      * `audit-trails.viewer` for the folder if planning to collect events from the folder.

  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select the event collection level: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`, or `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * Depending on the event collection level you select:
          * Assign relevant roles to the service account. For example, if you select the **Folder** level, it will need the `audit-trails.viewer` role for this folder.
          * Specify an organization, cloud, or folder to collect audit logs from.

  1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

You can also create a trail using the [CLI](./operations/create-trail.md#cli), [Terraform](./operations/create-trail.md#tf), or [API](./operations/create-trail.md#api).

{% include [note-lose-target-when-switch-trail](../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

## Viewing audit logs {#watch-logs}

{% list tabs group=audit-trails-destination %}

- Bucket {#bucket}

  {{ at-name }} generates audit log files approximately once every 5 minutes. {{ at-name }} creates log files in `JSON` format.
  
  Access to the contents of the audit log file using one of the following methods:
  * [Download the object](../storage/operations/objects/download.md).
  * [Get a public link to the object](../storage/operations/objects/link-for-download.md).
  * Mount the bucket using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace): [s3fs](../storage/tools/s3fs.md) or [goofys](../storage/tools/goofys.md).

- Log group {#log-group}

  In the {{ cloud-logging-name }} UI, you can view audit logs in real time.
  
  1. In the [management console]({{ link-console-main }}), select the folder with the log group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Click the row with the log group.
  1. Navigate to the **{{ ui-key.yacloud.common.logs }}** tab.
  1. Configure event search filters.

{% endlist %}

## Exporting audit logs to SIEM {#export-to-siem}

You can [export](./concepts/export-siem.md) audit log files to your SIEM solution.

## What's next {#whats-next}

* Learn more about the [service](./concepts/index.md).
* Learn more about the [types of audit logs](./concepts/control-plane-vs-data-plane.md).
* Read about [audit log requirements in the security standard](../security/standard/audit-logs.md).
