# Activating the service

The minimum [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) role required to activate the service is `backup.editor` (see [its description](../security/index.md#backup-editor) for details).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM or a {{ baremetal-full-name }} server with a {{ backup-name }} connection.
  
      {% include [baremetal-note-extended](../../_includes/backup/baremetal-note-extended.md) %}
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, and you have access to creating a VM with a {{ backup-name }} connection, it means the service has already been activated.

  {% include [default-policies](../../_includes/backup/default-policies.md) %}

- CLI {#cli}

  {% include [default-policies](../../_includes/backup/operations/cli-activate-service.md) %}

{% endlist %}