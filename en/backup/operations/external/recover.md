---
title: How to recover an external resource from a backup
description: Follow this guide to recover a VM or server located outside of your {{ yandex-cloud }} infrastructure from a backup.
---

# Recovering an external VM or server from a backup


{% note info %}

{% include [vm-and-bms-backup-incompatibility](../../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% endnote %}

{% include [avoid-errors-when-restoring-from-backup.md](../../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

To recover a VM or server located in your infrastructure or a third-party provider's infrastructure from a backup:

1. [Start the recovery process on the {{ yandex-cloud }} side](#initiate-recovery).
1. [Make sure you have network access on the resource side](#validate-access).

## Start the recovery process on the {{ yandex-cloud }} side {#initiate-recovery}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the backup.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Depending on the type of resource you want to recover, open the **{{ ui-key.yacloud.backup.label_external-vm-instances }}** or **{{ ui-key.yacloud.backup.label_external-server-instances }}** tab.
  1. In the line with the backup you want to use to recover an external VM or server, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/clock-arrow-rotate-left.svg) **{{ ui-key.yacloud.backup.action_recovery }}**.
  1. In the **{{ ui-key.yacloud.backup.title_recovery-dialog_external }}** window that opens, select the external resource the backup will be recovered to in the **{{ ui-key.yacloud.backup.field_recover-to-resource }}** field.
  1. Click **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to restore a [resource](../../concepts/index.md#protected-resources) from a backup:

      ```bash
      yc backup backups recover --help
      ```

  1. Get the ID of the backup:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Get the ID of the resource to restore:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Recover a VM or server from a backup:

      ```bash
      yc backup backups recover \
        --source-backup-id <backup_ID> \
        --destination-instance-id <external_resource_ID>
      ```

      Where:

      * `--source-backup-id`: ID of the backup to recover the VM or server from.
      * `--destination-instance-id`: ID of the VM or server to recover the backup to.

      For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/backup/recover.md).

- API {#api}

  Use the [startRecovery](../../backup/api-ref/Backup/startRecovery.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/StartRecovery](../../backup/api-ref/grpc/Backup/startRecovery.md) gRPC API call.

{% endlist %}

This will start recovery of the external resource from a backup.

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

## Make sure you have network access on the resource side {#validate-access}

To be recovered from {{ backup-full-name }} backups, external VMs and servers need to have internet access. During the process of recovering an external resource from a backup, it will be restarted and the `Recovery Bootable Media` tool will be started on it. Make sure your VM or server has internet access in this mode.

If necessary, configure network access in the `Recovery Bootable Media` tool. Proceed as follows:

* In the top menu, click **Tools** and, depending on the interface you are using, select `Configure network` or `Wi-Fi settings`.
* In the window that opens, configure the settings and make sure you have an internet connection.

#### Useful links {#see-also}

* [{#T}](../../concepts/vm-connection/external-resources.md)
* [{#T}](./connect.md)
* [{#T}](../policy-vm/attach-and-detach-vm.md)
* [{#T}](../backup-vm/create.md)