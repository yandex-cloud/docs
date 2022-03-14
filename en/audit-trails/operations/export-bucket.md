# Uploading audit logs to a bucket

Follow these instructions to create a new trail that will upload audit logs of resources of an individual cloud or entire organization to an {{ objstorage-name }} bucket with encryption enabled.

{% note tip %}

The setup is similar for buckets where encryption is disabled. The only difference is that you don't have to assign {{ kms-full-name }} roles.

{% endnote %}

## Before you start {#before-you-begin}

### Organization {#before-you-begin-organization}

To collect organization audit logs:

1. [Create a new bucket](../../storage/quickstart.md#the-first-bucket) to upload audit logs to.
1. Create the [encryption key](../../kms/operations/key.md#create) in {{ kms-short-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the generated encryption key.
1. Create a service account and assign the following roles to it:
    * `audit-trails.viewer` for the organization whose audit logs will be collected:

        ```
        yc organization-manager organization add-access-binding --role audit-trails.viewer --id <organization ID> --service-account-id <service account ID>
        ```

    * `storage.uploader` for the folder to host the trail:

        ```
        yc resourcemanager folder add-access-binding --role storage.uploader --id <folder ID> --service-account-id <service account ID>
        ```

    * `kms.keys.encrypterDecrypter` for the encryption key:

        ```
        yc kms symmetric-key add-access-binding --role kms.keys.encrypterDecrypter --service-account-id <service account ID> --id <KMS key ID>
        ```

1. Make sure that the user has the following roles:
    * `iam.serviceAccounts.user` for the service account.
    * `audit-trails.editor` for the folder to host the trail.
    * `audit-trails.viewer` for the organization whose audit logs will be collected.
    * `storage.viewer` for the bucket or the folder.

### Cloud {#before-you-begin-cloud}

To collect audit logs of an individual cloud:

1. [Create a new bucket](../../storage/quickstart.md#the-first-bucket) to upload audit logs to.
1. Create the [encryption key](../../kms/operations/key.md#create) in {{ kms-short-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the generated encryption key.
1. Create a service account and assign the following roles to it:
    * `audit-trails.viewer` for the cloud:

        ```
        yc resourcemanager cloud add-access-binding --role audit-trails.viewer --id <cloud ID> --service-account-id <service account ID>
        ```

    * `storage.uploader` for the folder to host the trail:

        ```
        yc resourcemanager folder add-access-binding --role storage.uploader --id <folder ID> --service-account-id <service account ID>
        ```

    * `kms.keys.encrypterDecrypter` for the encryption key:

        ```
        yc kms symmetric-key add-access-binding --role kms.keys.encrypterDecrypter --service-account-id <service account ID> --id <KMS key ID>
        ```

1. Make sure that the user has the following roles:
    * `iam.serviceAccounts.user` for the service account.
    * `audit-trails.editor` for the folder to host the trail.
    * `audit-trails.viewer` for the cloud from which audit logs will be collected.
    * `storage.viewer` for the bucket or the folder.

## Creating a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

### Organization {#the-trail-creation-organization}

To create a trail that collects organization audit logs:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to host the trail.
  1. Select **{{ at-name }}**.
  1. Click **Create audit log** and specify:
      * **Name**: The name of the trail being created.
      * **Description**: A description of the trail (optional).
      * **Service account**: Select the service account on behalf of which the trail will upload audit log files to the bucket.
      * **Destination**:
          * **Destination**: {{ objstorage-name }}.
          * **Bucket**: The name of the bucket where you want to upload audit logs.
          * **Object prefix**: An optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.
      * **Filter**:
          * **Resource**: Select `Organization`.
          * **Organization**: Select the name of the organization where the current trail is located.
  1. Click **Create**.

{% endlist %}

### Cloud {#the-trail-creation-cloud}

To create a trail that collects audit logs of an individual cloud:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to host the trail.
  1. Select **{{ at-name }}**.
  1. Click **Create audit log** and specify:
      * **Name**: The name of the trail being created.
      * **Description**: A description of the trail (optional).
      * **Service account**: Select the service account on behalf of which the trail will upload audit log files to the bucket.
      * **Destination**:
          * **Destination**: {{ objstorage-name }}.
          * **Bucket**: The name of the bucket where you want to upload audit logs.
          * **Object prefix**: An optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.
      * **Filter**:
          * **Resource**: Select `Cloud`.
          * **Cloud**: Select the name of the cloud hosting the current trail.
          * **Folders**: Leave the field empty.
  1. Click **Create**.

{% endlist %}

The trail will be created and begin uploading audit logs to the bucket.
