# Restoring individual directories and files on a VM

You can restore individual files and directories from a backup to any VM connected to {{ backup-name }}:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![backups](../../../_assets/backup/backups.svg) **{{ ui-key.yacloud.backup.label_backups }}** tab.
   1. Select the backup to restore individual files or directories from.
   1. In the file manager that opens, select the files and directories you want to restore.
   1. In the bottom panel, click ![file](../../../_assets/backup/file.svg) **{{ ui-key.yacloud.backup.action_add-to-recovery-list }}**.
   1. Add all files and directories you want to restore, one by one, to the **{{ ui-key.yacloud.component.files-recovery-container.title_recovery-container }}** list.
   1. Click **{{ ui-key.yacloud.component.files-recovery-container.action_start-recovery }}**.
   1. In the window that opens:
      * Select the VM to restore the files and directories to.

         {% note info %}

         Make sure the VM the files and directories will be restored to is [connected](../../concepts/vm-connection.md) to {{ backup-name }}.

         {% endnote %}

      * (Optional) Specify whether to restart the VM upon recovery.
      * Select a location to restore the files to:
         * `{{ ui-key.yacloud.backup.files-recovery.value_location-original }}`: Restore the files to their original directories.
         * `{{ ui-key.yacloud.backup.files-recovery.value_location-custom }}`: Restore the files to a user-defined directory.

            For custom location, in the file manager that opens, select the directory to restore the files to.

            To create a new directory, click ![new-folder](../../../_assets/backup/new-folder.svg) **{{ ui-key.yacloud.common.create }}** and specify its name.

            {% note info %}

            Directory names may not include the following characters: `\`, `/`, `:`, `*`, `?`, `"`, `'`, `<`, `>`, and `|`.

            {% endnote %}

   1. Select an action to be performed if the backup and VM file names match:
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-all }}`.
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-older }}`.
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-none }}`: Files missing from the source directory will not be written either.
   1. Click **{{ ui-key.yacloud.backup.action_recovery-start }}**.

   You can view the progress of file recovery from the respective backup under **{{ ui-key.yacloud.common.operations.column_status }}** in the ![operations](../../../_assets/backup/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.

{% endlist %}