# Exporting audit logs to {{ yds-name }}

Create a new [trail](../concepts/trail.md) to upload audit logs for the resources of a single cloud or all the organization's resources to a {{ yds-name }} data stream.

## Before you begin {#before-you-begin}

### Organization {#before-you-begin-organization}

To export organization audit logs:

1. [Create](../../data-streams/operations/manage-streams.md#create-data-stream) a data stream to upload audit logs.
1. [Create](../../iam/operations/sa/create.md) a service account and assign the following roles to it:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * `audit-trails.viewer` for the organization whose audit logs will be collected:

         ```
         yc organization-manager organization add-access-binding \
           --role audit-trails.viewer \
           --id <organization ID> \
           --service-account-id <service account ID>
         ```

         Where:
         * `role`: The role assigned.
         * `id`: The ID of the organization from whose resources the audit logs will be collected.
         * `service-account-id`: The ID of your service account.

      * `yds.writer` for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role yds.writer \
           --id <folder ID> \
           --service-account-id <service account ID>
         ```

         Where:
         * `role`: The role assigned.
         * `id`: The ID of the folder to host the trail.
         * `service-account-id`: The ID of your service account.

   {% endlist %}

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `yds.viewer` for the {{ yds-name }} data stream.


### Cloud {#before-you-begin-cloud}

To export audit logs of a cloud:

1. [Create](../../data-streams/operations/manage-streams.md#create-data-stream) a data stream to upload audit logs.
1. [Create](../../iam/operations/sa/create.md) a service account and assign the following roles to it:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles) for the cloud whose audit logs will be collected:

         ```
         yc resource-manager cloud add-access-binding \
           --role audit-trails.viewer \
           --id <cloud ID> \
           --service-account-id <service account ID>
         ```

         Where:
         * `role`: The role assigned.
         * `id`: The ID of the cloud whose audit logs will be collected.
         * `service-account-id`: The ID of your service account.

      * [`yds.writer`](../../logging/security/index.md#roles) for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role yds.writer \
           --id <folder ID> \
           --service-account-id <service account ID>
         ```

         Where:
         * `role`: The role assigned.
         * `id`: The ID of the folder to host the trail:
         * `service-account-id`: The ID of your service account.

   {% endlist %}

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `yds.viewer` for the {{ yds-name }} data stream.

## Creating a trail {#the-trail-creation}

### Organization {#the-trail-creation-organization}

To create a trail that exports organization audit logs:

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
      * **Destination**: `{{ yds-name }}`.
      * **Data stream**: Select a data stream. You can also create a new data stream by clicking **Create new** and [specifying](../../data-streams/operations/manage-streams.md#create-data-stream) the data stream settings.
   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the data stream.
   1. Click **Create**.

{% endlist %}

The trail will be created and will begin uploading audit logs to the data stream.

### Cloud {#the-trail-creation-cloud}

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
      * **Destination**: `{{ yds-name }}`.
      * **Data stream**: Select a data stream. You can also create a new data stream by clicking **Create new** and [specifying](../../data-streams/operations/manage-streams.md#create-data-stream) the data stream settings.
   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the data stream.
   1. Click **Create**.

{% endlist %}

The trail will be created and will begin uploading audit logs to the data stream.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
