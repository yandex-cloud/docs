---
title: Attaching a file storage to a VM
description: Follow this guide to attach a file storage to a VM.
---

# Attaching a file storage to a VM

{% note warning %}

You can only attach a [file storage](../../concepts/filesystem.md) to [VMs](../../concepts/vm.md) running a Linux-based [OS](../../concepts/filesystem.md#os) with kernel version 5.4 or higher.

To check the kernel version, run `sudo uname -r`.

{% endnote %}

1. If the VM [status](../../concepts/vm-statuses.md) is `RUNNING`, [stop it](../vm-control/vm-stop-and-start.md#stop).
1. Attach a file storage to the VM in {{ compute-name }}:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you created the file storage.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
     1. Select the required storage.
     1. Go to the **{{ ui-key.yacloud.compute.nfs.label_attached-instances }}** tab.
     1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.
     1. In the window that opens:
        1. Select the VM.
        1. Specify the device name for accessing the file storage in the VM. Save this name as you will need it when mounting the storage.
        1. Click **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.

   - CLI {#cli}

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     1. View the description of the [CLI](../../../cli/) command to attach a file storage to a VM:

        ```bash
        yc compute instance attach-filesystem --help
        ```

     1. Get a list of file storages in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

        {% include [compute-filesystem-list](../../_includes_service/compute-filesystem-list.md) %}

     1. Get a list of VMs in the default folder:

        ```bash
        yc compute instance list
        ```

        Result:

        ```text
        +----------------------+-------+---------------+---------+--------------+-------------+
        |          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP | INTERNAL IP |
        +----------------------+-------+---------------+---------+--------------+-------------+
        | epdj4upltbiv******** | vm-01 | {{ region-id }}-a | RUNNING | 51.250.**.** | 192.168.*.* |
        | 1pc3088tkv4m******** | vm-02 | {{ region-id }}-a | RUNNING | 84.201.**.** | 192.168.*.* |
        +----------------------+-------+---------------+---------+--------------+-------------+
        ```

     1. Attach a file storage to a VM:

        ```bash
        yc compute instance attach-filesystem \
          --id <VM_ID> \
          --filesystem-id <file_storage_ID> \
          --device-name <device_name>
        ```

        Where:
        * `--id`: VM ID.

          Instead of an ID, you can specify the VM name in the `--name` parameter.

        * `--filesystem-id`: File storage ID.

          Instead of an ID, you can specify the file storage name in the `--filesystem-name` parameter.

        * `--device-name`: Device name for accessing the file storage in the VM. This is an optional parameter.

          By default, the file storage ID is used as the device name.

        Result:

        ```text
        id: epdj4upltbiv********
        folder_id: b1g681qpemb4********
        created_at: "2024-04-29T15:50:19Z"
        name: vm-01
        ...
        filesystems:
        - mode: READ_WRITE
          device_name: attached-filesystem
          filesystem_id: epdtcr9blled********
        ...
        ```

   - {{ TF }} {#tf}

     {% include [terraform-install](../../../_includes/terraform-install.md) %}

     Set the `allow_stopping_for_update` parameter to `true` on your VM, if you have not done it yet.

     To attach a file storage to the VM, add the `filesystem` section with the `filesystem_id` parameter to the VM description (see the example below).
     1. Open the {{ TF }} configuration file and add a fragment with the storage description to the VM description:

        {% cut "Sample storage description in the VM configuration in {{ TF }}" %}

        ```hcl
        ...
        resource "yandex_compute_instance" "vm-1" {
          name        = "test-vm"
          platform_id = "standard-v3"
          zone        = "{{ region-id }}-a"

          filesystem {
            filesystem_id = "fhmaikp755gr********"
          }
        }
        ...
        ```

        {% endcut %}

     1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check whether the storage has been attached to the VM using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc compute instance get <VM_name>
     ```

   - API {#api}

     Use the [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem) gRPC API call.

   {% endlist %}

1. Mount the file storage on the VM:
   1. If you do not know the device name, run this command:

      ```bash
      yc compute instance get <VM_name>
      ```

      Result:

      ```text
      ...
      filesystems:
        - mode: READ_WRITE
          device_name: storagename
          filesystem_id: epdb1jata63j********
      ...
      ```

      Save the value of the `device_name` field under the `filesystems` section. This is the name of the device to mount the file storage on that you will need later.
   1. [Connect](../vm-connect/ssh.md) to the VM over SSH.
   1. Run this command:

      ```bash
      sudo mount -t virtiofs <device_name> <mount_path>
      ```

      Where:
      * `<device_name>`: Value of the `device_name` field you saved before. In the example above, it is `storagename`. Your device name may differ.
      * `<mount_path>`: Folder or disk to mount the file storage to. For example: `/mnt/vfs0`.
   1. Check that the file storage has been mounted:

      ```bash
      df -T
      ```

      Result:

      ```text
      Filesystem        Type         1K-blocks    Used Available Use% Mounted on
      udev              devtmpfs        988600       0    988600   0% /dev
      tmpfs             tmpfs           203524     780    202744   1% /run
      /dev/vda2         ext4          13354932 1909060  10861420  15% /
      tmpfs             tmpfs          1017604       0   1017604   0% /dev/shm
      tmpfs             tmpfs             5120       0      5120   0% /run/lock
      tmpfs             tmpfs          1017604       0   1017604   0% /sys/fs/cgroup
      tmpfs             tmpfs           203520       0    203520   0% /run/user/1000
      storagename       virtiofs      66774660       0  66774660   0% /mnt/vfs0
      ```

   1. To mount the file storage every time the VM is started, add the following string to the `/etc/fstab` file:

      ```text
      <device_name> <mount_path> virtiofs    rw    0   0
      ```