# Detaching a disk from a VM

You can detach a disk from either a running and stopped VM.


{% note info %}

You cannot detach a boot disk from a VM. You cannot detach a local disk from a VM running on a [dedicated host](../../concepts/dedicated-host.md).

{% endnote %}


For a disk to be successfully detached from a running VM, the operating system must be ready to accept commands to detach disks. Before detaching a disk, make sure that the OS is loaded or stop the VM, otherwise the detach disk operation fails. If an error occurs, stop the VM and try again.

To detach a disk from a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. Next to the disk you need to detach, click ![image](../../../_assets/console-icons/ellipsis.svg), and then click **{{ ui-key.yacloud.compute.disks.button_action-detach }}**.
   1. Click **{{ ui-key.yacloud.compute.disks.popup_detach-disk_button_detach }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's detach disk command:

      ```
      yc compute instance detach-disk --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.

   1. Get a list of disks attached to the VM:

      ```
      yc compute instance get --full first-instance
      ```

   1. Select the right `disk_id`, e.g., `fhm4aq4hvq5g********`.
   1. Detach the disk:

      ```
      yc compute instance detach-disk first-instance \
        --disk-id fhm4aq4hvq5g********
      ```

      If an error occurs, stop the virtual machine:

      ```
      yc compute instance stop first-instance
      ```

      Then try to detach the disk again.

   1. If the virtual machine was stopped, restart it:

      ```
      yc compute instance start first-instance
      ```

- API {#api}

   Use the [detachDisk](../../api-ref/Instance/detachDisk.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/DetachDisk](../../api-ref/grpc/Instance/detachDisk.md) gRPC API call.

{% endlist %}
