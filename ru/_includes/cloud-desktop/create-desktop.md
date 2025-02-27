{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан [рабочий стол](../../cloud-desktop/concepts/desktops-and-groups.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_desktop-create }}**.
  1. Выберите группу рабочих столов, в которой будет создан рабочий стол.
  1. Укажите подсеть, в которой будет размещен рабочий стол.

      {% note info %}

      Чтобы рабочий стол имел доступ в интернет, в подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. Укажите пользователя, для которого создается рабочий стол.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Посмотрите описание команды [CLI](../../cli/index.yaml) для создания [рабочего стола](../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop create --help
      ```

  1. Выберите [группу рабочих столов](../../cloud-desktop/concepts/desktops-and-groups.md):

      {% include [desktops-group-list](desktops-group-list.md) %}

  1. Создайте рабочий стол:

      ```bash
      yc desktops desktop create \
        --desktop-group-id <идентификатор_группы_рабочих_столов> \
        --user-account-id <идентификатор_пользователя>
      ```

      Где:

      * `--desktop-group-id` — идентификатор группы рабочих столов.
      * `--user-account-id` — идентификатор пользователя, для которого создается рабочий стол.

      {% include [create-desktop-cli-result](create-desktop-cli-result.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../../cloud-desktop/api-ref/Desktop/create.md) для ресурса [Desktop](../../cloud-desktop/api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/Create](../../cloud-desktop/api-ref/grpc/Desktop/create.md).

{% endlist %}
