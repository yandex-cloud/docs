# Attaching file storage to a VM

1. If the [VM](../../concepts/vm.md) is started and running (its [status](../../concepts/vm-statuses.md) is `RUNNING`), [stop it](../vm-control/vm-stop-and-start.md#stop).
1. Attach [file storage](../../concepts/filesystem.md) to the VM in {{ compute-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you created the file store.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
      1. Select the desired storage.
      1. Go to the **{{ ui-key.yacloud.compute.nfs.label_attached-instances }}** tab.
      1. Click ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.
      1. In the window that opens:
         1. Select the VM.
         1. Specify the device name for accessing file storage in the VM.
         1. Click **{{ ui-key.yacloud.compute.nfs.button_attach-instance-to-the-filesystem }}**.

   - {{ TF }}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      Set the `allow_stopping_for_update` parameter to `true` on your VM, if you have not done it yet.

      To attach file storage to the VM, add the `filesystem` section with the `filesystem_id` parameter to the VM description (see the example below).

      1. Open the {{ TF }} configuration file and add a fragment with the storage description to the VM description:

         {% cut "Sample storage description in the VM configuration in {{ TF }}" %}

         ```hcl
         ...
         resource "yandex_compute_instance" "vm-1" {
           name        = "test-vm"
           platform_id = "standard-v3"
           zone        = "{{ region-id }}-a"

           filesystem {
             filesystem_id = "fhmaikp755grp4mlvvem"
           }
         ...
         ```

         {% endcut %}

      1. Apply the changes:

         {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify that the storage has been added to the VM using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc compute instance get <VM_name>
      ```

   - API

     Use the [attachFilesystem](../../api-ref/Instance/attachFilesystem.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/AttachFilesystem](../../api-ref/grpc/instance_service.md#AttachFilesystem) gRPC API call.

   {% endlist %}

1. Mount file storage to the VM:
   1. [Connect](../vm-connect/ssh.md) to the VM via SSH.
   1. Run this command:

      ```bash
      sudo mount -t virtiofs <device_name> <mount_path>
      ```

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
      filesystem        virtiofs      66774660       0  66774660   0% /mnt/vfs0
      ```

   1. In order for file storage to be mounted every time the VM is started, add a line to the `/etc/fstab` file in the following format:

      ```
      <device_name>  <mount_path> virtiofs    rw    0   0
      ```
