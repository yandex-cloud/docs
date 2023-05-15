# Detaching file storage from a VM

1. Dismount your [file store](../../concepts/filesystem.md) from the [VM](../../concepts/vm.md):
   1. [Connect](../vm-connect/ssh.md) to the VM via SSH.
   1. If you added a line to the `/etc/fstab` file for automatically mounting file storage to the VM at startup (for example, when [attaching storage to a VM](attach-to-vm.md)), delete the line.
   1. Run this command:

      ```bash
      sudo umount <mount path>
      ```

   1. To check that your file store has been dismounted, run the command:

      ```bash
      df -T
      ```

      As a result, there should be no `virtiofs`-type file system corresponding to file storage:

      ```text
      Filesystem        Type         1K-blocks    Used Available Use% Mounted on
      udev              devtmpfs        988600       0    988600   0% /dev
      tmpfs             tmpfs           203524     780    202744   1% /run
      /dev/vda2         ext4          13354932 1909060  10861420  15% /
      tmpfs             tmpfs          1017604       0   1017604   0% /dev/shm
      tmpfs             tmpfs             5120       0      5120   0% /run/lock
      tmpfs             tmpfs          1017604       0   1017604   0% /sys/fs/cgroup
      tmpfs             tmpfs           203520       0    203520   0% /run/user/1000
      ```

1. [Stop the VM](../vm-control/vm-stop-and-start.md).
1. Detach file storage from the VM in {{ compute-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your file store is located.
      1. Select **{{ compute-name }}**.
      1. On the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **File storage**.
      1. Select the desired storage.
      1. Go to the **Virtual machines** tab.
      1. In the row with the desired VM, click ![image](../../../_assets/options-grey.svg) and select **Detach file storage**.
      1. In the window that opens, confirm the detach operation.

   - API

      Use the [detachFilesystem](../../api-ref/Instance/detachFilesystem.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/DetachFilesystem](../../api-ref/grpc/instance_service.md#DetachFilesystem) gRPC API call.

   {% endlist %}