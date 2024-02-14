# Attaching a disk to a VM

You can attach a [disk](../../concepts/disk.md) to either a [running or stopped](../../concepts/vm-statuses.md) [VM](../../concepts/vm.md).

For a disk to be successfully attached to a running VM, the VM's operating system must be ready to accept commands to attach disks. Before attaching a disk, either make sure the OS is loaded up or stop the VM; otherwise, the attach disk operation will fail. If an error occurs, stop the VM and try again.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

## Attaching a disk {#attach}


{% note info %}

You can only attach a local disk to a VM on a [dedicated host](../../concepts/dedicated-host.md) while creating it. For more information, see [this guide](../index.md#dedicated-host).

{% endnote %}


To attach a network disk to a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. Select an unattached disk or [create](../disk-create/empty.md) a new one.
   1. Next to the disk you want to attach, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-attach }}**.
   1. In the window that opens:
      * In the **{{ ui-key.yacloud.compute.attach-disk.field_instance }}** field, select the virtual machine you want to mount your disk to.

      
      * To attach an [encrypted](../../concepts/encryption.md) disk, select a [service account](../../../iam/concepts/users/service-accounts.md) with the `kms.keys.encrypterDecrypter` [role](../../../iam/concepts/access-control/roles.md#kms-keys-encrypterdecrypter) for the [{{ kms-short-name }} key](../../../kms/concepts/key.md) that was used to encrypt the disk.


      * Enter a device name.
      * Enable the **{{ ui-key.yacloud.compute.attach-disk.field_auto-delete }}** option if needed.
   1. Click **{{ ui-key.yacloud.compute.attach-disk.button_attach }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI attach disk command:

      ```bash
      yc compute instance attach-disk --help
      ```

   1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the `ID` or `NAME` of the required disk (for example, `first-disk`). To view a list of disks attached to the VM, run the command:

      ```bash
      yc compute instance get --full first-instance
      ```

   1. Attach the disk to the VM:

      ```bash
      yc compute instance attach-disk first-instance \
        --disk-name first-disk \
        --mode rw
      ```

      To automatically delete the disk when deleting the VM, set the `--auto-delete` flag.

      {% include [attach_empty_disk](../../_includes_service/attach-empty-disk.md) %}

      If an error occurs, stop the VM:

      ```bash
      yc compute instance stop first-instance
      ```

      Then reattach the disk.
   1. If the VM was stopped, restart it:

      ```bash
      yc compute instance start first-instance
      ```

- API {#api}

   Use the [attachDisk](../../api-ref/Instance/attachDisk.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/AttachDisk](../../api-ref/grpc/instance_service.md#AttachDisk) gRPC API call.

{% endlist %}

## Mounting a disk created from a snapshot or image {#mount-disk-and-fix-uuid}

To use the attached disk:

{% list tabs group=operating_system %}

- Linux {#linux}

   Mount the disk:
   1. [Connect](../vm-connect/ssh.md) to the VM over SSH.
   1. Run the `blkid` command and make sure that there are no partitions with duplicate UUIDs:

      ```bash
      sudo blkid
      ```

      Result:

      ```text
      /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      /dev/vdb2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      ...
      ```

   1. If there are, generate a new UUID for the duplicates that come last in the `blkid` command output. In the example from the previous step, you need to generate a UUID for the `/dev/vdb2` partition:

      ```bash
      sudo e2fsck -f /dev/vdb2
      sudo tune2fs -U $(uuidgen) /dev/vdb2
      ```

      This method works for partitions with `ext2`, `ext3`, and `ext4 `file systems. The latter is used in the Linux images provided by {{ yandex-cloud }}. The file system type is returned by the `blkid` command in the `TYPE` parameter.

      If you have a different file system, use the appropriate commands. For example, for `XFS`, execute:

      ```bash
      sudo xfs_admin -U generate /dev/vdb2
      ```

      To see if the UUID changed, run the `blkid` command again:

      ```bash
      sudo blkid
      ```

      Result:

      ```text
      /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      /dev/vdb2: UUID="ea004485-07fb-4128-b20d-e408db1e8ae8" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      ...
      ```

      {% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

   1. {% include [include](../../../_includes/compute/mount-disk.md) %}

   1. Run the `df` command to check the state of the file system.

- Windows {#windows}

   1. Connect to the VM [via RDP](../vm-connect/rdp.md).
   1. Run **Computer Management** (the `compmgmt.msc` snap-in) as an administrator.
   1. Under **Storage**, select **Disk Management**.

      {% note info %}

      When you attach a disk to a running VM, it might not appear in the list. In that case, restart the OS and repeat steps 1 and 2 of this guide.

      {% endnote %}

   1. If the attached disk is **Offline**, right-click it and select **Online**.
   1. Assign a letter to the attached disk if needed. For information about how to do this, see the [Microsoft documentation]({{ ms.docs }}/windows-server/storage/disk-management/change-a-drive-letter).
   1. Open **Explorer** to check that the attached disk is properly mounted and available.

{% endlist %}

## Partitioning and mounting an empty disk {#mount}

To partition and mount an empty disk yourself:

{% list tabs group=operating_system %}

- Linux {#linux}

   1. [Connect to the VM via SSH](../vm-connect/ssh.md).
   1. Check whether the disk is attached as a device and get its path in the system:

      ```bash
      ls -la /dev/disk/by-id
      ```

      Result:

      ```text
      total 0
      drwxr-xr-x 2 root root 140 Jan 16 12:09 .
      drwxr-xr-x 6 root root 120 Jan 13 13:51 ..
      lrwxrwxrwx 1 root root   9 Jan 16 12:09 virtio-fhm1dn62tm5dnaspeh8n -> ../../vdc
      lrwxrwxrwx 1 root root   9 Jan 13 13:51 virtio-fhm4ev6dodt9ing7vgq0 -> ../../vdb
      lrwxrwxrwx 1 root root  10 Jan 13 13:51 virtio-fhm4ev6dodt9ing7vgq0-part1 -> ../../vdb1
      lrwxrwxrwx 1 root root  10 Jan 13 13:51 virtio-fhm4ev6dodt9ing7vgq0-part2 -> ../../vdb2
      lrwxrwxrwx 1 root root   9 Jan 13 13:51 virtio-nvme-disk-0 -> ../../vda
      ```

      Where:
      * Network disk links have the format `virtio-<disk ID>`. For example, `virtio-fhm1dn62tm5dnaspeh8n -> ../../vdc` means that an unpartitioned disk with the `fhm1dn62tm5dnaspeh8n` ID is labeled `/dev/vdc`.
      * The links of local disks on [dedicated hosts](../../concepts/dedicated-host.md) have the format `virtio-nvme-disk-<disk_number>` (if you connected the disks to your VM when creating it). Disk numbering starts from zero. For example, `virtio-nvme-disk-0 -> ../../vda` means that the first local disk (numbered zero) is labeled `/dev/vda`.
   1. Partition your disk. To do this, create [partitions](https://help.ubuntu.com/stable/ubuntu-help/disk-partitions.html.en) using the `cfdisk` [utility](https://manpages.ubuntu.com/manpages/xenial/en/man8/cfdisk.8.html), the `fdisk` [utility](https://manpages.ubuntu.com/manpages/xenial/en/man8/fdisk.8.html), or the `parted` [utility](https://manpages.ubuntu.com/manpages/xenial/en/man8/parted.8.html).

      For example, here is how to create partitions using the `fdisk` command. Use the `sudo` command or run commands on behalf of the `root` user: to do this, run `sudo su -`.
      1. Run the utility:

         ```bash
         sudo fdisk /dev/vdc
         ```

         You will be taken to the `fdisk` menu. For a list of available commands, press **M**.
      1. To create a new partition, press **N**.
      1. Specify that the partition will be the primary one by pressing **P**.
      1. You will be prompted to select a partition number. Press **Enter** to create the first partition.
      1. Leave default values for the numbers of the first and last sectors of the partition: press **Enter** twice.
      1. Make sure the partition has been created. To do this, press **P** to display a list of the disk partitions. This may look as follows:

         ```text
         Device     Boot Start      End  Sectors Size Id Type
         /dev/vdc1        2048 41943039 41940992  20G 83 Linux
         ```

      1. Press **W** to save changes.
   1. Format the disk to a preferred file system, e.g., using the `mkfs` [utility](https://manpages.ubuntu.com/manpages/xenial/en/man8/mkfs.8.html). For example, to format a partition to ext4, enter this command:

      ```bash
      sudo mkfs.ext4 /dev/vdc1
      ```

   1. Mount the disk partitions using the `mount` [utility](https://manpages.ubuntu.com/manpages/xenial/en/man8/mount.8.html). To mount a partition named `vdc1` to the `/mnt/vdc1` directory, run this command:

      ```bash
      sudo mkdir /mnt/vdc1
      sudo mount /dev/vdc1 /mnt/vdc1
      ```

   1. Configure the disk write and read permissions using the `chmod` [utility](https://manpages.ubuntu.com/manpages/jammy/en/man1/chmod.1.html). For example, to grant all users a permission to write data to the disk, run the following command:

      ```bash
      sudo chmod a+w /mnt/vdc1
      ```

   1. Retrieve the disk ID (`UUID`) using the `blkid` [utility](https://manpages.ubuntu.com/manpages/xenial/en/man8/blkid.8.html):

      ```bash
      sudo blkid /dev/vdc1
      ```

      Result:

      ```text
      /dev/vdc1: UUID="397f9660-e740-40bf-8e59-ecb88958b50e" TYPE="ext4" PARTUUID="e34d0d32-01"
      ```

   1. To configure partition automount after VM restart:
      1. Open the `/etc/fstab` file using the `nano` text editor:

         ```bash
         sudo nano /etc/fstab
         ```

      1. Append the following line to the file putting your disk ID in the `UUID` parameter as follows:

         ```text
         UUID=397f9660-e740-40bf-8e59-ecb88958b50e /mnt/vdc1 ext4 defaults 0 2
         ```

      1. Save the changes to the file.
   1. Check the status of your file systems:

      ```bash
      df
      ```

      Result:

      ```text
      Filesystem     1K-blocks    Used Available Use% Mounted on
      udev              989424       0    989424   0% /dev
      tmpfs             203524     816    202708   1% /run
      /dev/vdb2       13354932 2754792  10015688  22% /
      tmpfs            1017608       0   1017608   0% /dev/shm
      tmpfs               5120       0      5120   0% /run/lock
      tmpfs            1017608       0   1017608   0% /sys/fs/cgroup
      tmpfs             203520       0    203520   0% /run/user/1000
      /dev/vdc1         523260    3080    520180   1% /mnt/vdc1
      ```

- Windows {#windows}

   1. Connect to the VM [via RDP](../vm-connect/rdp.md).
   1. Run **Computer Management** (the `compmgmt.msc` snap-in) as an administrator.
   1. Under **Storage**, select **Disk Management**.

      {% note info %}

      When you attach a disk to a running VM, it might not appear in the list. In that case, restart the OS and repeat steps 1 and 2 of this guide.

      {% endnote %}

   1. If the attached disk is **Offline**, right-click it and select **Online**.
   1. Initialize the disk. To do this, right-click it and select **Initialize Disk**. This opens the **Initialize Disk** dialog.
   1. Select a [partition style]({{ ms.docs }}/windows-server/storage/disk-management/initialize-new-disks#about-partition-styles---gpt-and-mbr) and click **OK**.
   1. Create partitions on the disk. To do this, right-click the empty disk and select **New Simple Volume**.
   1. Use the **New Simple Volume Wizard** to set the required partition size, [assign a drive letter]({{ ms.docs }}/windows-server/storage/disk-management/change-a-drive-letter), and specify the file system type.
   1. Open **Explorer** to check that the attached disk is properly mounted and available.

{% endlist %}