---
title: How to update a disk in {{ compute-full-name }}
description: Follow this guide to update a disk.
---

# Updating a disk


After creating a [disk](../../concepts/disk.md), you can:
* [Change the disk name and description](#change-disk-name).
* [Increase the size of your disk](#change-disk-size), even if it is attached to a [running](../../concepts/vm-statuses.md#list-of-statuses) [VM](../../concepts/vm.md).

## Changing the disk name and description {#change-disk-name}

To change the name and description of a disk:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update a disk.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the disk and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the disk name and description.
  1. Click **{{ ui-key.yacloud.compute.disks.edit.button_update }}**.

  {{ compute-name }} will initiate disk updating.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for updating a disk:

     ```bash
     {{ yc-compute }} disk update --help
     ```

  1. Request a list of available disks:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select `ID` or `NAME` of the disk, e.g., `first-disk`.
  1. Specify the name and description in the disk update command:

     ```bash
     {{ yc-compute }} disk update first-disk \
       --new-name updated-disk \
       --description "Updated disk via CLI"
     ```

     {{ compute-name }} will initiate disk updating.

- API {#api}

  To change the name or description of a disk, use the [update](../../api-ref/Disk/update.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Update](../../api-ref/grpc/Disk/update.md) gRPC API call.

  To request a list of available disks, use the [list](../../api-ref/Disk/list.md) REST API method or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

{% endlist %}

## Increasing the disk size {#change-disk-size}

{% note info %}

You can only increase the size of a disk. Reducing it is not supported.

{% endnote %}

You can increase the disk size even on a [running](../../concepts/vm-statuses.md#list-of-statuses) VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the disk.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the disk and select **{{ ui-key.yacloud.common.edit }}**.
  1. Increase the disk size.
  1. Click **{{ ui-key.yacloud.compute.disks.edit.button_update }}**.

     {{ compute-name }} will initiate disk resizing.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a disk:

     ```bash
     {{ yc-compute }} disk update --help
     ```

  1. Request a list of available disks:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select `ID` or `NAME` of the disk, e.g., `first-disk`.
  1. Specify the size, e.g., 32 GB, in the disk update command:

     ```bash
     {{ yc-compute }} disk update first-disk \
       --size 32
     ```

     {{ compute-name }} will initiate disk resizing.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note warning %}

  You can increase the disk size using {{ TF }} without recreating the VM if the disk is specified in the manifest as a separate `yandex_compute_disk` resource.

  If the disk is specified under `initialize_params` in the `yandex_compute_instance` resource, the VM will be recreated when increasing the disk size using {{ TF }}. To increase the size of such a disk without recreating the VM, use the [management console](../../../console/), CLI, or API.

  {% endnote %}

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

     ```hcl
     # Creating a disk

     resource "yandex_compute_disk" "first-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<image_ID>"
     }

     # Creating a VM

     resource "yandex_compute_instance" "vm-lamp" {
       name        = "<VM_name>"
       platform_id = "standard-v3"
       zone        = "<availability_zone>"

       resources {
         core_fraction = <vCPU_performance_level>
         cores         = <number_of_vCPUs>
         memory        = <RAM_in_GB>
       }

       boot_disk {
         disk_id = yandex_compute_disk.first-disk.id
       }

       network_interface {
         subnet_id          = "<subnet_ID>"
         nat                = true
         security_group_ids = [<security_group_ID>]
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=        (ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - <SSH_key_contents>"
       }
     }
     ```

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. To increase the disk size, make the following changes to the configuration file:

     ```hcl
     resource "yandex_compute_disk" "first-disk" {
       ...
       size = "<new_disk_size>"
     }
     ```

     Where `size` is the new size for the disk.
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will increase the disk size. You can check the disk size and settings using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc compute disk get <disk_name>
     ```

- API {#api}

  You can increase the disk size by using the [update](../../api-ref/Disk/update.md) REST API method for the [Disk](../../api-ref/Disk/) resource or the [DiskService/Update](../../api-ref/grpc/Disk/update.md) gRPC API call.

  To request a list of available disks, use the [list](../../api-ref/Disk/list.md) REST API method or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

{% endlist %}

To change the size of the boot disk, [restart](../vm-control/vm-stop-and-start.md#restart) the VM.

## Increasing the size of a Linux disk partition {#change-part-size-linux}

After increasing the disk size, you also need to increase the size of its partitions and file systems. For boot disks, this happens automatically after you restart the VM. 

You can also increase the size of any VM disk without restarting the VM. The workflow depends on the file system of the disk partition in question:

{% list tabs %}

- ext4

  1. [Connect](../../operations/vm-connect/ssh.md) to the VM over SSH:

     ```bash
     ssh <username>@<VM_public_IP_address>
     ```

  1. See the disks attached to the VM:

     ```bash
     lsblk
     ```

     Result:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part /data
     ```

     Disk partitions are listed under `NAME`. If the `MOUNTPOINTS` column contains a value for the partition you need, it means the partition is mounted.

  1. (Optional) Check and recover the file system.

     {% note info %}

     Skip this step if you want to increase the root partition.

     {% endnote %}

     1. Unmount the disk:

        ```bash
        sudo umount /data
        ```

        Where `/data` is the partition mount point.

     1. Check and recover the file system:

        ```bash
        sudo e2fsck -f /dev/vdb1
        ```

        Result:

        ```text
        e2fsck 1.44.1 (24-Mar-2018)
        Pass 1: Checking inodes, blocks, and sizes
        Pass 2: Checking directory structure
        Pass 3: Checking directory connectivity
        Pass 4: Checking reference counts
        Pass 5: Checking group summary information
        /dev/vdb1: 11/2097152 files (0.0% non-contiguous), 143890/8388352 blocks
        ```

  1. Resize the partition:

     ```bash
     sudo growpart /dev/vdb 1
     ```

     Where:
     * `/dev/vdb`: Device name.
     * `1`: Partition number, which must be separated by a space.

     Result:

     ```text
     CHANGED: partition=1 start=2048 old: size=67106816 end=67108864 new: size=134215647,end=134217695
     ```

  1. Resize the file system:

     ```bash
     sudo resize2fs /dev/vdb1
     ```

     Where `dev/vdb1` is the partition name.

     Result:

     ```text
     Resizing the filesystem on /dev/vdb1 to 16776955 (4k) blocks.
     The filesystem on /dev/vdb1 is now 16776955 (4k) blocks long.
     ```

  1. If you unmounted the partition to perform a file system check, remount it:

     ```bash
     sudo mount /dev/vdb1 /data
     ```

  1. Make sure the partition size has increased:

     ```bash
     lsblk
     ```

     Result:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```

- xfs

  1. [Connect](../../operations/vm-connect/ssh.md) to the VM over SSH:

     ```bash
     ssh <username>@<VM_public_IP_address>
     ```

  1. See the disks attached to the VM:

     ```bash
     lsblk
     ```

     Result:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vda    252:0    0  25G  0 disk
     ├─vda1 252:1    0   1M  0 part
     └─vda2 252:2    0  25G  0 part /
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  32G  0 part /data
     ```

     Disk partitions are listed under `NAME`. Partition mount points are displayed under `MOUNTPOINTS`.

  1. Run this command:

     ```bash
     sudo growpart /dev/vdb 1
     ```

     Where:
     * `/dev/vdb`: Device name.
     * `1`: Partition number, which must be separated by a space.

     Result:

     ```text
     CHANGED: partition=1 start=2048 old: size=67106816 end=67108864 new: size=134215647,end=134217695
     ```

  1. Change the file system size:

     ```bash
     sudo xfs_growfs /data -d
     ```

     Where:
     * `/data`: Mount point of the partition whose size you need to increase.
     * `-d`: Parameter for increasing partition size.

     Result:

     ```text
     meta-data=/dev/vdb1              isize=512    agcount=4, agsize=655360 blks
              =                       sectsz=4096  attr=2, projid32bit=1
              =                       crc=1        finobt=1, sparse=1, rmapbt=0
              =                       reflink=1    bigtime=0 inobtcount=0
     data     =                       bsize=4096   blocks=2621440, imaxpct=25
              =                       sunit=0      swidth=0 blks
     naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
     log      =internal log           bsize=4096   blocks=2560, version=2
              =                       sectsz=4096  sunit=1 blks, lazy-count=1
     realtime =none                   extsz=4096   blocks=0, rtextents=0
     data blocks changed from 2621440 to 11796219
     ```

  1. Make sure the partition size has increased:

     ```bash
     lsblk /dev/vdb
     ```

     Result:

     ```text
     NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
     vdb    252:16   0  64G  0 disk
     └─vdb1 252:17   0  64G  0 part /data
     ```

{% endlist %}