# Mounting {{ objstorage-full-name }} buckets to the file system of {{ dataproc-full-name }} hosts


In {{ dataproc-full-name }}, you can use [initialization actions](../../data-proc/concepts/init-action.md) to configure hosts.

With them, you can automate the installation and setup of [GeeseFS](../../storage/tools/geesefs.md), the software enabling {{ dataproc-full-name }} cluster hosts to mount {{ objstorage-full-name }} buckets via [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

To set up GeeseFS:

1. [Prepare the initialization action](#prepare-init-scripts).
1. [Create a cluster that uses the initialization action](#create-cluster).
1. [Check bucket availability](#check-availability).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

1. [Create](../../storage/operations/buckets/create.md) an {{ objstorage-full-name }} bucket.

1. Grant to the service account the read access for the bucket. For this, use one of the following methods:

    * [Set up the bucket's ACL](../../storage/operations/buckets/edit-acl.md) and grant the `READ` access to the service account.

        The service account will get read access only for the specified bucket.

    * [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `storage.viewer` role.

        The service account will get read access to all buckets in the folder.

## Prepare the initialization action {#prepare-init-scripts}

1. Create the initialization action file named `geesefs_mount.sh` accepting two positional arguments: the name of the {{ objstorage-full-name }} bucket and the host's file system directory where you are going to mount it.

    ```bash
    #!/bin/bash

    set -e

    BUCKET=$1
    MOUNT_POINT=$2

    # Downloading GeeseFS
    wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64 -O /opt/geesefs
    chmod a+rwx /opt/geesefs
    mkdir -p "${MOUNT_POINT}"

    # Preparing a script to run on every boot
    BOOT_SCRIPT="/var/lib/cloud/scripts/per-boot/80-geesefs-mount.sh"
    echo "#!/bin/bash" >> ${BOOT_SCRIPT}
    echo "/opt/geesefs -o allow_other --iam ${BUCKET} ${MOUNT_POINT}" >> ${BOOT_SCRIPT}
    chmod 755 ${BOOT_SCRIPT}

    # Running the script
    ${BOOT_SCRIPT}
    ```

1. [Upload](../../storage/operations/objects/upload.md) the `geesefs_mount.sh` file to the previously created {{ objstorage-full-name }} bucket.

## Create a cluster that would use the initialization action {#create-cluster}

[Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) with the following settings:

* In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the service account you [previously created](#before-you-begin).
* In the **{{ ui-key.yacloud.mdb.forms.config_field_initialization-action }}** field, click **{{ ui-key.yacloud.mdb.forms.button_add-initialization-action }}** and set the script parameters:

    * In the **{{ ui-key.yacloud.mdb.forms.field_initialization-action-uri }}** field, specify the path to the script file in the bucket, such as:

        ```http
        s3a://<bucket_name>/geesefs_mount.sh
        ```

    * In the **{{ ui-key.yacloud.mdb.forms.field_initialization-action-args }}** field, specify the name of the [previously created](#before-you-begin) bucket and `/mnt/test` as your mount point. Arguments are specified on separate lines:

        ```text
        <bucket_name>
        /mnt/test
        ```

* In the **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** field, select the [previously created](#before-you-begin) bucket.

* In the **{{ ui-key.yacloud.mdb.forms.section_subclusters }}** menu, enable **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** in the settings. This will enable you to connect to subcluster hosts without an intermediate virtual machine.

## Check {#check-availability} bucket availability.

1. After the cluster status changes to **Alive**, [connect](../../data-proc/operations/connect.md#data-proc-ssh) via SSH to any of its hosts as the `ubuntu` user.

1. To make sure that the bucket has been mounted successfully, run the command:

    ```bash
    ls /mnt/test/<bucket_name>
    ```

    As a result, it will output the list of objects stored in the root folder of the bucket. In this case, the file name `geesefs_mount.sh`.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
1. If you used static public IP addresses to access the cluster hosts, release and [delete them](../../vpc/operations/address-delete.md).
1. [Delete the {{ objstorage-full-name }} bucket](../../storage/operations/buckets/delete.md).
