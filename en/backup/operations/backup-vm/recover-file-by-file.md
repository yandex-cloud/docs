---
title: How to restore individual directories and files on a VM or {{ baremetal-name }} server
description: Follow this guide to restore individual directories and files on a VM or {{ baremetal-name }} server.
---

# Restoring individual directories and files on a VM or {{ baremetal-name }} server


You can restore individual files and directories from a backup to any VM or {{ baremetal-name }} server in the `Running` [status](../../../compute/concepts/vm-statuses.md#list-of-statuses) connected to {{ backup-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the backup.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Depending on the resource you want to recover files and directories for, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. Select the backup to restore individual files or directories from.
  1. In the file manager that opens, select the files and directories you want to restore.
  1. In the bottom panel, click ![file](../../../_assets/console-icons/file-plus.svg) **{{ ui-key.yacloud.backup.action_add-to-recovery-list }}**.
  1. Add all files and directories you want to restore, one by one, to the **{{ ui-key.yacloud.component.files-recovery-container.title_recovery-container }}** list.
  1. Click **{{ ui-key.yacloud.component.files-recovery-container.action_start-recovery }}**, and in the window that opens:
      * Select a VM or {{ baremetal-name }} server to recover the files and directories to.

        {% note info %}

        Make sure the VM or {{ baremetal-name }} server you are recovering the files and directories to is [connected](../../concepts/vm-connection.md) to {{ backup-name }}.

        {% endnote %}

      * (Optional, VMs only) Specify whether to reboot the VM following recovery.
      * Select a location to restore the files to:
        * `{{ ui-key.yacloud.backup.files-recovery.value_location-original }}`: Restore the files to their original directories.
        * `{{ ui-key.yacloud.backup.files-recovery.value_location-custom }}`: Restore the files to a user-defined directory.

          For custom location, in the file manager that opens, select the directory to restore the files to. 
          
          To create a new directory, click ![new-folder](../../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yacloud.common.create }}** and specify its name.

          {% note info %}

          A directory name may not contain the following characters: `\`, `/`, `:`, `*`, `?`, `"`, `'`, `<`, `>`, `|`.

          {% endnote %}

  1. Select an action to perform when file names from a backup match file names on a VM or {{ baremetal-name }} server:
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-all }}`.
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-older }}`.
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-none }}`: Files that are not in the source directory will not be written either.
  1. Click **{{ ui-key.yacloud.backup.action_recovery-start }}**.

  You can check the progress of file recovery on the ![operations](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab in the **{{ ui-key.yacloud.common.operations.column_status }}** column.

{% endlist %}
