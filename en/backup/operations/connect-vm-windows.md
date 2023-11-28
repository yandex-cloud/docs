---
title: "How to connect a Windows Server VM to {{ backup-full-name }}"
description: "Follow this guide to connect a Windows Server VM to {{ backup-name }}."
---

# Connecting a Windows Server VM to {{ backup-name }}

You can back up {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Windows-based operating systems](../concepts/vm-connection.md#windows).

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

To connect a Windows VM to {{ backup-name }}:

1. [Create](../../iam/operations/sa/create.md) a service account with the `backup.editor` [role](../../iam/concepts/access-control/roles.md#backup-editor).
1. [Connect](../../compute/operations/vm-control/vm-update.md) the previously created service account to the VM.
1. [Set up](../concepts/vm-connection.md#vm-network-access) network access for your VM.
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