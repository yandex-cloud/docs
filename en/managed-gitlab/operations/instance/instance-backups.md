# Managing backups

You can [back up](../../concepts/backup.md) your instances manually.

## Getting a list of backups {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.gitlab.action_create-backup }}**.

{% endlist %}

## Restoring instances from backups {#restore}

To restore an instance from a backup, contact [technical support]({{ link-console-support }}).

You can restore a deleted instance in the same way. When you delete one, the system automatically creates its [backup](../../concepts/backup.md) which is stored for two weeks.
