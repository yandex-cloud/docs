# Attaching file storage to a VM

1. If a virtual machine has been launched and is running (the `RUNNING` [status](../../concepts/vm-statuses.md)), [stop it](../vm-control/vm-stop-and-start.md#stop).
1. Attach file storage to the VM in {{ compute-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the file store.
      1. Select **{{ compute-name }}**.
      1. On the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **File storage**.
      1. Select the desired storage.
      1. Go to the **Virtual machines** tab.
      1. Click **Attach to VM**.
      1. In the window that opens:

         1. Select the **VM**.
         1. Specify the **Device name** for accessing file storage in the VM.
         1. Click **Attach to VM**.

   - API

     Use the [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem) gRPC API call.

   {% endlist %}

1. Mount file storage to the VM:

   1. [Connect to the VM via SSH](../vm-connect/ssh.md).
   1. Run this command:

      ```bash
      sudo mount -t virtiofs <device name> <mount path>
      ```

   1. To check that your file store is mounted, run the command:

      ```bash
      df -T
      ```

      Result:

      ```
      Filesystem        Type         1K-blocks    Used Available Use% Mounted on
      udev              devtmpfs        988600       0    988600   0% /dev
      tmpfs             tmpfs           203524     780    202744   1% /run
      /dev/vda2         ext4          13354932 1909060  10861420  15% /
      tmpfs             tmpfs          1017604       0   1017604   0% /dev/shm
      tmpfs             tmpfs             5120       0      5120   0% /run/lock
      tmpfs             tmpfs          1017604       0   1017604   0% /sys/fs/cgroup
      tmpfs             tmpfs           203520       0    203520   0% /run/user/1000
      filesystem        virtiofs      66774660       0  66774660   0% /mnt/vfs0
      ```

   1. In order for file storage to be mounted every time the VM is started, add a line to the `/etc/fstab` file in the following format:

      ```
      <device name>  <mount path> virtiofs    rw    0   0
      ```
