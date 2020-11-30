# Attaching a disk to a VM

You can attach a disk to either a running or stopped virtual machine.

For a disk to be successfully attached to a running VM, the operating system must be ready to accept commands to attach disks. Before attaching a disk, make sure that the OS is loaded or stop the virtual machine, otherwise the attach disk operation fails. If an error occurs, stop the VM and repeat the operation.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

## Attaching a disk {#attach}

To attach a disk to a VM:

{% list tabs %}

- Management console
   1. Select the folder the VM belongs to.
   1. Select **{{ compute-full-name }}**.
   1. Go to **Disks**.
   1. Under **Disks**, select an unmounted disk or [create](../disk-create/empty.md) a new one.
   1. Next to the desired disk, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Attach**.
   1. In the window that opens:
      - In the **VM** field, select the virtual machine you want to mount your disk to.
      - Enter a **Device name**.
      - Select the value of the **Delete automatically** parameter.
   1. Click **Attach**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI attach disk command:

      ```
      $ yc compute instance attach-disk --help
      ```

  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the VM `ID` or `NAME` (for example, `first-instance`).

  1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select the `ID` or `NAME` of the required disk (for example, `first-disk`). To view a list of disks attached to the VM, run the command:

      ```
      $ yc compute instance get --full first-instance
      ```

  1. Attach the disk to the VM:

      ```
      $ yc compute instance attach-disk first-instance \
          --disk-name first-disk \
          --mode rw
      ```

      To automatically delete the disk when deleting the VM, set the `--auto-delete` flag.

      {% include [attach_empty_disk](../../_includes_service/attach-empty-disk.md) %}

      If an error occurs, stop the virtual machine:

      ```
      $ yc compute instance stop first-instance
      ```

      Then reattach the disk.

  1. If the virtual machine was stopped, restart it:

      ```
      $ yc compute instance start first-instance
      ```

- API

  Use the [attachDisk](../../api-ref/Instance/attachDisk.md) method for the [Instance](../../api-ref/Instance/) resource.

{% endlist %}

## Mounting a disk created from a snapshot or image {#mount-disk-and-fix-uuid}

To use the attached disk:

{% list tabs %}

- Linux

  Mount the disk:

  1. Connect to the VM [via SSH](../vm-connect/ssh.md).

  1. Run the `blkid` command and make sure that there are no partitions with duplicate UUIDs:

      ```bash
      $ sudo blkid
      /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      /dev/vdb2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      ...
      ```

  1. If there are, generate a new UUID for the duplicates that come last in the `blkid` command output. In the example from the previous step, you need to generate a UUID for the `/dev/vdb2` partition:

      ```bash
      $ sudo e2fsck -f /dev/vdb2
      $ sudo tune2fs -U $(uuidgen) /dev/vdb2
      ```

      This method works for partitions with `ext2`, `ext3`, and `ext4` file systems. The latter is used in the Linux images provided by {{ yandex-cloud }}. The file system type is returned by the `blkid` command in the `TYPE` parameter.

      To see if the UUID changed, run the `blkid` command again:

      ```bash
      $ sudo blkid
      /dev/vda2: UUID="0d6dfef0-542d-47ba-b55b-18ab5f5f9210" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      /dev/vdb2: UUID="ea004485-07fb-4128-b20d-e408db1e8ae8" TYPE="ext4" PARTUUID="752aa845-94ee-4850-9188-71c2f919ee7b"
      ```

      {% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

  1. {% include [include](../../../_includes/compute/mount-disk.md) %}

  1. Run the `df` command to check the state of the file system.

- Windows

  1. Connect to the VM [via RDP](../vm-connect/rdp.md).
  
  1. Assign a letter to the attached disk. For information about how to do this, see the [Microsoft documentation](https://docs.microsoft.com/en-us/windows-server/storage/disk-management/change-a-drive-letter).

{% endlist %}

## Partition and mount an empty disk on Linux {#mount}

To partition and mount an empty disk yourself:

1. Run the `lsblk` command to check whether the disk is connected as a device and get its path in the system.  An empty disk is usually labeled `/dev/vdb`.

1. Partition your disk. To do this, create [partitions](https://help.ubuntu.com/stable/ubuntu-help/disk-partitions.html.en) on the disk using the [cfdisk](https://manpages.ubuntu.com/manpages/xenial/en/man8/cfdisk.8.html), `fdisk`, or `parted` utilities. Format the disk for the appropriate file system. For example, you can use the [mkfs](https://manpages.ubuntu.com/manpages/xenial/man8/mkfs.8.html) utility.

1. {% include [include](../../../_includes/compute/mount-disk.md) %}

1. Run the `df` command to check the state of the file system.

