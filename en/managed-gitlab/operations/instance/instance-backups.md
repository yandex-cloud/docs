# Managing backups

You can create [backups](../../concepts/backup.md) and restore [instances](../../concepts/index.md) from existing backups.

## Getting a list of backups {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
   1. Click the name of the desired instance and select the ![image](../../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.gitlab.title_backups }}** tab.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
   1. Click the name of the desired instance and select the ![image](../../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.gitlab.title_backups }}** tab.
   1. Click ![image](../../../_assets/plus.svg) **{{ ui-key.yacloud.gitlab.action_create-backup }}**.

{% endlist %}

## Restoring instances from backups {#restore}

When you restore an instance from a backup, you create a new instance with data from the backup. If the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) does not have sufficient [resources](../../concepts/limits.md) to create such an instance, you will not be able to restore from a backup.

To restore an instance from a backup or download backup files, contact [technical support]({{ link-console-support }}).