---
title: Изменить триггер в {{ sf-name }}
description: Из статьи вы узнаете, как изменить все параметры триггера в {{ sf-name }}, кроме типа триггера и запускаемого ресурса.
---

# Изменить триггер в {{ sf-name }}

Вы можете изменить все параметры, кроме типа триггера и запускаемого ресурса.

{% note info %}

Изменения применятся в течение пяти минут.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Выберите триггер, параметры которого хотите изменить.
    1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
    1. Измените параметры триггера и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}

  1. Посмотрите описание команды CLI для обновления параметров триггера:

      ```bash
      yc serverless trigger update <тип_триггера> --help
      ```

  1. Измените параметры триггера, например переименуйте его:

      ```bash
      yc serverless trigger update <тип_триггера> <имя_триггера> \ 
        --new-name <новое_имя_триггера> 
      ```

      Результат:

      
      ```text
      id: dd0gj5tsj2**********
      folder_id: aoek49ghmk**********
      created_at: "2019-08-28T12:26:25.675Z"
      name: my-trigger
      rule:
        object_storage:
          event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
          bucket_id: s3-for-trigger
          prefix: dev
          suffix: 12.jpg
          invoke_function:
            function_id: d4eofc7n0m03********
            function_tag: $latest
            service_account_id: aje3932acd0c********
            retry_settings:
              retry_attempts: "1"
              interval: 10s
            dead_letter_queue:
              queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
              service-account-id: aje3932acd0c********
      status: ACTIVE
      ```




- {{ TF }} {#tf}

  Информацию о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы изменить параметры триггера:

  1. Откройте файл конфигурации {{ TF }} и измените параметры триггера:

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

      Более подробную информацию о параметрах ресурса `yandex_function_trigger` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/function_trigger).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение триггера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc serverless trigger get <идентификатор_триггера>
    ```

- API {#api}

  Чтобы изменить параметры триггера, воспользуйтесь методом REST API [update](../../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../../triggers/api-ref/grpc/Trigger/update.md).

{% endlist %}
