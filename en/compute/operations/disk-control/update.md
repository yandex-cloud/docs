# Updating a disk

After you create a disk, you can:

* [Change its name and description](#change-name).

* [Increase the disk size](#change-disk-size) (available for stopped VMs only).

## Changing the name and description of a disk {#change-disk-name}

{% list tabs %}

- Management console

  To change the name and description of a disk:

  1. Select the folder that the disk belongs to.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Disks** tab.
  1. Click ![image](../../../_assets/dots.svg) next to the disk and select **Edit**.
  1. Change the name and description of the disk.
  1. Click **Save changes**.

  {{ compute-short-name }} will start the operation to change the disk.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To change the name and description of a disk:

  1. View the description of the CLI's disk change command:

      ```
      $ yc compute disk update --help
      ```

  1. Request a list of available disks:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select the `ID` or `NAME` of the required disk (for example, `first-disk`).

  1. Specify the name and description in the disk change command:

      ```
      $ yc compute disk update first-disk \
          --new-name updated-disk \
          --description "Updated disk via CLI"
      ```

      {{ compute-short-name }} will start the operation to change the disk.

- API

  You can change the name and description of the disk using the [update](../../api-ref/Disk/update.md) API method.

  To request the list of available disks, use the [list](../../api-ref/Disk/list.md) method.

{% endlist %}

## Increasing the disk size {#change-disk-size}

Disk size can be increased only if the disk is not connected to a running VM. To increase disk size, make sure that the VM is stopped.

{% list tabs %}

- Management console

  To increase the disk size:

  1. Select the folder that the disk belongs to.

  1. Select **{{ compute-full-name }}**.

  1. On the **Virtual machine** page, stop the VM (see [{#T}](../vm-control/vm-stop-and-start.md#stop)).

  1. Wait until the VM's status changes to `STOPPED`.

  1. Go to the **Disks** tab.

  1. Click ![image](../../../_assets/dots.svg) next to the disk and select **Edit**.

  1. Increase the disk size.

  1. Click **Save changes**.

      {{ compute-short-name }} will start the operation to change the disk size.

  1. When the operation finishes, go back to the **Virtual machines** page and restart the VM.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To increase the disk size:

  1. View the description of the CLI's disk change command:

      ```
      $ yc compute disk update --help
      ```

  1. Request a list of available disks:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Stop the VM with the disk you want to update. To do this, select the `ID` of the VM:

      ```
      $ yc compute instance stop --id a7lcvu28njbhnkcteb5n
      ```

  1. Select the `ID` or `NAME` of the required disk (for example, `first-disk`).

  1. Specify the size (for example, 32 GB) in the disk change command:

      ```
      $ yc compute disk update first-disk \
          --size 32
      ```

      {{ compute-short-name }} will start the operation to change the disk size.

  1. Start the VM:

      ```
      $ yc compute instance start --id a7lcvu28njbhnkcteb5n
      ```

- API

  You can change the disk size using the [update](../../api-ref/Disk/update.md) API method.

  To request the list of available disks, use the [list](../../api-ref/Disk/list.md) method.

  To stop or start the VM, use the [stop](../../api-ref/Instance/stop.md) and [start](../../api-ref/Instance/get.md) methods for the [Instance](../../api-ref/Instance/) resource.

{% endlist %}
