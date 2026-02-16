---
title: Как удалить правило
description: Следуя данной инструкции, вы сможете удалить правило.
---

# Удалить правило

{% note info %}

Удалить правило невозможно, если включена защита от удаления. Перед удалением [отключите](update.md) защиту.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите удалить [правило](../../../concepts/eventrouter/rule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В строке с нужным правилом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule delete --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}
  1. Удалите правило:

      ```bash
      yc serverless eventrouter rule delete <имя_или_идентификатор_правила>
      ```

      Результат:

      ```text
      done (1s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы удалить [правило](../../../concepts/eventrouter/rule.md):

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием ресурса `yandex_serverless_eventrouter_rule`:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id      = "<идентификатор_правила>"
        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }

        jq_filter = "<jq-шаблон>"
      
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы удалить [правило](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Delete](../../../../serverless-integrations/eventrouter/api-ref/Rule/delete.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Delete](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/delete.md).

{% endlist %}