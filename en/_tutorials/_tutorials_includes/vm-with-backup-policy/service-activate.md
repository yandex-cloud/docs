{% note info %}

The minimum [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) role required to [activate the service](../../../backup/concepts/index.md#providers) is `backup.editor` (see [its description](../../../backup/security/index.md#backup-editor) for details).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a VM with a {{ backup-name }} connection in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. If you have not activated {{ backup-name }} yet, click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, and you have access to creating a VM with a {{ backup-name }} connection, it means the service has already been activated. Proceed to the next step.

{% endlist %}