# Uploading audit logs to Cloud Logging

Follow these instructions to create a new trail that will upload audit logs of resources of an individual cloud or entire organization to a {{ cloud-logging-name }} log group.

## Before you begin {#before-you-begin}

### Organization {#before-you-begin-organization}

To export organization audit logs:

1. [Create](../../logging/operations/write-logs.md) a log group to upload audit logs to.
1. Create a service account and assign the following roles to it:
   * `audit-trails.viewer` for the organization whose audit logs will be collected.

      ```
      yc organization-manager organization add-access-binding --role audit-trails.viewer --id <organization ID> --service-account-id <service account ID>
      ```

   * `logging.writer` for the folder to host the trail:

      ```
      yc resourcemanager folder add-access-binding --role logging.writer --id <folder ID> --service-account-id <service account ID>
      ```

1. Make sure that the user has the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `logging.viewer` for a log group in Cloud Logging.

### Cloud {#before-you-begin-cloud}

To export audit logs of an individual cloud:

1. [Create](../../logging/operations/write-logs.md) a log group to upload audit logs to.
1. Create a service account and assign the following roles to it:
   * `audit-trails.viewer` for the cloud:

      ```
      yc resourcemanager cloud add-access-binding --role audit-trails.viewer --id <cloud ID> --service-account-id <service account ID>
      ```

   * `logging.writer` for the folder to host the trail:

      ```
      yc resourcemanager folder add-access-binding --role logging.writer --id <folder ID> --service-account-id <service account ID>
      ```

1. Make sure that the user has the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud from which audit logs will be collected.
   * `logging.viewer` for a log group in Cloud Logging.

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
      * **Service account**: Select the service account on behalf of which the trail will upload audit log files to the log group.
      * **Destination**:
         * **Destination**: {{ cloud-logging-name }}.
         * **Log group**: The name of the log group. You can create a new log group. To do this, click **Create new** and specify:
            * **Name**: Name of group being created.
            * (optional) **Description**.
            * **Log retention**.
            * Click **Create group**.
      * **Filter**:
         * **Resource**: Select `Organization`.
         * **Organization**: Select the name of the organization where the current trail is located.

{% endlist %}

### Cloud {#the-trail-creation-cloud}

To create a trail that exports audit logs of an individual cloud:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to host the trail.
   1. Select **{{ at-name }}**.
   1. Click **Create trail** and specify:
      * **Name**: The name of the trail being created.
      * **Description**: A description of the trail (optional).
      * **Service account**: Select the service account on behalf of which the trail will upload audit log files to the log group.
      * **Destination**:
         * **Destination**: {{ cloud-logging-name }}.
         * **Log group**: The name of the log group. You can create a new log group. To do this, click **Create new** and specify:
            * **Name**: Name of group being created.
            * (optional) **Description**.
            * **Log retention**.
            * Click **Create group**.
      * **Filter**:
         * **Resource**: Select `Cloud`.
         * **Cloud**: Select the name of the cloud hosting the current trail.

{% endlist %}

The trail will be created and will start uploading audit logs to the log group.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Learn more about [Exporting audit logs to SIEM systems](../concepts/export-siem.md).
* Learn more about [searching audit logs in a bucket](../tutorials/search-bucket.md)
