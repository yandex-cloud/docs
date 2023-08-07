# Restoring a VM from a backup

{% note info %}

If the current VM is down, [create](../#connect-vm) a new one with a connection to {{ backup-name }} and [restore](non-native-recovery.md) a backup to it.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
   1. Select **{{ backup-name }}**.
   1. Go to the ![backups](../../../_assets/backup/backups.svg) **Backups** tab.
   1. Next to the backup to restore the VM from, click ![image](../../../_assets/options.svg) and select **Restore VM**.
   1. In the **Target VM** field, select the VM you created the backup from. In the list, this VM is marked as `(current)`.
   1. Click **Restore**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to restore a VM from a backup:

      ```bash
      yc backup backups recover --help
      ```

   1. Get the ID of the appropriate backup:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

   1. Get the ID of the VM to restore:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

   1. Restore the VM from the backup:

      ```bash
      yc backup backups recover \
        --source-backup-id <backup_ID> \
        --destination-instance-id <VM_ID>
      ```

      Where:

      * `--source-backup-id`: ID of the backup to restore the VM from.
      * `--destination-instance-id`: ID of the VM to restore the backup to.

      Result:

      ```text
      ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
      ```

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/backup/recover.md).

{% endlist %}

#### See also {#see-also}

* [{#T}](non-native-recovery.md)