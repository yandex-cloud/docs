# Uploading {{ at-full-name }} audit logs to SIEM KUMA

In this tutorial, you will create an {{ at-short-name }} [trail](../../audit-trails/concepts/trail.md) that will provide audit logs to the KUMA collector. 

The [solution](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/290821.htm) described in the tutorial works as follows:

1. A trail uploads logs to an {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) with [encryption](../../storage/concepts/encryption.md) enabled.
1. The bucket is mounted as a part of the [file system](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) on the server with the KUMA collector installed.
1. The KUMA collector receives event data from the mounted bucket and forwards it for processing.

To configure delivery of audit log files to KUMA:

1. [Prepare your cloud](#before-you-begin).
1. [Prepare the environment](#setup-environment).
1. [Create a bucket](#create-bucket).
1. [Create a trail](#create-trail).
1. [Mount the bucket on a server](#mount-bucket).
1. [Configure the KUMA collector](#setup-collector).

If you no longer need the resources you created, [delete them](#clear-out).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of support for a new {{ yandex-cloud }} infrastructure includes:
* Fee for data storage, operations with data, and outgoing traffic (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for a symmetric encryption key and cryptographic operations (see [{{ kms-full-name }} pricing](../../kms/pricing.md)).
* (Optional) Fee for a continuously running VM (see [{{ compute-full-name }}](../../compute/pricing.md) pricing).
* (Optional) Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }}](../../vpc/pricing.md) pricing).

In addition, to complete the tutorial you will need a KUMA user license (not supplied by {{ yandex-cloud }}).


## Prepare the environment {#setup-environment}

### Create service accounts {#create-service-accounts}

The infrastructure you are creating will require two [service accounts](../../iam/concepts/users/service-accounts.md): one for the {{ objstorage-name }} bucket, the second for the trail in {{ at-short-name }}.

To create the service accounts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name of the service account for the bucket: `kuma-bucket-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Repeat steps 3-5 to create the `kuma-trail-sa` service account for the trail.

{% endlist %}

### Create a static access key {#create-static-key}

To mount the bucket on a server with a KUMA collector installed, create a [static access key](../../iam/concepts/authorization/access-key.md) for the `kuma-bucket-sa` service account:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `kuma-bucket-sa` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key: you will need them later when mounting the bucket on the server.

      {% note alert %}

      After you close the dialog, the key value will become unavailable.

      {% endnote %}

{% endlist %}

### Create an encryption key {#create-encryption-key}

To create a new [symmetric encryption key](../../kms/concepts/key.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and set the key attributes:

     * Name: `kuma-key`.
     * Encryption algorithm, e.g. `AES-256`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Assign roles to the service accounts {#assign-roles}

1. To assign roles for a folder to service accounts:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. Select the `kuma-trail-sa` service account from the list, use the search if required.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**; in the window that opens, select the `audit-trails.viewer` [role](../../audit-trails/security/index.md#at-viewer).

          Repeat this step and add the `storage.uploader` [role](../../storage/security/index.md#storage-uploader).
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.
      1. Repeat steps 3-7 to assign the `storage.viewer` [role](../../storage/security/index.md#storage-viewer) for the folder to the `kuma-bucket-sa` service account.

    {% endlist %}

1. To assign the `kms.keys.encrypterDecrypter` [role](../../kms/security/index.md#kms-keys-encrypterDecrypter) for the encryption key created earlier to the service accounts:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}** and click on the line with `kuma-key`.
      1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. Select the `kuma-trail-sa` service account.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `kms.keys.encrypterDecrypter` role.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.
      1. Repeat steps 3-7 to assign the `kms.keys.encrypterDecrypter` role for the encryption key to the `kuma-bucket-sa` service account.

    {% endlist %}


## Create a bucket {#create-bucket}

To create a bucket for the trail to save audit logs to:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket, e.g., `my-audit-logs-for-kuma`.

      {% note info %}

      Bucket names must be unique throughout {{ objstorage-short-name }}, which means you cannot create two buckets with the same name even in different folders belonging to different clouds.

      {% endnote %}

  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** field, set the size of the bucket you are creating or enable **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Leave all other parameters as they are and click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. On the page with a list of buckets that opens, select the new bucket.
  1. In the left-hand menu, select ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**and go to the **{{ ui-key.yacloud.storage.bucket.switch_encryption }}** tab.
  1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select the previously created `kuma-key`.
  1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

{% endlist %}


## Create a trail {#create-trail}

To create a trail:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**:

      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail: `kuma-trail`.
      1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:

          * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
          * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Bucket you created earlier, e.g., `my-audit-logs-for-kuma`.
          * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.
      
          {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}
      1. Make sure the **{{ ui-key.yacloud.audit-trails.title_kms-key }}** field contains the encryption key named `kuma-key`. If the encryption key is not set, click **{{ ui-key.yacloud.audit-trails.action_add-bucket-key }}** and select this key.

      1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:

          * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Automatically populated field containing the name of the current folder.

      1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}** above, select the `kuma-trail-sa` service account.

      1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, keep the `{{ ui-key.yacloud.common.disabled }}` value.

      1. Click **{{ ui-key.yacloud.common.create }}**.

  {% endlist %}


## Mount the bucket on a server {#mount-bucket}

Perform this action on the server you are going to install the KUMA collector on. As a server, you can use a {{ compute-full-name }} VM or your own hardware. In this tutorial, we will use a {{ compute-short-name }} VM.

To mount the bucket on a server:

1. [Create](../../compute/operations/vm-create/create-linux-vm.md) a virtual machine from the [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) public image.
1. Connect to the VM via [SSH](../../compute/operations/vm-connect/ssh.md) or [{{ oslogin }}](../../compute/operations/vm-connect/os-login.md).
1. Create a new user named `kuma`:

    ```bash
    sudo useradd kuma
    ```
1. Create the `kuma` user's home directory:

    ```bash
    sudo mkdir /home/kuma
    ```
1. Create a file with a static access key and grant permissions for it to the `kuma` user:

    ```bash
    sudo bash -c 'echo <access_key_ID>:<secret_access_key> > /home/kuma/.passwd-s3fs'
    sudo chmod 600 /home/kuma/.passwd-s3fs
    sudo chown -R kuma:kuma /home/kuma
    ```

    Where `<access_key_ID>` and `<secret_access_key>` are the previously saved values ​​of the static access key of the `kuma-bucket-sa` service account.
1. Install the [s3fs](https://github.com/s3fs-fuse/s3fs-fuse) package:

    ```bash
    sudo apt install s3fs
    ````
1. Create a directory that will serve as a mount point for the bucket and grant permissions for it to the `kuma` user:

    ```bash
    sudo mkdir /var/log/yandex-cloud/
    sudo chown kuma:kuma /var/log/yandex-cloud/
    ```
1. Mount the bucket you created earlier by specifying its name:

    ```bash
    sudo s3fs <bucket_name> /var/log/yandex-cloud \
      -o passwd_file=/home/kuma/.passwd-s3fs \
      -o url=https://{{ s3-storage-host }} \
      -o use_path_request_style \
      -o uid=$(id -u kuma) \
      -o gid=$(id -g kuma)
    ```

    You can configure automatic mounting of the bucket at operating system start-up by opening the `/etc/fstab` file (`sudo nano /etc/fstab` command) and adding the following line to it:

    ```text
    s3fs#<bucket_name> /var/log/yandex-cloud fuse _netdev,uid=<kuma_uid>,gid=<kuma_gid>,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/kuma/.passwd-s3fs 0 0
    ```

    Where:
    * `<bucket_name>`: Name of the bucket you created earlier, e.g., `my-audit-logs-for-kuma`.
    * `<kuma_uid>`: `kuma` user ID in the VM operating system.
    * `<kuma_gid>`: `kuma` user group ID in the VM operating system.

        To learn `<kuma_uid>` and `<kuma_gid>`, run the `id kuma` command in the terminal.
1. Make certain that the bucket is mounted:

    ```bash
    sudo ls /var/log/yandex-cloud/
    ```

    If everything is configured correctly, the command will return the current contents of the audit event bucket.

The {{ yandex-cloud }} event transfer setup is complete. The events will reside in [JSON](https://en.wikipedia.org/wiki/JSON) files located at:

```text
/var/log/yandex-cloud/{audit_trail_id}/{year}/{month}/{day}/*.json
```

## Configure the KUMA collector {#setup-collector}

For this step, you will need the distribution and license files included with KUMA. Use them to install and configure the collector in the KUMA network infrastructure. For more information, see [this guide](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/220708.htm).

Once the setup is successfully completed, audit events will start being delivered to KUMA. The KUMA web interface allows you to [search for related events](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/217989.htm).

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* Delete the [trail](../../audit-trails/concepts/trail.md).
* [Delete](../../storage/operations/objects/delete-all.md) all objects in the bucket, then [delete](../../storage/operations/buckets/delete.md) the bucket itself.
* [Delete](../../kms/operations/key.md#delete) the {{ kms-short-name }} encryption key.
* [Delete](../../iam/operations/sa/delete.md) the service accounts.
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM if you had created one.