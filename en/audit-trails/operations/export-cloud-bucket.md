# Uploading cloud audit logs to {{ objstorage-name }}

Follow these instructions to create a new trail that will upload audit logs of a cloud's resources to an {{ objstorage-name }} bucket with encryption enabled.


{% note tip %}

The setup is similar for buckets where encryption is disabled. The only difference is that you don't have to assign {{ kms-full-name }} roles.

{% endnote %}



## Prepare the environment {#before-you-begin}

To collect audit logs of an individual cloud:

1. [Create a new bucket](../../storage/operations/buckets/create.md) to use for uploading audit logs.
1. Create an [encryption key](../../kms/operations/key.md#create) in {{ kms-short-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the previously created encryption key.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. Assign roles to a service account:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * Assign the [`audit-trails.viewer` role](../security/index.md#roles) to the cloud whose resources audit logs will be collected from:

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

      * Assign the [`storage.uploader` role](../../storage/security/index.md#storage-uploader) to the folder that will host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role storage.uploader \
           --id <folder ID> \
           --service-account-id <service account ID>
         ```

         Where:
         * `role`: The role assigned.
         * `id`: The ID of the folder to host the trail:
         * `service-account-id`: The ID of your service account.

      * Assign the [`kms.keys.encrypterDecrypter` role](../../kms/security/index.md#service) to the encryption key:

        ```
        yc kms symmetric-key add-access-binding \
          --role kms.keys.encrypterDecrypter \
          --id <KMS key ID> \
          --service-account-id <service account ID>
        ```

        Where:
        * `role`: The role assigned.
        * `id`: The ID of the KMS key.
        * `service-account-id`: The ID of your service account.

   {% endlist %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.


## Create a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

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
      * **Destination**: `{{ objstorage-name }}`.
      * **Bucket**: Select the bucket where you want to upload audit logs.
      * **Object prefix**: An optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.
   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the bucket.
   1. Click **Create**.

{% endlist %}

The trail will be created and begin uploading audit logs to the bucket.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
