# Attaching a disk to a VM

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

To attach a disk to a VM:

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's attach disk command:
  
      ```
      $ yc compute instance attach-disk --help
      ```
  
  1. Get a list of VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  
  1. Stop the VM:
  
      ```
      $ yc compute instance stop first-instance
      ```
  
  1. Get a list of disks in the default folder:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Select the `ID` or `NAME` of the necessary disk (for example, `first-disk`). To view the list of disks attached to the VM, run the command:
  
      ```
      $ yc compute instance get --full first-instance
      ```
  
  1. Attach the disk to the VM:
  
      ```
      $ yc compute instance attach-disk first-instance \
          --disk-name first-disk \
          --mode rw
      ```
  
      {% include [attach_empty_disk](../../_includes_service/attach-empty-disk.md) %}
  
      To specify whether to delete the disk when deleting the VM, set the `--auto-delete` flag:
  
      ```
      $ yc compute instance attach-disk first-instance \
          --disk-name first-disk \
          --mode rw \
          --auto-delete
      ```
  
  1. Start the VM:
  
      ```
      $ yc compute instance start first-instance
      ```
  
- API
  
  Use the [attachDisk](../../api-ref/Instance/attachDisk.md) method for the [Instance](../../api-ref/Instance/) resource.
  
{% endlist %}

## Partition and mount an empty disk on Linux {#mount}

To partition and mount an empty disk yourself:

1. Run the `lsblk` command to check whether the disk is connected as a device and get its path in the system.  An empty disk is usually labeled `/dev/vdb`.

1. Partition your disk. To do this, create [partitions](https://www.howtogeek.com/howto/35676/how-to-choose-a-partition-scheme-for-your-linux-pc/) using [`cfdisk`](http://manpages.ubuntu.com/manpages/trusty/man8/cfdisk.8.html), `fdisk`, or `parted` utilities. Format the disk for the appropriate file system. For example, you can use the [`mkfs`](http://manpages.ubuntu.com/manpages/trusty/man8/mkfs.8.html) utility.

1. Run the [`mount`](https://help.ubuntu.com/community/Mount) command to mount the partition.

1. Run the `df` command to check the state of the file system.
