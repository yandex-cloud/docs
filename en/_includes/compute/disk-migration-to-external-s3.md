# Transferring a {{ compute-full-name }} disk image to a third-party provider's S3-compatible storage with an intermediate VM

You can save a byte-for-byte backup of your {{ compute-name }} [disk](../../compute/concepts/disk.md) in another provider's object storage. Such a backup allows you to keep your data outside {{ yandex-cloud }} and use it for recovery.

In this guide, you will create a disk from a [snapshot](../../compute/concepts/snapshot.md), connect it to an auxiliary Linux VM, and upload the disk or partition image with the help of `s3fs`, `dd`, and `gzip`. The result will be a compressed image in a `.img.gz` file. Creating and starting the VM based on a different provider will require a separate recovery.

{% note info %}

The example used a private [Selectel](https://selectel.ru/) bucket in the `ru-7` region. For a different S3-compatible storage, replace the connection properties and check out the provider's requirements related to access and object sizes.

{% endnote %}

To transfer a disk image to an S3-compatible storage of a third-party provider:

1. [Prepare a bucket and access to it](#prepare-bucket).
1. [Prepare a disk backup and an auxiliary VM](#prepare-disk).
1. [Install the utilities and save the key](#install-tools).
1. [Connect the bucket](#mount-bucket).
1. [Select a device and upload the image](#upload-image).
1. [Check the image in the storage](#verify-image).
1. [Complete the transfer](#finish-transfer).
1. [Restore the image to a separate disk](#restore-image).

If you no longer need the resources you created, [delete](#cleanup) them.

## Prepare a bucket and set up bucket access {#prepare-bucket}

1. [Create](https://docs.selectel.ru/s3/buckets/create-bucket/) a bucket in Selectel:

   * Specify a name, e.g., `disk-snapshot-dr-bucket`. If this name is taken, pick another one and replace it in the commands below.
   * Select private access.
   * Select the `Path-Style` addressing type used in the bucket connection command below.
   * Select the cold storage class.

     {% note warning %}

     Prior to uploading, read the [pricing policy](https://docs.selectel.ru/s3/about/payment/#storage-types), including as pertains to data reading and minimum retention period.

     {% endnote %}

1. On the **Connection** tab, [create](https://docs.selectel.ru/access-control/manage/edit-user-data-or-role/#issue-s3-key) an S3 key named `disk-snapshot-bucket-key`. In the key owner field, select **Me** for a one-time transfer or an individual [Selectel service user](https://docs.selectel.ru/access-control/manage/add-user/#add-service-user) for regular use.
1. Give the service user permissions for the correct project and bucket:
    * Object reading and writing.
    * Viewing bucket contents.
    * _Multipart upload_ operations.

    Requirements for roles are detailed in the [s3fs connection guide](https://docs.selectel.ru/s3/tools/s3fs/).

1. Save `Access key` and `Secret key` to a secure location. You will need them on the auxiliary VM.

## Prepare a disk backup and an auxiliary VM {#prepare-disk}

1. If you do not yet have a snapshot of the disk you want to transfer to another cloud provider, [create](../../compute/operations/disk-control/create-snapshot.md) one.
1. [Create](../../compute/operations/vm-create/create-linux-vm.md) an auxiliary Ubuntu or Debian VM or use an existing one. Make sure you have HTTPS access to the Selectel endpoint.
1. [Create](../../compute/operations/disk-create/from-snapshot.md) a disk from the snapshot in the same [availability zone](../../overview/concepts/geo-scope.md) as the auxiliary VM.
1. [Connect](../../compute/operations/vm-control/vm-attach-disk.md#attach) the new disk to the auxiliary VM as an extra one.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the auxiliary VM over SSH.

{% note warning %}

`s3fs` uses temporary files and local cache. Recording via `gzip` does not guarantee there will be no local buffering. Check for free space in `/tmp` or in the directory set by the `tmpdir` parameter of the `s3fs` utility: allow for a buffer up to the size of the uploaded compressed image.

{% endnote %}

## Install the utilities and save the key {#install-tools}

Execute the following commands until the end of the upload on the auxiliary VM in the same Bash session under `root`.

1. Open the session and install the utilities:

   ```bash
   sudo -i
   apt-get update
   apt-get install -y s3fs gzip
   set -o pipefail
   umask 077
   ```

   `pipefail` will allow you to detect the `dd` error even if the next `gzip` command ends successfully.

1. Enter the access keys for the external bucket:

   ```bash
   read -r -p "Access key: " S3_ACCESS_KEY
   read -r -p "Secret key: " S3_SECRET_KEY
   printf "\n"
   printf "%s:%s\n" "$S3_ACCESS_KEY" "$S3_SECRET_KEY" \
     > "$HOME/.passwd-s3fs"
   unset S3_ACCESS_KEY S3_SECRET_KEY
   chmod 600 "$HOME/.passwd-s3fs"
   ```

   In this session, the `~/.passwd-s3fs` file resides at `/root/.passwd-s3fs`.

## Connect the bucket {#mount-bucket}

1. Create a mount directory:

   ```bash
   mkdir -p /dr-s3mount
   ```

1. Mount the bucket:

   ```bash
   s3fs disk-snapshot-dr-bucket /dr-s3mount \
     -o passwd_file="$HOME/.passwd-s3fs" \
     -o endpoint=ru-7 -o url=https://s3.ru-7.storage.selcloud.ru \
     -o use_path_request_style -o max_dirty_data=512 -o ensure_diskfree=2048
   mountpoint /dr-s3mount
   ```

   Compare the region (`endpoint`) and [S3 API endpoint](https://docs.selectel.ru/s3/manage/domains/#s3-api-domains) (`url`) with the parameters on your bucket's connection tab. For a different provider, replace bucket name, region, and endpoint. Other [s3fs parameters](https://github.com/s3fs-fuse/s3fs-fuse/blob/master/doc/man/s3fs.1.in) are described in the project reference.

Continue only after a successful `mountpoint` check.

## Select a device and upload the image {#upload-image}

1. View connected devices:

   ```bash
   lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL,SERIAL
   ```

   Compare the size and ID with the [disk info](../../compute/operations/disk-control/get-info.md). The `/dev/vda1` device represents only the partition, whereas `/dev/vda`, the whole disk including the partition table. The connected disk's name may be different on the auxiliary VM.

1. Upload the image. The example shows the `/dev/vda1` partition: replace `SOURCE` with a tried path to the disk or partition of interest.

   ```bash
   SOURCE=/dev/vda1
   IMAGE="$(hostname).$(basename "$SOURCE").$(date -u +%Y%m%dT%H%M%SZ).img.gz"
   export IMAGE

   dd if="$SOURCE" bs=4M status=progress | gzip -c > "/dr-s3mount/$IMAGE"
   ```

   `pipefail` allows you to detect the `dd` error even if `gzip` ends successfully. In the event of a failure, the object may remain incomplete, so do not use it for recovery.

   `hostname` in the file name refers to the auxiliary VM. Write the source disk ID separately.

## Check the image in the storage {#verify-image}

1. Unmount the bucket:

   ```bash
   cd /root
   umount /dr-s3mount
   ```

   If unmount ends with an error, fix the error before you continue.

1. Connect the bucket again using the command from [Connect the bucket](#mount-bucket). Reconnecting allows you to check the saved object, not the local cache data from the previous mount.
1. In the Selectel control panel, make sure the object has appeared in the bucket, has a non-zero size, and its storage class is as selected.
1. You can check the downloaded archive for integrity on another target VM:

   ```bash
   gzip -t "img_file.gz"
   ```

   Specify the name of the downloaded file instead of `img_file.gz`. The command reads the archive as a whole and checks it for integrity. This may take time. Be aware of the external provider's reading and outbound traffic charges.

## Complete the transfer {#finish-transfer}

Unmount the bucket on the auxiliary VM:

```bash
umount /dr-s3mount
```

Save the object name, source device, disk size, and backup time. Before you delete the source disk, do a trial recovery to a separate disk: `gzip`'s integrity by itself does not prove that the system is able to load correctly.

## Restore the image to a separate disk {#restore-image}

This method writes the image content to the target device byte for byte. Restore the whole disk image to a whole disk, and the partition image to a separate partition. The target disk or partition must be at least the size of the source.

{% note alert %}

All the target device data will be overwritten. If you are restoring a whole disk image, its partition table will be overwritten as well. A separate partition image does not contain the partition table of the source disk.

{% endnote %}

1. Download `.img.gz` to a Linux VM, connect the target disk and identify its name:

   ```bash
   lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL,SERIAL
   ```

   Make sure you selected an extra disk, not the VM's boot disk. The disk and its partitions must not be mounted. Unmount them before writing.

1. Run the commands in Bash. Specify the name of the downloaded archive instead of `IMAGE`. Replace `/dev/REPLACE_ME` with the target disk, e.g., `/dev/vdc`, if using the whole disk image, or with the target partition, e.g., `/dev/vdc1`, if using a partition image:

   ```bash
   set -o pipefail
   IMAGE="node3.vdb.20261012T082919Z.img.gz"
   TARGET="/dev/REPLACE_ME"

   # Checking the archive for integrity before writing.
   gzip -t "$IMAGE" || exit 1

   # Unpacking directly to the disk without an .img in between.
   if ! gzip -dc "$IMAGE" |
     sudo dd of="$TARGET" bs=4M iflag=fullblock conv=fsync status=progress
   then
     echo "Restoration error. The target disk may be incomplete."
     exit 1
   fi
   echo "The image has been written to the disk."
   ```

## How to delete temporary resources {#cleanup}

Once the restoration is successfully tested, you can delete the unused resources:

* [Auxiliary VM](../../compute/operations/vm-control/vm-delete.md)
* [Disk backups](../../compute/operations/disk-control/delete.md)
* [Snapshots](../../compute/operations/snapshot-control/delete.md)
