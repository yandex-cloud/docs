# Uploading audit logs to ArcSight SIEM

Create a trail to upload management event audit logs of resources in an individual folder to an {{ objstorage-full-name }} bucket with encryption enabled. Then configure continuous log delivery to ArcSight SIEM.

To complete the tutorial successfully, you must have an ArcSight instance installed.

The solution described in the tutorial follows the steps below:
1. A [trail](../../audit-trails/concepts/trail.md) uploads logs to an {{ objstorage-name }} bucket.
1. A [bucket](../../storage/concepts/bucket.md) is mounted via a [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) interface to a folder on an intermediate VM.
1. [SmartConnector](https://www.microfocus.com/documentation/arcsight/arcsight-smartconnectors/AS_SmartConn_getstart_HTML/) collects logs from the folder and delivers them to ArcSight for analysis.

For more information about the scripts for delivering audit logs to ArcSight, see [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight#two-log-shipping-scenarios).

{% include [Yc-security-solutions-library](../../_includes/security-solution-library.md) %}

To configure delivery of audit log files to ArcSight:

1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#prepare-environment).
1. [Assign roles to the service accounts](#add-roles).
1. [Create a trail](#create-trail).
1. [Mount the bucket](#mount-bucket).
1. [Connect ArcSight SmartConnector](#configure-arcsight).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for using VM instances (see [{{ compute-short-name }} pricing](../../compute/pricing.md)).
* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).
* Fee for using {{ kms-short-name }} keys (see [{{ kms-name }} pricing](../../kms/pricing.md#prices)).

## Set up your environment {#prepare-environment}

### Prepare an intermediate VM {#setup-vm}

You can use a VM that has access to an ArcSight instance or create a new one:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a Linux image based on [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

### Create a bucket for audit logs {#create-backet}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket, e.g., `example-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. On the bucket creation page:
      1. Enter a name for the bucket consistent with the [naming requirements](../../storage/concepts/bucket.md#naming).
      1. Limit the maximum bucket size, if required.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Select the `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}` [access type](../../storage/concepts/bucket.md#bucket-access).
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Create an encryption key in {{ kms-name }} {#create-key}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `example-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and specify:
     * **{{ ui-key.yacloud.common.name }}**: `arcsight-kms`.
     * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}**: `AES-256`.
     * Leave other attributes as default.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Enable bucket encryption {#backet-encoding}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the bucket created earlier.
  1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Open the **{{ ui-key.yacloud.storage.bucket.switch_encryption }}** tab.
  1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select `arcsight-kms`.
  1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

{% endlist %}

### Create service accounts {#create-sa}

You need to create two accounts: one for a trail and one for a bucket.

Create the `sa-arcsight` service account:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `example-folder`.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account according to the naming requirements:
  
       {% include [name-format](../../_includes/name-format.md) %}

       For example, `sa-arcsight`.
  
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  
{% endlist %}

Similarly, create a service account named `sa-arcsight-bucket`.

### Create a static key {#create-access-key}

You will need the key ID and secret key when mounting the bucket.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `example-folder`.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `sa-arcsight-bucket` service account from the list that opens.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description for the key and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key.

      {% note alert %}

      After you close this dialog, the key value will not be shown again.

      {% endnote %}

- CLI {#cli}

  1. Create an access key for the `sa-arcsight-bucket` service account.

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

  1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the secret key again.

{% endlist %}

## Assign roles to the service accounts {#add-roles}

Assign the `audit-trails.viewer`, `storage.uploader`, and `kms.keys.encrypterDecrypter` roles to the `sa-arcsight` service account:

{% list tabs group=instructions %}

- CLI {#cli}

  1. `audit-trails.viewer` [role](../../audit-trails/security/index.md#roles) for the folder:
     
      ```
      yc resource-manager folder add-access-binding \
      --role audit-trails.viewer \
      --id <folder_ID> \
      --service-account-id <service_account_ID>
      ```
      
      Where:
  
      * `--role`: Role being assigned.
      * `--id`: `example-folder` ID.
      * `--service-account-id`: `sa-arcsight` service account ID.

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).
  
  1. Assign the `storage.uploader` [role](../../storage/security/index.md#storage-uploader) for the folder the bucket is in:
     
      ```
      yc resource-manager folder add-access-binding \
      --role storage.uploader \
      --id <folder_ID> \
      --service-account-id <service_account_ID>
      ```
  
      Where:
  
      * `--role`: Role being assigned.
      * `--id`: `example-folder` ID.
      * `--service-account-id`: `sa-arcsight` service account ID.

  1. `kms.keys.encrypterDecrypter` [role](../../kms/security/index.md#service) for the `arcsight-kms` encryption key:
  
      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <key_ID> \
      --service-account-id <service_account_ID>
      ```
  
      Where:
  
      * `--role`: Role being assigned.
      * `--id`: ID of the `arcsight-kms` {{ kms-short-name }} key.
      * `--service-account-id`: `sa-arcsight` service account ID.

{% endlist %}

Assign the `storage.viewer` and `kms.keys.encrypterDecrypter` roles to the `sa-arcsight-bucket` service account:

{% list tabs group=instructions %}

- CLI {#cli}

  1. `storage.viewer` role for the folder:
     
      ```
      yc resource-manager folder add-access-binding \
      --id <folder_ID> \
      --role storage.viewer \
      --service-account-id <service_account_ID>
      ```

      Where:
  
      * `--id`: `example-folder` ID.
      * `--role`: Role being assigned.
      * `--service-account-id`: `sa-arcsight-bucket` service account ID.
  
  1. `kms.keys.encrypterDecrypter` role for the `arcsight-kms` encryption key:
  
      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <key_ID> \
      --service-account-id <service_account_ID>
      ```
  
      Where:
  
      * `--role`: Role being assigned.
      * `--id`: ID of the `arcsight-kms` {{ kms-short-name }} key.
      * `--service-account-id`: `sa-arcsight-bucket` service account ID.
  
{% endlist %}

## Create a trail {#create-trail}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `example-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

     * **{{ ui-key.yacloud.common.name }}**: Name of the trail you want to create, e.g., `arcsight-trail`.
     * **{{ ui-key.yacloud.common.description }}**: Trail description (optional).

  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:

     * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
     * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Bucket name.
     * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.
  
     {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: Specify the `arcsight-kms` encryption key used to [encrypt](../../storage/concepts/encryption.md) the bucket.
  
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select `sa-arcsight`.

  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:

     * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
     * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
     * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Automatically populated field containing the name of the current folder.

  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, select `{{ ui-key.yacloud.common.disabled }}` in the **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** field.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  {% note warning %}
  
  The solution will delete the logs from the bucket after they are exported to ArcSight. If you need to keep the logs in the bucket, create a separate bucket and trail.
  
  {% endnote %}

{% endlist %}

## Mount a bucket {#mount-bucket}

A bucket is mounted on an intermediate VM where ArcSight SmartConnector is installed.
To mount the bucket, create a file with the static access key of the `sa-arcsight-bucket` service account.

1. On the intermediate VM, create a file with the static access key:

   ```bash
   echo <access_key_ID>:<secret_access_key> > ${HOME}/.passwd-s3fs
   chmod 600 ${HOME}/.passwd-s3fs
   ```

1. Install [s3fs](https://github.com/s3fs-fuse/s3fs-fuse):

   ```bash
   sudo apt install s3fs
   ```

1. Create a directory to mount the bucket to, e.g., `mybucket` in your home directory:

   ```bash
   sudo mkdir ${HOME}/mybucket
   ```

1. Mount the bucket:

   ```bash
   s3fs <bucket_name> ${HOME}/mybucket -o passwd_file=${HOME}/.passwd-s3fs -o url=https://{{ s3-storage-host }} -o use_path_request_style
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
1. [Download](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight/tree/main/arcsight_content) the `arcsight_content` files.
1. Copy the `yc.jsonparser.properties` file from the `flex` folder to the folder with this address: `<agent_installation_folder>/current/user/agent/flexagent`.
1. Copy the `map.0.properties` file from the `flex` folder to the folder with this address: `<agent_installation_folder>/current/user/agent/map`.
1. Edit the `<agent_installation_folder>/current/user/agent.properties` file:

    ```bash
    agents[0].mode=DeleteFile
    agents[0].proccessfoldersrecursively=true
    ```

1. Start the connector and make sure that events are received by ArcSight:

   ![image](../../_assets/audit-trails/tutorials/arcsight-events.png)

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete](../../storage/operations/buckets/delete.md) the {{ objstorage-name }} bucket.
1. [Delete](../../kms/operations/key.md#delete) the {{ kms-name }} key.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the intermediate VM if you created it in {{ compute-short-name }}.
