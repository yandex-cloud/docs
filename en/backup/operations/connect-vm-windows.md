# Connecting a Windows Server VM to {{ backup-name }}

{{ backup-name }} supports backing up [{{ compute-name }} VMs](../../compute/concepts/vm.md) running Windows Server 2019 and 2022. For more information, see [{#T}](../concepts/vm-connection.md#os).

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

To connect a Windows VM to {{ backup-name }}:

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