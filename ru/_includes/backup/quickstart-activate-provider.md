{% include [activate-provider-roles](./activate-provider-roles.md) %}

{% include [agent-send-data](./agent-send-data.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет и вам доступно создание ВМ с подключением к {{ backup-name }}, значит, сервис уже активирован. Переходите к следующему шагу.

{% endlist %}