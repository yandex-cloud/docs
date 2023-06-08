# Uploading organization audit logs to {{ objstorage-name }}

Follow these instructions to create a new trail that will upload audit logs of all of an organization's resources to an {{ objstorage-name }} bucket.

{% include [bucket-encryption-tip](../../_includes/audit-trails/bucket-encryption-tip.md) %}


## Prepare the environment {#before-you-begin}

To collect organization audit logs:

1. [Create a new bucket](../../storage/operations/buckets/create.md) to use for uploading audit logs.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. Assign roles to the service account:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles) for the organization whose audit logs will be collected:

         ```
         yc organization-manager organization add-access-binding \
           --role audit-trails.viewer \
           --id <organization_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:
         * `role`: Role being assigned.
         * `id`: ID of the organization from whose resources the audit logs will be collected.
         * `service-account-id`: ID of your service account.

      * [`storage.uploader`](../../storage/security/index.md#storage-uploader) for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role storage.uploader \
           --id <folder_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:
         * `role`: Role being assigned.
         * `id`: ID of the folder to host the trail.
         * `service-account-id`: ID of your service account.

   {% endlist %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.


{% include [bucket-encryption-section](../../_includes/audit-trails/bucket-encryption-section.md) %}


## Create a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to host the trail.
   1. Select **{{ at-name }}**.
   1. Click **Create trail** and specify:
      * **Name**: The name of the trail being created.
      * **Description**: A description of the trail (optional).
   1. Under **Filter**, set up the audit log scope:
      * **Resource**: Select `Organization`.
      * **Organization**: An automatically populated field containing the name of the current organization.
   1. Under **Destination**, set up the destination object:
      * **Destination**: `{{ objstorage-name }}`.
      * **Bucket**: The name of the [bucket](../../storage/operations/buckets/create.md) where you want to upload audit logs.
      * **Object prefix**: An optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the bucket.
   1. Click **Create**.

{% endlist %}


## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).