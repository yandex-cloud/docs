# Uploading cloud audit logs to {{ cloud-logging-name }}

Follow these instructions to create a new trail that will upload audit logs of a single cloud's resources to a {{ cloud-logging-name }} log group.


## Prepare the environment {#before-you-begin}

To export audit logs of a cloud:

1. [Create](../../logging/operations/create-group.md) a log group to upload audit logs to.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. Assign roles to the service account:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles) for the cloud whose audit logs will be collected.

         ```
         yc resource-manager cloud add-access-binding \
           --role audit-trails.viewer \
           --id <cloud ID> \
           --service-account-id <service account ID>
         ```

         Where:

         * `role`: The role assigned.
         * `id`: The [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) whose audit logs will be collected.
         * `service-account-id`: The ID of your service account.

      * [`logging.writer`](../../logging/security/index.md#roles) for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role logging.writer \
           --id <folder ID> \
           --service-account-id <service account ID>
         ```

         Where:

         * `role`: The role assigned.
         * `id`: The ID of the folder to host the trail:
         * `service-account-id`: The ID of your service account.

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

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to host the trail.
   1. Select **{{ at-name }}**.
   1. Click **Create trail** and specify:
      * **Name**: The name of the trail being created.
      * **Description**: A description of the trail (optional).
   1. Under **Filter**, set up the audit log scope:
      * **Resource**: Select `Cloud`.
      * **Cloud**: An automatically populated field showing the name of the cloud to host the trail.
      * **Folders**: Leave the default `all folders` value.
   1. Under **Destination**, set up the destination object:
      * **Destination**: `{{ cloud-logging-name }}`.
      * **Log group**: Select a log group. You can also create a new log group. For this:
         * Click **Create**, then specify the parameters of the log group:
            * **Name**: The name of the group being created.
            * **Description**: An optional description of the log group.
            * **Log retention**.
         * Click **Create group**.
   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the log group.
   1. Click **Create**.

{% endlist %}

The trail will be created and will start uploading audit logs to the log group.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
