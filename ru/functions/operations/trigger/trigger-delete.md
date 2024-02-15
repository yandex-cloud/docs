---
title: "Инструкция о том, как удалить триггер в {{ sf-full-name }}"
description: "Из статьи вы узнаете, как удалить триггер в {{ sf-full-name }}."
---

# Удалить триггер в {{ sf-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.popup-confirm_button_delete }}**.

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
    ```

    Результат:
    
    ```text
    id: a1s9q2li6t**********
    folder_id: b1g9hv2loa**********
    created_at: "2023-08-01T12:36:14.321Z"
    name: my-trigger
    description: Trigger for uploaded objects
    rule:
      object_storage:
        event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        bucket_id: **********
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: d4e5muirrt**********
          function_tag: $latest
          service_account_id: ajek0fou8e**********
    status: PAUSED
    ```

- {{ TF }} {#tf}

  Информацию о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Чтобы удалить триггер, созданный с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием триггера.
     
     Пример описания триггера в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_function_trigger" "my_trigger" {
       name        = "some_name"
       description = "any description"
       timer {
         cron_expression = "* * * * ? *"
       }
       function {
         id = "tf-test"
       }
     }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../../cli/quickstart.md):

     ```
     yc serverless trigger list
     ```

- API {#api}

  Чтобы удалить триггер, воспользуйтесь методом REST API [delete](../../triggers/api-ref/Trigger/delete.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Delete](../../triggers/api-ref/grpc/trigger_service.md#Delete).

{% endlist %}
