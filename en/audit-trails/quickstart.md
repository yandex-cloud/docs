# Getting started with {{ at-name }}

{{ at-name }} collects [audit logs](./concepts/format.md) from {{ yandex-cloud }} resources and uploads them to an {{ objstorage-name }}bucket or a {{ cloud-logging-name }} log group.

Within {{ at-name }}, audit logs are managed by [trails](./concepts/trail.md).

Follow these instructions to create a new trail that will upload audit logs of your organization resources to an {{ objstorage-name }} bucket.

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
   1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. Make sure that your cloud has a bucket where you can store your audit log. [Create a new bucket](../storage/quickstart.md#the-first-bucket) if necessary.
1. Create a service account and assign the following roles to it:
   * `storage.uploader` for the folder to host the trail:

        ```
        yc resource-manager folder add-access-binding --role storage.uploader --id <folder ID> --service-account-id <service account ID>
        ```

   * `audit-trails.viewer` for the organization whose audit logs will be collected:

      ```
      yc organization-manager organization add-access-binding --role audit-trails.viewer --id <organization ID> --service-account-id <service account ID>
      ```

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.

## Creating a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

1. In the [management console]({{ link-console-main }}), select the folder where you wish to host your trail.
1. Select **{{ at-name }}**.
1. Click **Create audit log** and specify:
   1. **Name**: The name of the trail being created.
   1. **Description**: A description of the trail (optional).
   1. **Service account**: Select the service account on behalf of which the trail will upload audit log files to the bucket.
   1. **Destination**:
      * **Destination**: {{ objstorage-name }}.
      * **Bucket**: The name of the bucket where you want to upload audit logs.
      * **Object prefix**: An optional parameter used in the [full name](./concepts/format.md#log-file-name) of the audit log file.
   1. **Filter**:
      * **Resource**: Select `Organization`.
      * **Organization**: Select the name of the organization where the current trail is located.
1. Click **Create**.

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

* Learn more about the [audit log format](./concepts/format.md).
* Learn about [events](./concepts/events.md).
