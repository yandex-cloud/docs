---
title: Как удалить приемник
description: Следуя данной инструкции, вы сможете удалить приемник.
---

# Удалить приемник

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, из которого хотите удалить [приемник](../../../concepts/eventrouter/rule.md#target).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В строке с нужным [правилом](../../../concepts/eventrouter/rule.md) нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Напротив названия приемника, который вы хотите удалить, нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы удалить [приемник](../../../concepts/eventrouter/rule.md#target) из [правила](../../../concepts/eventrouter/rule.md), обновите набор его приемников, удалив ненужные. Для этого выполните команду, указав в ней имя или идентификатор правила и список приемников, которые нужно оставить:

  {% include [targets-rewrite-warning](../../../../_includes/serverless-integrations/targets-rewrite-warning.md) %}

  {% include [update-three-targets](../../../../_includes/serverless-integrations/update-three-targets.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы удалить [приемник](../../../concepts/eventrouter/rule.md#target) из [правила](../../../concepts/eventrouter/rule.md):

  1. Откройте конфигурационный файл {{ TF }} и удалите блоки с описанием ненужных приемников.

      Пример описания правила в конфигурационном файле {{ TF }}:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<идентификатор_шины>"
        jq_filter = "<jq-выражение>"

        ymq {
          queue_arn            = "<ARN_очереди>"
          service_account_id   = "<идентификатор_сервисного_аккаунта>"
        }

        workflow {
          workflow_id        = "<идентификатор_рабочего_процесса>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }

        yds {
          database           = "<путь_к_базе_данных>"
          stream_name        = "<имя_потока_данных>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }

        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
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

  Чтобы удалить [приемник](../../../concepts/eventrouter/rule.md#target) из [правила](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md).

{% endlist %}