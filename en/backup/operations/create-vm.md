# Creating a Linux VM with a connection to {{ backup-name }}

{{ backup-name }} supports backing up [{{ compute-name }} VMs](../../compute/concepts/vm.md) running such Linux OS's as Ubuntu 20.04 or lower and CentOS 7. For more information, see [{#T}](../concepts/vm-connection.md#os).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Image/boot disk selection**, choose Ubuntu 20.04 and lower or CentOS 7.
   1. Specify the VM parameters. For more information, see [Creating a VM from a public Linux image](../../compute/operations/vm-create/create-linux-vm).

      {% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

   1. Under **Backup**, select the {{ backup-name }} connection option for your VM.
   1. Click **Create VM**.

{% endlist %}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan.md) %}

{% include [vm-list](../../_includes/backup/vm-list.md) %}

{% include [agent-installation-failure](../../_includes/backup/agent-installation-failure.md) %}

#### See also {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
