---
title: How to restore your VM or {{ baremetal-name }} server from a backup
description: Use this guide to restore a VM or {{ baremetal-full-name }} server from a backup.
---

# Restoring a VM or {{ baremetal-full-name }} server from a backup

{% include [vm-and-bms-backup-incompatibility](../../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% include [avoid-errors-when-restoring-from-backup.md](../../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% note tip %}

If the current VM is down, [create](../#connect-vm) a new one with a connection to {{ backup-name }} and [restore](non-native-recovery.md) a backup to it. To restore from a backup, the new VM must be in `Running` [status](../../../compute/concepts/vm-statuses.md#list-of-statuses).

{% endnote %}

To restore a VM or {{ baremetal-name }} server from a backup:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Depending on what resource you want to recover from the backup, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. In the line with the backup to restore the VM or {{ baremetal-name }} server from, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_recovery }}** or **{{ ui-key.yacloud.backup.action_bms-recovery }}**, respectively.
  1. In the window that opens, select the VM or {{ baremetal-name }} server you had created the backup from. In the list, this VM or server will be labeled `({{ ui-key.yacloud.backup.context_current-vm }})` or `({{ ui-key.yacloud.backup.context_current-bms }})`, respectively.
  1. Click **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to restore a VM or {{ baremetal-name }} server from a backup:

      ```bash
      yc backup backups recover --help
      ```

  1. Get the ID of the appropriate backup:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Get the ID of the VM to restore:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Restore the VM or {{ baremetal-name }} server from the backup:

      ```bash
      yc backup backups recover \
        --source-backup-id <backup_ID> \
        --destination-instance-id <VM_or_{{ baremetal-name }}_server_ID>
      ```

      Where:

      * `--source-backup-id`: ID of the backup to restore the VM or {{ baremetal-name }} server from.
      * `--destination-instance-id`: ID of the VM or {{ baremetal-name }} server to restore the backup to.

      Result:

      ```text
      ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
      ```

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/backup/recover.md).

- API {#api}

  Use the [startRecovery](../../backup/api-ref/Backup/startRecovery.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/StartRecovery](../../backup/api-ref/grpc/Backup/startRecovery.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](non-native-recovery.md)
