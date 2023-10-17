# Connecting a Windows Server VM to {{ backup-name }}

{{ backup-name }} supports backing up [{{ compute-name }} VMs](../../compute/concepts/vm.md) running Windows Server 2019 and 2022. For more information, see [{#T}](../concepts/vm-connection.md#os).

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

To connect a Windows VM to {{ backup-name }}:

1. [Create](../../iam/operations/sa/create.md) a service account with the `backup.editor` [role](../../iam/concepts/access-control/roles.md#backup-editor).
1. [Connect](../../compute/operations/vm-control/vm-update.md) the previously created service account to the VM.
1. If your VM has no public IP address, [attach](../../compute/operations/vm-control/vm-attach-public-ip.md) it.
1. In a security group, [set up](../../vpc/operations/security-group-add-rule.md) [rules for working with {{ backup-name }}](../concepts/vm-connection.md#security-groups).
1. [Connect to the VM via RDP](../../compute/operations/vm-connect/rdp.md).
1. Run Windows PowerShell.
1. Run the following command:

   ```powershell
   . { iwr -useb https://{{ s3-storage-host }}/backup-distributions/agent_installer.ps1 } | iex
   ```

   Result:

   ```text
   ...
   Backup agent installation complete after 190 s!
   ```

After that, you can link your VM to [backup policies](../concepts/policy.md).


#### See also {#see-also}

* [{#T}](create-vm.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)