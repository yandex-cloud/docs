# Deleting a VM

{% note warning %}

Deleting a VM is an operation that cannot be canceled or reversed. You cannot restore a deleted VM.

{% endnote %}

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

If you have disks attached to your VM, the disks will be detached when you delete the VM. The disk data will be preserved, and you will be able to attach these disks to another VM when needed.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Select the VM → click ![image](../../../_assets/options.svg) → select **Delete**.

      To do this with multiple VMs, select the VMs you need to delete from the list → click **Delete** at the bottom of the screen.

   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI instance delete command below:

      ```bash
      yc compute instance delete --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Delete the VM:

      ```bash
      yc compute instance delete first-instance
      ```

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created an instance using {{ TF }}, you can delete it:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete resources using the command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and instances.

      {% endnote %}

   1. Type the word `yes`, then press **Enter**.

{% endlist %}