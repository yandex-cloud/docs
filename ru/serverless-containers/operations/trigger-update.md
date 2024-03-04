# Изменить триггер в {{ serverless-containers-name }}

Вы можете изменить все параметры, кроме типа триггера и запускаемого ресурса.

{% note info %}

Изменения применятся в течение пяти минут.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Выберите триггер, параметры которого хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры триггера и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

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
      id: a1s5msktij**********
      folder_id: b1gmit33hg**********
      created_at: "2022-10-24T15:19:15.353909857Z"
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
          invoke_container:
            container_id: bba5jb38o8**********
            service_account_id: aje3932acd**********
            retry_settings:
              retry_attempts: "1"
              interval: 10s
            dead_letter_queue:
              queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
              service-account-id: aje3932acd**********
      status: ACTIVE
      ```



- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените параметры ресурса `function_trigger`:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<имя_таймера>"
        timer {
          cron_expression = "<cron-выражение>"
          payload         = "<сообщение>"
        }
        container {
          id                 = "<идентификатор_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = <количество_повторных_вызовов>
          retry_interval     = <интервал_между_повторными_вызовами>
        }
        dlq {
          queue_id           = "<идентификатор_очереди_DLQ>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `name` — имя таймера. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

      * `timer` — параметры триггера:
          * `cron_expression` — расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).
          * `payload` — сообщение, которое будет передаваться в функцию при срабатывании таймера. Длина строки должна быть не более 4096 символов.

      * `container` — параметры контейнера, который будет запускать триггер:

          {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

          {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      Более подробную информацию о параметрах ресурса `function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  Чтобы изменить параметры триггера, воспользуйтесь методом REST API [update](../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../triggers/api-ref/grpc/trigger_service.md#Update).

{% endlist %}
