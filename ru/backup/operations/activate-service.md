# Активировать сервис

Минимальная роль в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), необходимая для активации сервиса, — `backup.editor` (см. [описание роли](../security/index.md#backup-editor)).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет, и вам доступно создание ВМ с подключением к {{ backup-name }}, значит, сервис уже активирован.

  {% include [default-policies](../../_includes/backup/default-policies.md) %}

- CLI {#cli}

  {% include [default-policies](../../_includes/backup/operations/cli-activate-service.md) %}

{% endlist %}