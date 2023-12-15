# Uploading cloud audit logs to {{ yds-name }}

Follow this guide to create a new [trail](../concepts/trail.md) that will upload management event (Control Plane) audit logs of all resources and, optionally, data event (Data Plane) audit logs of selected services of an individual cloud to a {{ yds-name }} stream.


## Prepare the environment {#before-you-begin}

To export audit logs of a cloud:

1. [Create](../../data-streams/operations/manage-streams.md#create-data-stream) a data stream to upload audit logs.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. Assign roles to the service account:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles-list) for the cloud whose audit logs will be collected.

         ```
         yc resource-manager cloud add-access-binding \
           --role audit-trails.viewer \
           --id <cloud_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:
         * `--role`: Role being assigned.
         * `--id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) whose audit logs will be collected.
         * `--service-account-id`: Service account ID.

      * [`yds.writer`](../../logging/security/index.md#roles-list) for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role yds.writer \
           --id <folder_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:
         * `--role`: Role being assigned.
         * `--id`: ID of the folder to host the trail.
         * `--service-account-id`: Service account ID.

   {% endlist %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `yds.viewer` for the {{ yds-name }} data stream.


## Create a trail {#the-trail-creation}

To create a trail that exports audit logs from the cloud:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
   1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

      * **{{ ui-key.yacloud.common.name }}**: Name of the trail being created
      * **{{ ui-key.yacloud.common.description }}**: Description of the trail (optional)

   1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, set up the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}**: Select the data stream. You can also create a new data stream by clicking **{{ ui-key.yacloud.common.create-new }}** and [specifying](../../data-streams/operations/manage-streams.md#create-data-stream) the data stream settings.

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the data stream.

   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Automatically populated field showing the name of the cloud to host the trail.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.

   1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

The trail will be created and will begin uploading audit logs to the data stream.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
