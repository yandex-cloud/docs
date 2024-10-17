---
title: Инструкция о том, как удалить триггер в {{ serverless-containers-full-name }}
description: Из статьи вы узнаете, как удалить триггер в {{ serverless-containers-full-name }}.
---

# Удалить триггер в {{ serverless-containers-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.
    
- CLI {#cli}
  
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
    ```

    Результат:
    
    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer-test
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        invoke_container_with_retry:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: PAUSED
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить триггер, созданный с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием ресурса `function_trigger`.

      Пример описания ресурса `function_trigger` в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "sc-timer"
        timer {
          cron_expression = "*/5 * ? * * *"
        }
        container {
          id                 = "bbaomb25tl68********"
          service_account_id = "ajej9vu5f62d********"
          retry_attempts     = 1
          retry_interval     = 15
        }
        dlq {
          queue_id           = "yrn:yc:ymq:{{ region-id }}:b1geoelk7fld********:formycontainer"
          service_account_id = "ajej9vu5f62d********"
        }
      }
      ```

  1. Удалите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  Чтобы удалить триггер, воспользуйтесь методом REST API [delete](../triggers/api-ref/Trigger/delete.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Delete](../triggers/api-ref/grpc/Trigger/delete.md).

{% endlist %}
