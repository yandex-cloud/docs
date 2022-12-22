# Creating a VM with a connection to {{ backup-name }}

{% note info %}

You can only connect a VM to {{ backup-name }} when creating it. To connect an existing VM to {{ backup-name }}, [take](../../compute/operations/disk-control/create-snapshot.md) snapshots of the VM's disks and [create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM from the snapshots by selecting the backup option. The Ubuntu versions 20.04 and below are supported.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Image/boot disk selection**, choose Ubuntu version 20.04 or lower.
   1. Specify the VM parameters. For more information, see [Creating a VM from a public Linux image](../../compute/operations/vm-create/create-linux-vm).
   1. Under **Backup**, select the {{ backup-name }} connection option for your VM.
   1. Under **Access**, select the service account with the `backup.editor` [role](../security/index.md#backup-editor). If you don't have a service account:
      1. Click **Create new**.
      1. In the window that opens, enter a name for the service account.
      1. In the **Roles in folder** field, click ![plus](../../_assets/plus-sign.svg) and select `backup.editor`.
      1. Click **Create**.
   1. Click **Create VM**.

{% endlist %}

Once the VM changes to the `Running` status, the {{ backup-name }} agent starts to install. This may take a few minutes. After that, the VM can be added to [backup policies](../concepts/policy.md).

#### See also {#see-also}

* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
