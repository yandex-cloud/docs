#### Why cannot I add a VM or {{ baremetal-name }} server to {{ backup-name }}? {#cannot-add-vm}

Make sure that:

{% list tabs group=backup_resource_type %}

- VM {#vm}

  * The VM is created from a [supported image](../../backup/concepts/vm-connection/compute.md#os) or (if the {{ backup-name }} agent is installed manually) [{{ backup-name }}](../../backup/concepts/vm-connection/compute.md#self-install) supports the VM's operating system.
  * The service account linked to the VM has the `backup.editor` [role](../../backup/security/index.md#backup-editor).
  * The [security group](../../backup/concepts/vm-connection/compute.md#vm-network-access) is [correctly](../../vpc/concepts/security-groups.md) configured for the VM.

  For more information, see [Connecting {{ compute-name }} virtual machines to {{ backup-name }}](../../backup/concepts/vm-connection/compute.md).

- {{ baremetal-name }} server {#baremetal-server}

  * The server runs a [supported operating system](../../backup/concepts/vm-connection/baremetal.md#self-install).
  * The service account whose IAM token is used to [install](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install) the {{ backup-name }} agent has the `backup.editor` [role](../../backup/security/index.md#backup-editor).
  * The server has a [public IP address assigned](../../backup/concepts/vm-connection/baremetal.md#provide-access).

  For more information, see [Connecting a {{ baremetal-name }} server to {{ backup-name }}](../../backup/operations/backup-baremetal/backup-baremetal.md).

{% endlist %}

#### How do I reconnect a VM or {{ baremetal-name }} server deleted from {{ backup-name }}? {#reconnect-deleted-vm}

If you have [deleted a VM](../../backup/operations/delete-vm.md) or {{ baremetal-name }} server from {{ backup-name }} and want to reconnect it to the service, follow these guides:

{% list tabs group=backup_resource_type %}

- VM {#vm}

  * [Connecting a Linux VM](../../backup/operations/connect-vm-linux.md)
  * [Connecting a Windows VM](../../backup/operations/connect-vm-windows.md)

- {{ baremetal-name }} server {#baremetal-server}

  * Reinstall the {{ backup-name }} agent according to [this guide](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install).

{% endlist %}

#### How do I reconnect a VM or {{ baremetal-name }} server to {{ backup-name }} after restoring its backup to another VM or server? {#how-to-renew-connection}

{% list tabs group=backup_resource_type %}

- VM {#vm}

  A virtual machine becomes outdated after [its backup is restored to another VM](../../backup/operations/backup-vm/non-native-recovery.md). To avoid conflicts between the source and target VMs when performing a backup, [refresh](../../backup/operations/refresh-connection.md) the outdated VM's connection to {{ backup-name }}.

- {{ baremetal-name }} server {#baremetal-server}

  A {{ baremetal-name }} server becomes outdated after its backup is restored to another server. To avoid conflicts between the source and target {{ baremetal-name }} servers when performing a backup, [refresh](../../backup/operations/backup-baremetal/refresh-connection.md) the outdated server's connection to {{ backup-name }}.

{% endlist %}

#### Why are old backups not deleted after reconnecting a VM to {{ backup-name }}? {#old-backups-not-deleted}

{% include [old-backup](../../_includes/backup/old-backups.md) %}

#### I get an error when trying to restore a VM or {{ baremetal-name }} server from a backup {#recovery-error}

Error message:

```text
Not all of the items are mapped. Please, check your goal instance and its volumes.
```

The error occurs because {{ backup-name }} cannot find a suitably sized disk on the target VM.

The boot disk of the target VM or {{ baremetal-name }} server must be at least the size of that of the source VM.

Check the target VM disks and [increase](../../compute/operations/disk-control/update.md#change-disk-size) their size if needed. You can also [use another VM](../../backup/operations/backup-vm/non-native-recovery.md) or {{ baremetal-name }} server with suitable parameters.

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
* [{{ backup-name }} supports](../../backup/concepts/vm-connection/compute.md#os) the VM operating system.
* The service account linked to the VM has the `backup.editor` [role](../../backup/security/index.md#backup-editor).
* [Network access for your VM](../../backup/concepts/vm-connection/compute.md#vm-network-access) is enabled.
* The PowerShell execution policies allow scripts. If not, allow scripts and restart PowerShell. For more information, see [this Microsoft guide](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

#### Authorization error when installing a {{ backup-name }} agent on a Linux VM {#install-auth-error}

Error message:

```text
Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization
```

The error occurs if the VM has no service account or if the account was configured incorrectly.

Make sure that:
* You have a service account [associated](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) with the VM.
* Your service account has the `backup.editor` [role](../../backup/security/index.md#backup-editor).

#### How do I update the {{ backup-name }} agent on a VM? {#update-backup-agent}

Use this guide: [Updating the {{ backup-name }} agent on a VM](../../backup/operations/update-backup-agent.md).

#### Why are backups disabled after the OS update? {#kernel-update-consequences}

{% include [update-kernel-headers-description](../../_includes/backup/operations/update-kernel-headers-description.md) %}

For information on how to upgrade the Linux kernel header version, see [{#T}](../../backup/operations/backup-baremetal/restore-agent.md).

#### Why does it take so long to create a backup? {#long-creation}

The possible causes may include the following:
* High compression ratio of the backup.

  The [backup policy specification](../../backup/concepts/policy.md#specification) describes the following compression levels:
  * `COMPRESSION_UNSPECIFIED`: Not specified.
  * `NORMAL`: Standard compression ratio.
  * `HIGH`: High compression ratio.
  * `MAX`: Maximum compression ratio.
  * `OFF`: Disabled.

  As compression ratio increases, the algorithm spends more and more computing resources to find redundancies in data to pack it even denser. Using high compression levels (`HIGH`, `MAX`) increases backup generation time.

* Changed Block Tracking not used.

  In {{ backup-name }}, this logic is set up via the `cbt` parameter in the [backup policy specification](../../backup/concepts/policy.md#specification). It has several possible values:
  * `CHANGED_BLOCK_TRACKING_UNSPECIFIED`: Unspecified (default).
  * `USE_IF_ENABLED`: Use if the feature is enabled.
  * `ENABLE_AND_USE`: Enable and use explicitly.
  * `DO_NOT_USE`: Do not use.

  To speed up the backup generation process, we recommend the `ENABLE_AND_USE` option.

  As such, the `cbt` setting sets the strategy; the actual tracking of changes on the disk is set up via another parameter: `fastBackupEnabled`.

* `fastBackupEnabled` set to `false`.

  This parameter decides exactly how {{ backup-name }} will understand that the file has changed.
  * If `fastBackupEnabled: true`, the changes are detected based on file size and timestamp. This is exactly what _fast_ backup is all about.
  * If `fastBackupEnabled: false`, {{ backup-name }} will compare the file's entire content against the backup to figure out the changes.

* Large size of the backed up disk.

#### Creating incremental backups of a VM or {{ baremetal-name }} server is taking longer than usual {#av-interaction}

Antivirus activity may affect the time required to create [incremental backups](../../backup/concepts/backup.md#types) under a policy with the fast backup [option](../../backup/concepts/policy.md#specification) enabled (`fastBackupEnabled`). See details in [{#T}](../../backup/concepts/av-interaction.md).

#### Out-Of-Memory Killer (OOM Killer) kills the {{ backup-name }} agent process in Linux {#oom-solution}

{% include [agent-ram-usage-paragraph](../../_includes/backup/operations/agent-ram-usage-paragraph.md) %}

{% include [agent-ram-usage-second-paragraph](../../_includes/backup/operations/agent-ram-usage-second-paragraph.md) %}

{% include [agent-ram-usage-notice](../../_includes/backup/operations/agent-ram-usage-notice.md) %}

#### How do I restore a VM or {{ baremetal-name }} server with LVM from a backup? {#restore-lvm}

{% include [lvm-restoration-notice](../../_includes/backup/lvm-restoration-notice.md) %}

#### Issues installing the {{ backup-name }} agent on a VM with low computing resources {#low-resources-installation}

{% include [cloud-backup-resources-note](../../_includes/backup/cloud-backup-resources-note.md) %}

#### Why does the console give {{ backup-name }} backup sizes not matching the actual backup sizes? {#backup-size}

The backup size difference is due to {{ backup-name }}'s internal design: the calculation is based on archives, not the backups themselves.

You can view the size of each archive in the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) using the `yc backup backup list-archives` command.

If you add up the sizes of each archive, you will get the value you see in the management console.

{% note info %}

The change in total size is not immediately visible after you delete your backups: it takes a while for internal changes to take effect in the archive.

{% endnote %}

#### If I delete a VM, will its backups remain? {#backup-after-delete-vm}

Yes. Deleting a VM does not delete its backups. The latter are linked to the [backup policy](../../backup/concepts/policy.md), not the VM.

#### Code 400 error when installing the agent {#agent-installation-error}

Complete error message: 

```text
Cloud backup service request for registering agent failed: unexpected status code: url=<https://backup.api.cloud.yandex.net/backup/agent/v1/api/registerAgent>, status=400
```

The agent may already be linked to another VM created from an image with the agent installed.

To fix the issue, try [reconnecting the virtual machine to {{ backup-name }}](../../backup/operations/refresh-connection.md). 

If reconnection does not help, [submit a support ticket]({{ link-console-support }}).

#### How do I view {{ backup-name }} activity logs? {#get-logs}

In Linux kernel-based systems, e.g., Ubuntu, you can find {{ backup-name }} log files at the following paths:
* `/var/log/baas-agent-installer/log.txt`
* `/var/log/trueimage-setup.log`
* `/var/log/Acronis`

In Windows systems, the {{ backup-name }} log is in the `%AppData%\BackupAgentInstaller*.log` file.

You can also generate a local system report:
* Linux: Run a bash script with `root` privileges to generate a report: `/usr/lib/Acronis/BackupAndRecovery/systeminfo`.
* Windows: Run `C:\Program Files\Common Files\Acronis\AdvReport\systeminfo.exe`.

For more on this, see the relevant [backup provider guide](https://kb.cyberprotect.ru/articles/sysinfo).

#### `Unable to install agent` error during installation {#unable-to-install-agent}

More often than not, this error occurs at the `snapapi26` kernel module building stage. It takes place when the installed module's version does not match your VM kernel version.

To check the agent's status to see that it has really not registered in {{ backup-name }}, run the following command in the [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

```bash
yc backup vm get <VM_ID> --folder-id <folder_ID>
```

If the agent is not installed or registered, the command will return an error or an empty response.

To resolve this issue:
1. Check the installation logs. Connect to the VM via SSH and examine the following files. Most often, the root of the problem lies exactly there:

    ```text
    /var/log/baas-agent-installer/log.txt
    /var/log/trueimage-setup.log (this is the file where you can usually see snapapi26 build errors)
    /var/log/Acronis
    ```

1. Build the kernel module manually. If you see errors related to the `snapapi26` module in the logs, you should build it yourself for the current kernel version. A detailed manual build guide is available in the [backup provider's knowledge base](https://kb.cyberprotect.ru/articles/snapapi-manual).

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a request, provide the following information:
* ID of the VM.
* Log files listed above.

#### {{ backup-name }} VM stuck in the `Registering` status for a long time {#vm-long-register}

Most likely, there is no service account attached to the virtual machine. For {{ backup-name }} to operate correctly, you need to [attach](../../backup/operations/connect-vm-linux.md#create-sa) a service account with the `backup.user` minimum role to the virtual machine. 

After you add a service account, you should manually [install the agent on the VM](../../backup/operations/connect-vm-linux.md#connect-vm).
