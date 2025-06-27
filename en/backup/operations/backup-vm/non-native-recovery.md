---
title: How to restore a VM or {{ baremetal-name }} server from a backup of another VM or {{ baremetal-name }} server
description: Use this guide to restore a VM or {{ baremetal-full-name }} server from a backup of another VM or {{ baremetal-name }} server.
---

# Restoring a VM or {{ baremetal-name }} server from a backup of another VM or {{ baremetal-name }} server

{% include [vm-and-bms-backup-incompatibility](../../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

If a folder contains multiple VMs or {{ baremetal-name }} servers connected to {{ backup-name }}, you can restore a VM or {{ baremetal-name }} server from a backup of another VM or {{ baremetal-name }} server, respectively. You may need this, for example, if the source VM or {{ baremetal-name }} server is down.

{% include [avoid-errors-when-restoring-from-backup.md](../../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% note info %}

The operating system of the target VM or {{ baremetal-name }} server must be the same as that of the VM or {{ baremetal-name }} server the backup was created from. The boot disk of the target VM or {{ baremetal-name }} server must be at least the size of the boot disk of the source VM or {{ baremetal-name }} server. The target VM or {{ baremetal-name }} server [status](../../../compute/concepts/vm-statuses.md#list-of-statuses) must be `Running`.

{% endnote %}

To restore a VM or {{ baremetal-name }} server from a backup of another VM or {{ baremetal-name }} server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Depending on the resource you want to recover from the backup, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. In the line with the backup to restore the VM or {{ baremetal-name }} server from, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_recovery }}** or **{{ ui-key.yacloud.backup.action_bms-recovery }}**, respectively. In the window that opens:
  
      1. Select the VM or {{ baremetal-name }} server to restore the backup to. If needed, click **{{ ui-key.yacloud.common.create }}** to [create](../index.md#connect-vm) a new VM or to [lease](../../../baremetal/operations/servers/server-lease.md) a new {{ baremetal-name }} server for recovery from a backup.

          If creating a new VM, wait until the VM [connects](../../concepts/vm-connection.md) to {{ backup-name }}. If leasing a new {{ baremetal-name }} server, [connect](../backup-baremetal/backup-baremetal.md) it to {{ backup-name }}. Then click ![refresh](../../../_assets/console-icons/arrow-rotate-right.svg) in the backup recovery window for the new VM or {{ baremetal-name }} server to show up in the list.
  
      1. (Only for VMs) To avoid a conflict between the restored and the source VM, enable **{{ ui-key.yacloud.backup.field_delete-old-vm }}**.

          If this option is not selected, after the recovery the source VM you created the backup from will become outdated. To continue creating backups of this VM, [refresh](../refresh-connection.md) its connection to {{ backup-name }}.
      1. Click **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to restore a VM or {{ baremetal-name }} server from a backup:

     ```bash
     yc backup backups recover --help
     ```

  1. Get the IDs of the target VM to restore the backup to and the source VM whose backup you want to use:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Get the ID of the backup of the source VM or {{ baremetal-name }} server:

     ```bash
     yc backup backups list \
       --instance-id <source_VM_or_{{ baremetal-name }}_server_ID>
     ```

     Where `--instance-id` is the ID of the source VM or {{ baremetal-name }} server whose backup you want to use.

     Result:

     ```text
     +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
     |                  ID                  |              ARCHIVE ID              | COMPUTE INSTANCE ID  |             RESOURCE ID              |      POLICY ID       | TYPE |      DISKS       |  SIZE  |     CREATED AT      |
     +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
     | 9cba836d-869c-41d2-8f25-0dac******** | 8a5b6d59-f7ce-0cb9-6cbf-151c******** | epdhmn8mdqmt******** | 7AF6A532-D1DC-4945-9D0C-E101******** | cdgiqu6ouch3******** | FULL | Disk 1 (13.0 GB) | 1.4 GB | 2023-07-11 05:10:09 |
     | 05e964ca-6a8f-481a-b83e-44c5******** | 8a5b6d59-f7ce-0cb9-6cbf-151c******** | epdhmn8mdqmt******** | 7AF6A532-D1DC-4945-9D0C-E101******** | cdgiqu6ouch3******** | FULL | Disk 1 (15.0 GB) | 1.4 GB | 2023-07-11 05:00:07 |
     +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
     ```

  1. Restore your VM or {{ baremetal-name }} server from the backup:

     ```bash
     yc backup backups recover \
       --source-backup-id <backup_ID> \
       --destination-instance-id <source_VM_or_{{ baremetal-name }}_server_ID>
     ```

     Where:

     * `--source-backup-id`: Backup ID.
     * `--destination-instance-id`: ID of the target VM or {{ baremetal-name }} server to restore the backup to.

     Result:

     ```text
     ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
     ```

     For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/backup/recover.md).

- API {#api}

  Use the [startRecovery](../../backup/api-ref/Backup/startRecovery.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/StartRecovery](../../backup/api-ref/grpc/Backup/startRecovery.md) gRPC API call.

{% endlist %}

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

Following recovery from a backup, the source VM (unless the **{{ ui-key.yacloud.backup.field_delete-old-vm }}** option was enabled in the management console during the backup) or {{ baremetal-name }} server the backup was created from will become obsolete. To be able to create new backups of the source VM or {{ baremetal-name }} server, refresh their connection to {{ backup-name }}. For more information, see [{#T}](../refresh-connection.md) and [{#T}](../backup-baremetal/refresh-connection.md).

{% include [non-native-bms-restore-connectivity-loss](../../../_includes/backup/operations/non-native-bms-restore-connectivity-loss.md) %}

#### See also {#see-also}

* [{#T}](delete.md)
