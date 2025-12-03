{% include [activate-provider-roles](./activate-provider-roles.md) %}

{% include [agent-send-data](./agent-send-data.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to connect a VM to {{ backup-name }}.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. If you have not activated {{ backup-name }} yet, click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, and you can create a VM connected to {{ backup-name }}, {{ backup-name }} has already been activated. Proceed to the next step.

{% endlist %}