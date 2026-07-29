---
title: Delete backup
description: In this tutorial, you will learn how to delete a VM or server backup in {{ backup-full-name }}.
---

# Delete backup


{% note tip %}

To delete backups, the folder must contain at least one [resource](../../concepts/index.md#protected-resources) connected to {{ backup-name }}. If there are no such resources, [create](../create-vm.md) a temporary new VM connected to {{ backup-name }} and delete the backups.

The deletion process is asynchronous, so wait until it is over. Before stopping or removing the last VM or server connected to {{ backup-name }}, make sure the the backup list is empty.

{% endnote %}

To delete a backup:

{% note info %}

Currently, you can delete a backup of an [external resource](../../concepts/vm-connection/external-resources.md) using the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/backup/cli-ref/backup/delete.md) and [API](../../backup/api-ref/Backup/delete.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the backup.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
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

  1. Get the ID of the [resource](../../concepts/index.md#protected-resources) whose backup you need to delete:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Delete the backup:

      ```bash
      yc backup backups delete \
        --backup-id <backup_ID> \
        --instance-id <resource_ID>
      ```

      Where:

      * `--backup-id`: ID of the backup to delete.
      * `--instance-id`: ID of the [{{ compute-name }} VM](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} server](../../concepts/vm-connection/baremetal.md), or [external resource](../../concepts/vm-connection/external-resources.md) whose backup you need to delete.

  For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/backup/delete.md).

- API {#api}

  Use the [delete](../../backup/api-ref/Backup/delete.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/Delete](../../backup/api-ref/grpc/Backup/delete.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](./batch-delete.md)