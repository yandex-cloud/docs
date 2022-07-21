# Using initialization actions to configure GeeseFS in {{ dataproc-name }}

In {{ dataproc-full-name }}, you can use {% if audience != "internal" %}[initialization actions](../../data-proc/concepts/init-action.md){% else %}initialization actions{% endif %} to configure hosts.

With them, you can automate the installation and set up of [GeeseFS](../../storage/tools/geesefs.md), the software that lets {{ dataproc-full-name }} cluster hosts to mount {{ objstorage-full-name }} buckets via [FUSE]({% if lang == "ru" %}https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра){% else %}https://en.wikipedia.org/wiki/Filesystem_in_Userspace{% endif %}).

To set up GeeseFS:

1. [Prepare the initialization action](#prepare-init-scripts).
1. [Create a cluster that uses the initialization action](#create-cluster).
1. [Check bucket availability](#check-availability).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. {% if audience != "internal" %}[Create a service account](../../iam/operations/sa/create.md){% else %}Create a service account{% endif %} with the `mdb.dataproc.agent` role.

1. [Create an {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md).

1. Grant to the service account the read access for the bucket. For this, use one of the following methods:

   * [Set up the bucket's ACL](../../storage/operations/buckets/edit-acl.md) and grant to the service account the `READ` access.

      The service account will get read access only for the specified bucket.

   * {% if audience != "internal" %}[Assign the service account](../../iam/operations/sa/assign-role-for-sa.md){% else %}Assign the service account{% endif %} the `storage.viewer` role.

      The service account will get read access to all buckets in the folder.

## Prepare the initialization action {#prepare-init-scripts}

1. Create a file for the initialization action named `geesefs_mount.sh` that accepts two positional arguments: the name of the {{ objstorage-full-name }} bucket and the directory in the host's file system where you mount it.

   ```bash
   #!/bin/bash

   set -e

   BUCKET=$1
   MOUNT_POINT=$2

   # Download GeeseFS
   wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64 -O /opt/geesefs
   chmod a+rwx /opt/geesefs
   mkdir -p "${MOUNT_POINT}"

   # Prepare the action run at each startup
   BOOT_SCRIPT="/var/lib/cloud/scripts/per-boot/80-geesefs-mount.sh"
   echo "#!/bin/bash" >> ${BOOT_SCRIPT}
   echo "/opt/geesefs -o allow_other --iam ${BUCKET} ${MOUNT_POINT}" >> ${BOOT_SCRIPT}
   chmod 755 ${BOOT_SCRIPT}

   # Run the action
   ${BOOT_SCRIPT}
   ```

1. [Upload](../../storage/operations/objects/upload.md) the `geesefs_mount.sh` file to the previously created {{ objstorage-full-name }} bucket.

## Create a cluster that would use the initialization action {#create-cluster}

{% if audience != "internal" %}[Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md){% else %}Create a {{ dataproc-name }} cluster{% endif %} with the following settings:

* **Service account**: Select the service account you created previously.
* **Custom scripts**: Add an action with the following parameters:

   * **URI**: Specify the path to the action file in the bucket, for example:

      ```http
      s3a://<bucket name>/geesefs_mount.sh
      ```

   * **Arguments**: Specify the name of the previously created bucket and `/mnt/test` as your mount point. Arguments are specified on separate lines:

      ```text
      <bucket name>
      /mnt/test
      ```

* **Bucket name**: Select a previously created bucket.

* **Sub**: Enable **Public access** in the settings. This will enable you to connect to subcluster hosts without an intermediate virtual machine.

## Check {#check-availability} bucket availability.

1. After the cluster status changes to **Alive**, {% if audience != "internal" %}[connect via SSH](../../data-proc/operations/connect.md#data-proc-ssh){% else %}connect via SSH{% endif %} to any of its hosts as the `ubuntu` user.

1. To make sure that the bucket has been mounted successfully, run the command:

   ```bash
   ls /mnt/test/<bucket name>
   ```

   It will return the list of objects stored in the root folder of the bucket. In this case, the file name is `geesefs_mount.sh`.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

1. {% if audience != "internal" %}[Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md){% else %}Delete the {{ dataproc-name }} cluster{% endif %}.
1. If you used static public IP addresses to access the cluster hosts, release and {% if audience != "internal" %}[delete them](../../vpc/operations/address-delete.md){% else %}delete them{% endif %}.
1. [Delete the {{ objstorage-full-name }} bucket](../../storage/operations/buckets/delete.md).
