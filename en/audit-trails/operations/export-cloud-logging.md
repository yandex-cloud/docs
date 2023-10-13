# Uploading cloud audit logs to {{ cloud-logging-name }}

Follow this guide to create a new [trail](../concepts/trail.md) that will upload configuration-level (Control Plane) audit logs of all resources and, optionally, service-level (Data Plane) audit logs of selected services of an individual cloud to a {{ cloud-logging-name }} log group.


## Prepare the environment {#before-you-begin}

To export audit logs of a cloud:

1. [Create](../../logging/operations/create-group.md) a log group to upload audit logs to.
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

         * `role`: Role being assigned
         * `id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) whose audit logs will be collected.
         * `service-account-id`: ID of your service account

      * [`logging.writer`](../../logging/security/index.md#roles-list) for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role logging.writer \
           --id <folder_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:

         * `role`: Role being assigned
         * `id`: ID of the folder to host the trail
         * `service-account-id`: ID of your service account

   {% endlist %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `logging.viewer` for a log group in {{ cloud-logging-name }}.


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

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`
      * **{{ ui-key.yacloud.logging.label_loggroup }}**: Select a log group. You can also create a new log group. For this:

         * Click **{{ ui-key.yacloud.common.label_create-new_female }}**, then specify the parameters of the log group:

            * **{{ ui-key.yacloud.common.name }}**: Name of the group being created
            * **{{ ui-key.yacloud.common.description }}**: Optional description of the log group
            * **{{ ui-key.yacloud.logging.label_retention-period }}**.

         * Click **{{ ui-key.yacloud.logging.button_create-group }}**.

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the log group.

   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up the collection of configuration-level audit logs:

      * **Status**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Automatically populated field showing the name of the cloud to host the trail.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.

   1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

The trail will be created and will start uploading audit logs to the log group.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
