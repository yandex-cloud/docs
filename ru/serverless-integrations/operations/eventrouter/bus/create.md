---
title: Как создать шину
description: Следуя данной инструкции, вы сможете создать шину.
---

# Создать шину

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [шину](../../../concepts/eventrouter/bus.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-bus }}**. В открывшемся окне:

      1. Введите имя и описание [шины](../../../concepts/eventrouter/bus.md). Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      1. (Опционально) Добавьте метки:

          1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.

      1. (Опционально) Включите защиту от удаления. Пока опция включена, удалить шину невозможно.
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [шины](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus create --help
      ```

  1. Создайте шину:

      ```bash
      yc serverless eventrouter bus create \
        --name <имя_шины> \
        --description "<описание>" \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--name` — имя шины. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description` — описание шины. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      * `--deletion-protection` — защита от удаления шины. Пока опция включена, удалить шину невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.

      Результат:

      ```text
      id: f66aevm4ithv********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-13T12:36:59.497985Z"
      name: my-bus-43
      description: this is my bus
      labels:
        owner: admin
      deletion_protection: true
      status: ACTIVE
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы создать [шину](../../../concepts/eventrouter/bus.md):

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "<имя_шины>"
        description         = "<описание>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
      }
      ```

      Где:

      * `name` — имя шины. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `description` — описание шины. Необязательный параметр.
      * `deletion-protection` — защита от удаления шины: `true` или `false`. Пока опция включена, удалить шину невозможно. Необязательный параметр.
      * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_bus` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_bus).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  Чтобы создать [шину](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Bus/create.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [Bus/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/create.md).

{% endlist %}