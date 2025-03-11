---
title: Как изменить правило
description: Следуя данной инструкции, вы сможете изменить правило.
---

# Изменить правило

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите изменить [правило](../../../concepts/eventrouter/rule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В строке с нужным правилом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры правила.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule update --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}
  1. Укажите в команде параметры, которые необходимо изменить, например имя правила:

      ```bash
      yc serverless eventrouter rule update \
        --name <имя_правила> \
        --new-name <новое_имя_правила>
      ```

      Результат:

      ```text
      id: f66aa46qtt1l********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T10:30:59.611601Z"
      name: renamed-rule
      labels:
        owner: admin
        version: beta
      targets:
        - ymq:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          status: ENABLED
      status: ENABLED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы изменить [правило](../../../concepts/eventrouter/rule.md):

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием ресурса `yandex_serverless_eventrouter_rule`.

      Пример описания правила в конфигурационном файле {{ TF }}:

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

        jq_filter = "<jq-выражение>"
      
        ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_rule` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы изменить [правило](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md).

{% endlist %}