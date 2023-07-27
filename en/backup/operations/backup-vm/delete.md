# Deleting a backup

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
   1. Select **{{ backup-name }}**.
   1. Go to the ![backups](../../../_assets/backup/backups.svg) **Backups** tab.
   1. Next to the backup you wish to delete, click ![image](../../../_assets/options.svg) and select **Delete**.
   1. Confirm the deletion.

- CLI

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

{% endlist %}

{% note info %}

To delete backups, make sure the folder contains at least one VM connected to {{ backup-name }}. If there are no such VMs, [create](../create-vm.md) a new one with a connection to {{ backup-name }} and delete the backups.

{% endnote %}

