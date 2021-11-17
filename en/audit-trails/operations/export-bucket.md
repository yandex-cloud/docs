# Uploading audit logs to a bucket

Follow these instructions to create a new trail that will upload audit logs of cloud resources to an {{ objstorage-name }} bucket with encryption enabled.

{% note tip %}

The setup is similar for buckets where encryption is disabled. The only difference is that you don't have to assign {{ kms-full-name }} roles.

{% endnote %}

## Before you start {#before-you-begin}

1. [Create a new bucket](../../storage/quickstart.md#the-first-bucket) to upload audit logs to it.
1. Create an [encryption key](../../kms/operations/key.md#create) in {{ kms-short-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the encryption key generated.
1. Create a service account and assign the following roles to it:
    * `audit-trails.viewer` for the cloud.
    * `storage.uploader` for the bucket or the folder.
    * `kms.keys.encrypterDecrypter` for the encryption key.
1. Make sure that the user has the following roles:
    * `iam.serviceAccounts.user` for the service account.
    * `audit-trails.editor` for the folder to host the trail.
    * `audit-trails.viewer` for the cloud from which audit logs will be collected.
    * `storage.viewer` for the bucket or the folder.

## Creating a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

1. In the [management console]({{ link-console-main }}), select the folder where you want to host the trail.
1. Select {{ at-name }}.
1. Click **Create audit log** and specify:
    1. **Name**: The name of the trail being created.
    1. **Description**: A description of the trail (optional).
    1. **Service account**: Select the service account on behalf of which the trail will upload audit log files to the bucket.
    1. **Destination**:
        * **Destination**: {{ objstorage-name }}.
        * **Bucket**: The name of the bucket where you want to upload audit logs.
        * **Object prefix**: An optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.
    1. **Filter**:
        * **Resource**: Select `Cloud`.
        * **Cloud**: Select the name of the cloud hosting the current trail.
        * **Folders**: Leave the field empty.
1. Click **Create**.

The trail will be created and begin uploading audit logs to the bucket.

