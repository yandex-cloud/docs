# Working with backups in {{ mgl-full-name }}

{% include [mgl-backup-intro](../../../_includes/managed-gitlab/mgl-backup-intro.md) %}

For more information, see [{#T}](../../concepts/backup.md).

You can do the following:
* [{#T}](#list)
* [{#T}](#create-backup)
* [{#T}](#restore)
* [{#T}](#create-instance-from-backup)
* [{#T}](#download)
* [{#T}](#delete)

## Getting a list of backups {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select the **{{ ui-key.yacloud.gitlab.title_backups }}** tab.

{% endlist %}

## Creating a backup manually {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select the **{{ ui-key.yacloud.gitlab.title_backups }}** tab.
  1. Click **{{ ui-key.yacloud.gitlab.action_create-backup }}**.

{% endlist %}

## Restoring an instance from a backup {#restore}

{% note warning %}

Restoring an instance will overwrite your current instance data.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. In the backup row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.gitlab.action_restore-backup }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.gitlab.action_restore-backup }}**.

{% endlist %}

{% note tip %}

To restore a deleted instance, contact [support]({{ link-console-support }}). When you delete an instance, the system automatically creates its [backup](../../concepts/backup.md) which is stored for two weeks.

{% endnote %}

## Creating a new instance from a backup {#create-instance-from-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the name of the backed up instance and select ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. In the backup row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.gitlab.action_create-instance-from-backup }}**.
  1. Configure the new instance.
  1. Under **{{ ui-key.yacloud.gitlab.label_restore-section }}**, select which settings of the source instance you want to restore:

     * **{{ ui-key.yacloud.gitlab.field_copy-object-storage }}**: For more information, see [{#T}](../objstorage-integration.md).
     * **{{ ui-key.yacloud.gitlab.field_copy-omniauth-config }}**: For more information, see [{#T}](../omniauth.md).

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Using pre-signed URLs to download a backup and secrets {#download}

{% note warning %}

{{ GL }} secrets contain confidential data. Never share backup and secret links with third parties.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. In the backup row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.gitlab.action_get-backup-link }}**.
  1. In the **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.label_lifetime }}** field, define the lifetime for the pre-signed URLs from one hour to seven days.
  1. Click **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.button_generate }}**.
  1. Copy the pre-signed URLs from the **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.label_backup-link }}** and **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.label_secrets-link }}** fields.
  1. Follow each link to download the files.

{% endlist %}

## Deleting a backup {#delete}

{% note warning %}

You cannot restore a deleted backup.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. In the backup row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.gitlab.action_delete-backup }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.gitlab.action_delete-backup }}**.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/backup.md)
* [{#T}](../objstorage-integration.md)
* [{#T}](../omniauth.md)
* [{#T}](./instance-create.md)