# Uploading cloud audit logs to {{ objstorage-name }}

Follow this guide to create a new [trail](../concepts/trail.md) that will upload management event audit logs of all resources and, optionally, data event audit logs of selected services of an individual cloud to an {{ objstorage-name }} bucket.

{% include [bucket-encryption-tip](../../_includes/audit-trails/bucket-encryption-tip.md) %}

## Prepare the environment {#before-you-begin}

To collect audit logs of an individual cloud:

1. [Create a new bucket](../../storage/operations/buckets/create.md) with restricted access to upload audit logs to.
1. [Create](../../iam/operations/sa/create.md) a service account.

1. {% include [add-roles-to-sa](../../_includes/audit-trails/add-roles-to-sa.md) %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `kms.editor` for the folder where the bucket encryption key will be created.
   * `storage.viewer` for bucket or folder.

{% include [bucket-encryption-section](../../_includes/audit-trails/bucket-encryption-section.md) %}

## Create a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
   1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

      * **{{ ui-key.yacloud.common.name }}**: Name of the trail being created.
      * **{{ ui-key.yacloud.common.description }}**: Description of the trail (optional).

   1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, set up the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Select the bucket to upload audit logs to.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: If the bucket you selected is [encrypted](../../storage/concepts/encryption.md), specify the encryption key.

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the bucket.

   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Automatically populated field showing the name of the cloud to host the trail.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.

   1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

The trail will be created and begin uploading audit logs to the bucket.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
