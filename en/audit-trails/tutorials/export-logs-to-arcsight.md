# Uploading audit logs to ArcSight SIEM

Create a trail to upload the audit logs of resources in a single folder to a {{ objstorage-full-name }} bucket with encryption enabled. Then configure continuous log delivery to ArcSight SIEM.

To complete the tutorial successfully, you must have an instance of ArcSight installed.

The solution described in the tutorial follows the procedure below:
1. A [trail](../concepts/trail.md) uploads logs to a {{ objstorage-name }} bucket.
1. A [bucket](../../storage/concepts/bucket.md) is mounted via a [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) interface to a folder on an intermediate VM.
1. [SmartConnector](https://www.microfocus.com/documentation/arcsight/arcsight-smartconnectors/AS_SmartConn_getstart_HTML/) connects logs from the folder and passes them to ArcSight for analysis.

For more information about the scripts for uploading audit logs to ArcSight, see [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight#two-log-shipping-scenarios).

{% include [Yc-solution-library-for-security](../../_includes/security-solution-library.md) %}

To configure delivery of audit log files to ArcSight:

1. [Prepare your cloud](#before-begin).
1. [Prepare the environment](#prepare-environment).
1. [Assign roles to the service accounts](#add-roles).
1. [Create a trail](#create-trail).
1. [Mount the bucket](#mount-bucket).
1. [Connect ArcSight SmartConnector](#configure-arcsight).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Using virtual machines (see [{{ compute-short-name }} pricing](../../compute/pricing.md)).
* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).
* A fee for using {{ kms-short-name }} keys (see [{{ kms-name }} pricing](../../kms/pricing.md#prices)).

## Prepare the environment {#prepare-environment}

### Prepare an intermediate VM {#setup-vm}

You can use a VM that has access to an ArcSight instance or create a new one:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a Linux image based on Ubuntu 20.04.
1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md#vm-connect) via SSH.

### Create a bucket for audit logs {#create-backet}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a bucket, for example, `example-folder`.
   1. Select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter the bucket name following the [naming guidelines](../../storage/concepts/bucket.md#naming), such as `arcsight-bucket`.
      1. Limit the maximum bucket size, if required.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Select the `Limited` [access](../../storage/concepts/bucket.md#bucket-access) type.
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **Create bucket**.

{% endlist %}

### Create an encryption key in {{ kms-name }} {#create-key}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `example-folder`.
   1. Select **{{ kms-name }}**.
   1. Click **Create** and specify:
      * **Name**: `arcsight-kms`.
      * **Encryption algorithm**: `AES-256`.
      * Leave the other parameters at their default settings.
   1. Click **Create**.

{% endlist %}

### Enable bucket encryption {#backet-encoding}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `arcsight-bucket`.
   1. On the left-hand panel, select **Encryption**.
   1. In the **{{ kms-short-name }} key** field, select the `arcsight-kms` key.
   1. Click **Save**.

{% endlist %}

### Create service accounts {#create-sa}

You need to create two accounts: one for a trail and one for a bucket.

Create the `sa-arcsight` service account:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `example-folder`.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter the service account name, following the naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

      For example, `sa-arcsight`.

   1. Click **Create**.

{% endlist %}

Create the `sa-arcsight-bucket` service account the same way.

### Create a static key {#create-access-key}

You will need the key ID and secret key when mounting the bucket.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `example-folder`.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Choose `sa-arcsight-bucket` and click the line with its name.
   1. Click **Create new key** on the top panel.
   1. Select **Create static access key**.
   1. Enter a description for the key and click **Create**.
   1. Save the ID and private key.

      {% note alert %}

      Once you close the dialog, the private key value will be unavailable.

      {% endnote %}

- CLI

   1. Create an access key for `sa-arcsight-bucket`:

      ```bash
      yc iam access-key create --service-account-name sa-arcsight-bucket
      ```

      Result:

      ```
      access_key:
        id: aje*******k2u
        service_account_id: aje*******usm
        created_at: "2022-09-22T14:37:51Z"
        key_id: 0n8*******0YQ
      secret: JyT*******zMP1
      ```

   1. Save the ID `key_id` and `secret` key. You will not be able to get the key value again.

{% endlist %}

## Assign roles to the service accounts {#add-roles}

Assign `sa-arcsight` the `audit-trails.viewer`, `storage.uploader`, and `kms.keys.encrypterDecrypter` roles:

{% list tabs %}

- CLI

   1. The `audit-trails.viewer` [role](../../audit-trails/security/#roles) to the folder:

      ```
      yc resource-manager folder add-access-binding \
      --role audit-trails.viewer \
      --id <example-folder_ID> \
      --service-account-id <sa-arcsight_service_account_ID>
      ```

      Where:

      * `role`: Role being assigned.
      * `id`: The ID of `example-folder`.
      * `service-account-id`: The ID of `sa-arcsight`.

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

   1. The `storage.uploader` [role](../../storage/security/#storage-uploader) to the folder with a bucket:

      ```
      yc resource-manager folder add-access-binding \
      --role storage.uploader \
      --id <example-folder_ID> \
      --service-account-id <sa-arcsight_service_account_ID>
      ```

      Where:

      * `role`: Role being assigned.
      * `id`: The ID of `example-folder`.
      * `service-account-id`: The ID of `sa-arcsight`.

   1. The `kms.keys.encrypterDecrypter` [role](../../kms/security/#service) to the `arcsight-kms` encryption key:

      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <arcsight-kms_key_ID> \
      --service-account-id <sa-arcsight_service_account_ID>
      ```

      Where:

      * `role`: Role being assigned.
      * `id`: The ID of the `arcsight-kms` {{ kms-short-name }} key.
      * `service-account-id`: The ID of `sa-arcsight`.

{% endlist %}

Assign `sa-arcsight-bucket` the `storage.viewer` and `kms.keys.encrypterDecrypter` roles:

{% list tabs %}

- CLI

   1. The `storage.viewer` role to the folder:

      ```
      yc resource-manager folder add-access-binding \
      --id <example-folder_ID> \
      --role storage.viewer \
      --service-account-id <sa-arcsight-bucket_service_account_ID>
      ```

      Where:

      * `role`: Role being assigned.
      * `id`: The ID of `example-folder`.
      * `service-account-id`: The ID of `sa-arcsight-bucket`.

   1. The `kms.keys.encrypterDecrypter` role to the `arcsight-kms` encryption key:

      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <arcsight-kms_key_ID> \
      --service-account-id <sa-arcsight-bucket_service_account_ID>
      ```

      Where:

      * `role`: Role being assigned.
      * `id`: The ID of the `arcsight-kms` {{ kms-short-name }} key.
      * `service-account-id`: The ID of `sa-arcsight-bucket`.

{% endlist %}

## Create a trail {#create-trail}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `example-folder`.
   2. Select **{{ at-name }}**.
   3. Click **Create trail** and specify:

      * **Name**: The name of the trail to create. For example: `arcsight-trail`.
      * **Description**: Description of the trail (optional).

   4. Under **Filter**, set up the audit log scope:

      * **Resource**: Select `Folder`.
      * **Folder**: An automatically populated field containing the name of the current folder.

   5. Under **Destination**, set up the destination object:

      * **Destination**: `{{ objstorage-name }}`.
      * **Bucket**: `arcsight-bucket`.
      * **Object prefix**: An optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

      {% note info %}

      Use a [prefix](../../storage/concepts/object.md#key) to store audit logs and third-party data in the same bucket. Do not use the same prefix for logs and other bucket objects because that may cause logs and third-party objects to overwrite each other.

      {% endnote %}

   6. Under **Service account**, select `sa-arcsight`.
   7. Click **Create**.

   {% note warning %}

   The solution will delete the logs from the bucket after they are exported to ArcSight. If you need to keep the logs in the bucket, create a separate bucket and trail.

   {% endnote %}

{% endlist %}

## Mount a bucket {#mount-bucket}

A bucket is mounted on an intermediate VM where ArcSight SmartConnector is installed.
To mount the bucket, create a file with the `sa-arcsight-bucket` service account static access key.

1. On the intermediate VM, create a file with the static access key:

   ```bash
   echo <access_key_ID>:<secret_access_key> > ${HOME}/.passwd-s3fs
   chmod 600 ${HOME}/.passwd-s3fs
   ```

1. Install [s3fs](https://github.com/s3fs-fuse/s3fs-fuse):

   ```bash
   sudo apt install s3fs
   ```

1. Create a directory where the bucket will be mounted. For example: `mybucket` in the home directory:

   ```bash
   sudo mkdir ${HOME}/mybucket
   ```

1. Mount the bucket:

   ```bash
   s3fs arcsight-bucket ${HOME}/mybucket -o passwd_file=${HOME}/.passwd-s3fs -o url=https://{{ s3-storage-host }} -o use_path_request_style
   ```

1. Check that the bucket was mounted:

   ```bash
   ls ${HOME}/mybucket
   ```

## Install and configure ArcSight SmartConnector {#configure-arcsight}

{% note info %}

To complete this stage of the tutorial, you need an ArcSight SmartConnector distribution and access to an ArcSight instance.

{% endnote %}

1. On the intermediate VM, [install](https://www.microfocus.com/documentation/arcsight/arcsight-smartconnectors/AS_smartconn_install/) `ArcSight SmartConnector`:
   1. When installing it, select **ArcSight FlexConnector JSON Folder Follower** and specify the path to the `mybucket` folder.
   1. Specify **JSON configuration filename prefix**: `yc`.
1. [Download](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight/arcsight_content) the `arcsight_content` files.
1. Copy the `yc.jsonparser.properties` file from the `flex` folder to the `<agent_installation_folder>/current/user/agent/flexagent` folder.
1. Copy the `map.0.properties` file from the `flex` folder to the `<agent_installation_folder>/current/user/agent/map` folder.
1. Edit the file `<agent_installation_folder>/current/user/agent/agent.properties`:

   ```bash
   agents[0].mode=DeleteFile
   agents[0].proccessfoldersrecursively=true
   ```

1. Start the connector and make sure that events are received by ArcSight:

   ![image](../../_assets/audit-trails/tutorials/arcsight-events.png)

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete](../../storage/operations/buckets/delete.md) the bucket {{ objstorage-name }}.
1. [Destroy](../../kms/operations/key.md#delete) the {{ kms-name }} key.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the intermediate VM if you created it in {{ compute-short-name }}.
