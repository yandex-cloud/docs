# Uploading audit logs to a bucket

Follow these instructions to create a new trail that will upload audit logs of resources of an individual cloud or entire organization to an {{ objstorage-name }} bucket with encryption enabled.

{% note tip %}

The setup is similar for buckets where encryption is disabled. The only difference is that you don't have to assign {{ kms-full-name }} roles.

{% endnote %}

## Before you begin {#before-you-begin}

### Organization {#before-you-begin-organization}

To collect organization audit logs:

1. [Create a new bucket](../../storage/quickstart.md#the-first-bucket) to use for uploading audit logs.
1. Create an [encryption key](../../kms/operations/key.md#create) in {{ kms-short-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the previously created encryption key.
1. [Create](../../iam/operations/sa/create.md) a service account and assign the following roles to it:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles) for the organization whose audit logs will be collected:

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

      * [`storage.uploader`](../../storage/security/index.md#storage-uploader) for the folder to host the trail:

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

      * [`kms.keys.encrypterDecrypter`](../../kms/security/index.md#service) for the encryption key:

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

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.

### Cloud {#before-you-begin-cloud}

To collect audit logs of an individual cloud:

1. [Create a new bucket](../../storage/quickstart.md#the-first-bucket) to use for uploading audit logs.
1. Create an [encryption key](../../kms/operations/key.md#create) in {{ kms-short-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the previously created encryption key.
1. [Create](../../iam/operations/sa/create.md) a service account and assign the following roles to it:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * Assign the [`audit-trails.viewer`](../security/index.md#roles) role for the cloud from whose resources the audit logs will be collected:

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

      * Assign the [`storage.uploader`](../../storage/security/index.md#storage-uploader) role for the folder to host the trail:

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

      * Assign the role [`kms.keys.encrypterDecrypter`](../../kms/security/index.md#service) for the encryption key:

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

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `storage.viewer` for the bucket or the folder.

## Creating a trail {#the-trail-creation}

To create the first trail in {{ at-name }} and start the audit log management process:

### Organization {#the-trail-creation-organization}

To create a trail that collects organization audit logs:

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
      * **Destination**: `{{ objstorage-name }}`.
      * **Bucket**: The name of the [bucket](../../storage/operations/buckets/create.md) where you want to upload audit logs.
      * **Object prefix**: An optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.
   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the bucket.
   1. Click **Create**.

{% endlist %}

### Cloud {#the-trail-creation-cloud}

To create a trail that collects audit logs from the cloud:

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
