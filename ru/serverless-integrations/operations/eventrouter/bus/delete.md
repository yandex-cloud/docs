---
title: Как удалить шину
description: Следуя данной инструкции, вы сможете удалить шину.
---

# Удалить шину

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите удалить [шину](../../../concepts/eventrouter/bus.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. В строке с нужной [шиной](../../../concepts/eventrouter/bus.md) нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [шины](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus delete --help
      ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. Удалите шину:

      ```bash
      yc serverless eventrouter bus delete <имя_или_идентификатор_шины>
      ```

      Результат:

      ```text
      done (1s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы удалить [шину](../../../concepts/eventrouter/bus.md):

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием ресурса `yandex_serverless_eventrouter_bus`:

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

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  Чтобы удалить [шину](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [Delete](../../../../serverless-integrations/eventrouter/api-ref/Bus/delete.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [Bus/Delete](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/delete.md).

{% endlist %}