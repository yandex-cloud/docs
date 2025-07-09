---
title: Delete backup
description: In this tutorial, you will learn how to delete a VM or {{ baremetal-full-name }} server backup in **{{ backup-full-name }}**.
---

# Delete backup


{% note info %}

To delete backups, make sure the folder contains at least one VM or {{ baremetal-name }} server connected to {{ backup-name }}. If there are no such VMs or servers, temporarily [create](../create-vm.md) a new VM with a connection to {{ backup-name }} and delete the backups.

{% endnote %}

To delete a backup:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the backup.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Depending on the resource you want to delete the backup for, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the backup you need to delete and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
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

  1. Get the ID of the VM whose backup you need to delete:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Delete the backup:

      ```bash
      yc backup backups delete \
        --backup-id <backup_ID> \
        --instance-id <VM_or_{{ baremetal-name }}_server_ID>
      ```

      Where:

      * `--backup-id`: ID of the backup to delete.
      * `--instance-id`: ID of the VM or {{ baremetal-name }} server whose backup you need to delete.

  For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/backup/delete.md).

- API {#api}

  Use the [delete](../../backup/api-ref/Backup/delete.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/Delete](../../backup/api-ref/grpc/Backup/delete.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](./batch-delete.md)