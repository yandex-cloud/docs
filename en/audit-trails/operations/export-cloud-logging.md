# Uploading audit logs to Cloud Logging

Follow these instructions to create a new trail that will upload audit logs of your cloud resources to a {{ cloud-logging-name }} log group.

## Before you start {#before-you-begin}

1. [Create](../../logging/operations/write-logs.md) a log group to upload audit logs to.
1. Create a service account and assign the following roles to it:
    * `audit-trails.viewer` for the cloud.
    * `logging.writer` for a log group or folder.
1. Make sure that the user has the following roles:
    * `iam.serviceAccounts.user` for the service account.
    * `audit-trails.editor` for the folder to host the trail.
    * `audit-trails.viewer` for the cloud from which audit logs will be collected.
    * `logging.viewer` for a log group in Cloud Logging.

## Creating a trail {#the-trail-creation}

1. In the [management console]({{ link-console-main }}), select the folder where you want to host the trail.
1. Select {{ at-name }}.
1. Click **Create audit log** and specify:
    1. **Name**: The name of the trail being created.
    1. **Description**: A description of the trail (optional).
    1. **Service account**: Select the service account on behalf of which the trail will upload audit log files to the log group.
    1. **Destination**:
        * **Destination**: {{ cloud-logging-name }}.
        * **Log group**: The name of the log group.
    1. **Filter**:
        * **Resource**: Select `Cloud`.
        * **Cloud**: Select the name of the cloud hosting the current trail.
The trail will be created and will start uploading audit logs to the log group.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Learn more about [Exporting audit logs to SIEM systems](../concepts/export-siem.md).
* Learn more about [searching audit logs in a bucket](../tutorials/search-bucket.md).

