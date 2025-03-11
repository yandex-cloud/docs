---
title: Как удалить коннектор
description: Следуя данной инструкции, вы сможете удалить коннектор.
---

# Удалить коннектор

{% note info %}

Удалить коннектор невозможно, если включена защита от удаления. Перед удалением [отключите](update.md) защиту.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите удалить [коннектор](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
  1. В строке с нужным коннектором нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector delete --help
      ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Удалите коннектор:

      ```bash
      yc serverless eventrouter connector delete <имя_или_идентификатор_коннектора>
      ```

      Результат:

      ```text
      done (1s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы удалить [коннектор](../../../concepts/eventrouter/connector.md):

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием ресурса `yandex_serverless_eventrouter_connector`:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<идентификатор_шины>"
        name                = "<имя_коннектора>"
        description         = "<описание_коннектора>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы удалить [коннектор](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [Delete](../../../../serverless-integrations/eventrouter/api-ref/Connector/delete.md) для ресурса [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [Connector/Delete](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/delete.md).

{% endlist %}