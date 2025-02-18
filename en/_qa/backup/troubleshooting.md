# Troubleshooting in {{ backup-name }}

This section describes typical problems you may encounter while using {{ backup-name }} and gives troubleshooting recommendations.

{% include [baremetal-note](../../_includes/backup/baremetal-note.md) %}

#### Why cannot I add a VM or {{ baremetal-full-name }} server to {{ backup-name }}? {#cannot-add-vm}

Make sure that:

{% list tabs group=backup_resource_type %}

- VM instance {#vm}

  * The VM is created from a [supported image](../../backup/concepts/vm-connection.md#os) or (if the {{ backup-name }} agent is installed manually) [{{ backup-name }} supports](../../backup/concepts/vm-connection.md#self-install) the VM's operating system.
  * Service account linked to the VM has the `backup.editor` [role](../../backup/security/index.md#backup-editor).
  * [Security group](../../vpc/concepts/security-groups.md) is [correctly](../../backup/concepts/vm-connection.md#vm-network-access) configured for the VM.

  For more information, see [Connecting Compute Cloud VM instances to {{ backup-name }}](../../backup/concepts/vm-connection.md).

- {{ baremetal-name }} server {#baremetal-server}

  * The server runs a [supported operating system](../../backup/concepts/vm-connection.md#self-install).
  * The service account whose IAM token is used to [install](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install) the {{ backup-name }} agent has the `backup.editor` [role](../../backup/security/index.md#backup-editor).
  * The server has a [public IP address assigned](../../backup/concepts/vm-connection.md#provide-access).

  For more information, see [Connecting a {{ baremetal-name }} server to {{ backup-name }}](../../backup/operations/backup-baremetal/backup-baremetal.md).

{% endlist %}

#### How do I reconnect a VM or {{ baremetal-name }} server deleted from {{ backup-name }}? {#reconnect-deleted-vm}

If you have [deleted a VM](../../backup/operations/delete-vm.md) or {{ baremetal-name }} server from {{ backup-name }} and want to reconnect it to the service, follow this guide:

{% list tabs group=backup_resource_type %}

- VM instance {#vm}

  * [Connecting a Linux VM](../../backup/operations/connect-vm-linux.md)
  * [Connecting a Windows VM](../../backup/operations/connect-vm-windows.md)

- {{ baremetal-name }} server {#baremetal-server}

  * Reinstall the {{ backup-name }} agent according to [this guide](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install).

{% endlist %}

#### How do I reconnect a VM or {{ baremetal-name }} server to {{ backup-name }} after restoring its backup to another VM or server? {#how-to-renew-connection}

{% list tabs group=backup_resource_type %}

- VM instance {#vm}

  A virtual machine becomes outdated after [its backup is restored to another VM](../../backup/operations/backup-vm/non-native-recovery.md). To avoid conflicts between the source and target VMs when performing a backup, [refresh](../../backup/operations/refresh-connection.md) the outdated VM's connection to {{ backup-name }}.

- {{ baremetal-name }} server {#baremetal-server}

  A {{ baremetal-name }} server becomes outdated after its backup is restored to another server. To avoid conflicts between the original and target {{ baremetal-name }} servers when performing a backup, [refresh](../../backup/operations/backup-baremetal/refresh-connection.md) the outdated server's connection to {{ backup-name }}.

{% endlist %}

#### I get an error when trying to restore a VM or {{ baremetal-name }} server from a backup {#recovery-error}

Error message:

```text
Not all of the items are mapped. Please, check your goal instance and its volumes.
```

The error occurs because {{ backup-name }} cannot find a suitably sized disk on the target VM.

The boot disk of the target VM or {{ baremetal-name }} server must be at least the size of that of the source VM.

Check the target VM disks and [increase](../../compute/operations/disk-control/update.md#change-disk-size) their size as needed. You can also [use another VM](../../backup/operations/backup-vm/non-native-recovery.md) or {{ baremetal-name }} server with suitable parameters.

{% note info %}

{% include [avoid-errors-when-restoring-from-backup.md](../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% endnote %}

#### Error when connecting to a Windows VM {#windows-connection-issue}

Error message:

```text
Fetching agent id from config
Iteration 0: The term 'acropsh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Make sure that:

* [{{ backup-name }} supports](../../backup/concepts/vm-connection.md#os) the VM operating system.
* Service account linked to the VM has the `backup.editor` [role](../../backup/security/index.md#backup-editor).
* [Network access for your VM](../../backup/concepts/vm-connection.md#vm-network-access) is enabled.
* The PowerShell execution policies allow scripts. If they do not, allow scripts and restart PowerShell. For more information, see the [Microsoft documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

#### How do I update the {{ backup-name }} agent on a VM? {#update-backup-agent}

See this guide: [Updating the {{ backup-name }} agent on a VM](../../backup/operations/update-backup-agent.md).