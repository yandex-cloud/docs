# Troubleshooting in {{ backup-name }}

This section describes typical problems you may encounter while using {{ backup-name }} and gives troubleshooting recommendations.

#### Why cannot I add a VM to {{ backup-name }}? {#cannot-add-vm}

Make sure that:

* [{{ backup-name }} supports](../../backup/concepts/vm-connection.md#os) the VM operating system.
* Service account linked to your VM has the `backup.editor` [role](../../backup/security/index.md#backup-editor) assigned.
* [Security group](../../vpc/concepts/security-groups.md) is [correctly](../../backup/concepts/vm-connection.md#vm-network-access) configured for your VM.

For more information, see [Connecting Compute Cloud VM instances to {{ backup-name }}](../../backup/concepts/vm-connection.md).

#### How can I reconnect a VM to {{ backup-name }} after restoring its backup to another VM? {#how-to-renew-connection}

A virtual machine becomes outdated after [restoring its backup to another VM](../../backup/operations/backup-vm/non-native-recovery.md). To avoid conflicts between the source and target VMs when making backups, [refresh](../../backup/operations/refresh-connection.md) the connection of the outdated VM to {{ backup-name }}.

#### An error occurs when trying to restore a VM from a backup {#recovery-error}

Error message:

```text
Not all of the items are mapped. Please, check your target instance and its volumes.
```

The error occurs because {{ backup-name }} cannot find a disk on the target VM that matches the size criterion.

The boot disk size of the target VM must be at least equal to that of the source VM.

Check the disks on the target VM and [increase](../../compute/operations/disk-control/update.md#change-disk-size) their size as needed. You can also [use another VM](../../backup/operations/backup-vm/non-native-recovery.md) with appropriate parameters.

#### Error when connecting to a Windows VM {#windows-connection-issue}

Error message:

```text
Fetching agent id from config
Iteration 0: The term 'acropsh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Make sure that:

* [{{ backup-name }} supports](../../backup/concepts/vm-connection.md#os) the VM operating system.
* Service account linked to your VM has the `backup.editor` [role](../../backup/security/index.md#backup-editor) assigned.
* [Network access for your VM](../../backup/concepts/vm-connection.md#vm-network-access) is enabled.
* The PowerShell execution policies allow scripts. If they do not, allow scripts and restart PowerShell. For more information, see the [Microsoft documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).