# Getting started with {{ at-name }}

{{ at-name }} collects [audit logs](./concepts/format.md) from {{ yandex-cloud }} resources and uploads them to an {{ objstorage-name }} bucket, a {{ cloud-logging-name }} log group, or a {{ yds-name }} data stream.

Within {{ at-name }}, audit logs are managed by [trails](./concepts/trail.md).

Follow these instructions to create a new trail that will upload audit logs of your organization resources to an {{ objstorage-name }} bucket.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and sign in to {{ yandex-cloud }} or create an account if you do not have one yet.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. Make sure your cloud has a bucket where you can store audit logs. [Create a new bucket](../storage/quickstart.md#the-first-bucket) with restricted access, if required.
1. [Create](../iam/operations/sa/create.md) a service account and assign the following roles to it:

   {% list tabs %}

   - CLI

      {% include [cli-install](../_includes/cli-install.md) %}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      * Assign the [`storage.uploader`](../storage/security/index.md#storage-uploader) role for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role storage.uploader \
           --id <folder_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:

         * `role`: Role being assigned
         * `id`: ID of the folder to host the trail
         * `service-account-id`: ID of your service account

      * Assign the role [`audit-trails.viewer`](./security/index.md#roles-list) for the organization whose audit logs will be collected:

         ```
         yc organization-manager organization add-access-binding \
           --role audit-trails.viewer \
           --id <organization_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:

         * `role`: Role being assigned
         * `id`: ID of the cloud from which audit logs will be collected
         * `service-account-id`: ID of your service account

   {% endlist %}

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.

## Creating a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the process of configuration-level audit log management:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
   1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail.
   1. In the **{{ ui-key.yacloud.common.description }}** field, enter the trail description (optional).
   1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, set up the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Select the bucket to upload audit logs to.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](./concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../_includes/audit-trails/note-bucket-prefix.md) %}

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the bucket.
   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up collecting configuration-level audit logs:

      * **Status**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: An automatically populated field containing the name of the current organization.

   1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Viewing audit logs {#watch-logs}

When uploading audit logs to a bucket, {{ at-name }} generates audit log files approximately once every 5 minutes. The trail will write all the [events](./concepts/events.md) that occurred to the organization resources during that period to one or more files. If no events occurred during the period, no files are generated.

Make sure that the audit log file is in the bucket that was specified when creating the trail.

### Viewing audit log files {#watch-log-file}

{{ at-name }} creates log files in `JSON` format.

Access to the contents of the audit log file using one of the following methods:
* [Download the object](../storage/operations/objects/download.md).
* [Get a public link to the object](../storage/operations/objects/link-for-download.md).
* Mount the bucket using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace): [s3fs](../storage/tools/s3fs.md) or [goofys](../storage/tools/goofys.md).

## Exporting audit logs to SIEM systems {#watch-log-file}

You can [export](./concepts/export-siem.md) audit log files to your SIEM solution.

## What's next {#whats-next}

* Learn more about the [service](./concepts/index.md).
* Learn more about the [types of audit logs](./concepts/control-plane-vs-data-plane.md).
