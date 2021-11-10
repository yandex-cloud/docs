# Detaching a disk from a VM

You can detach a disk from either a running or stopped VM.

{% note info %}

You can't detach the boot disk.

{% endnote %}

For a disk to be successfully detached from a running VM, the operating system must be ready to accept commands to detach disks. Before detaching a disk, make sure that the OS is loaded or stop the VM, otherwise the detach disk operation fails. If an error occurs, stop the VM and repeat the operation.

To detach a disk from a VM:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's detach disk command:

      ```
      $ yc compute instance detach-disk --help
      ```

  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the VM `ID` or `NAME` (for example, `first-instance`).

  1. Get a list of disks attached to the VM:

      ```
      $ yc compute instance get --full first-instance
      ```

  1. Choose the `disk_id` of the disk you need (for example, `fhm4aq4hvq5g3nepvt9b`).

  1. Detach the disk:

      ```
      $ yc compute instance detach-disk first-instance \
          --disk-id fhm4aq4hvq5g3nepvt9b
      ```

      If an error occurs, stop the virtual machine:

      ```
      $ yc compute instance stop first-instance
      ```

      Then try to detach the disk again.

  1. If the virtual machine was stopped, restart it:

      ```
      $ yc compute instance start first-instance
      ```

- API

  Use the [detachDisk](../../api-ref/Instance/detachDisk.md) method for the [Instance](../../api-ref/Instance/) resource.

{% endlist %}

