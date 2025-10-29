{% note info %}

{% include [activate-provider-roles](../../../_includes/backup/activate-provider-roles.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a VM with a {{ backup-name }} connection in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. If you have not activated {{ backup-name }} yet, click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, and you can create a VM connected to {{ backup-name }}, it means the service has already been activated. Proceed to the next step.

- CLI {#cli}

  {% include [default-policies](../../../_includes/backup/operations/cli-activate-service.md) %}

{% endlist %}