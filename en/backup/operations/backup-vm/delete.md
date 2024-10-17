---
title: Deleting a backup
description: In this tutorial, you will learn how to delete a VM backup in **{{ backup-name }}**.
---

# Deleting a backup

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}** tab.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the appropriate backup, and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI delete backup command:

      ```bash
      yc backup backups delete --help
      ```

   1. Get the ID of the backup to delete:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

   1. Get the ID of the VM instance whose backup you want to delete:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

   1. Delete the backup:

      ```bash
      yc backup backups delete \
        --backup-id <backup_ID> \
        --instance-id <VM_instance_ID>
      ```

      Where:

      * `--backup-id`: ID of the backup to delete.
      * `--instance-id`: ID of the VM instance whose backup you want to delete.

   For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/backup/delete.md).

- API {#api}

   To delete a backup, use the [delete](../../backup/api-ref/Backup/delete.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/Delete](../../backup/api-ref/grpc/Backup/delete.md) gRPC API call.

{% endlist %}

{% note info %}

To delete backups, make sure the folder contains at least one VM connected to {{ backup-name }}. If there are no such VMs, [create](../create-vm.md) a new one with a connection to {{ backup-name }} and delete the backups.

{% endnote %}

