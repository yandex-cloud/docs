# Uploading folder audit logs to {{ objstorage-name }}

Follow this guide to create a new [trail](../concepts/trail.md) that will upload configuration-level (Control Plane) audit logs of all resources and, optionally, service-level (Data Plane) audit logs of selected services of an individual folder to an {{ objstorage-name }} bucket.

{% include [bucket-encryption-tip](../../_includes/audit-trails/bucket-encryption-tip.md) %}


## Prepare the environment {#before-you-begin}

To collect folder audit logs:

1. [Create a new bucket](../../storage/operations/buckets/create.md) with restricted access to upload audit logs to.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. Assign roles to the service account:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * Assign the [`audit-trails.viewer`](../security/index.md#roles-list) role for the folder whose resources audit logs will be collected from:

         ```
         yc resource-manager folder add-access-binding \
           --role audit-trails.viewer \
           --id <folder_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:
         * `role`: Role being assigned.
         * `id`: ID of the folder from which audit logs will be collected.
         * `service-account-id`: ID of your service account.

      * Assign the [`storage.uploader`](../../storage/security/index.md#storage-uploader) role for the folder to host the trail:

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
   * `audit-trails.viewer` for the folder from which audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.


{% include [bucket-encryption-section](../../_includes/audit-trails/bucket-encryption-section.md) %}


## Create a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

      * **{{ ui-key.yacloud.common.name }}**: Name of the trail being created
      * **{{ ui-key.yacloud.common.description }}**: Description of the trail (optional)

  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, set up the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Name of the [bucket](../../storage/operations/buckets/create.md) to which you want to upload audit logs.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: If the bucket you selected is [encrypted](../../storage/concepts/encryption.md), specify the encryption key.

  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the bucket.

  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Automatically populated field containing the name of the current folder.

  1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
