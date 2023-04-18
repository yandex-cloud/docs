# Creating a Linux VM with a connection to {{ backup-name }}

{{ backup-name }} supports backing up [{{ compute-name }} VMs](../../compute/concepts/vm.md) running such Linux OS's as Ubuntu 20.04 or lower and CentOS 7. For more information, see [{#T}](../concepts/vm-connection.md#os).

{% note info %}

You can only connect a Linux VM to {{ backup-name }} when creating it. To connect an existing VM to {{ backup-name }}, [take snapshots](../../compute/operations/disk-control/create-snapshot.md) of the VM's disks and [create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM from the snapshots by selecting the backup option.

{% endnote %}

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

Once the VM changes to the `Running` status, the {{ backup-name }} agent starts to install. This may take a few minutes. After that, you can add your VM to [backup policies](../concepts/policy.md).

#### See also {#see-also}

* [{#T}](connect-vm-windows.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
