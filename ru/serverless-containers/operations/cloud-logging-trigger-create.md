# Создать триггер для {{ cloud-logging-name }}, который вызывает контейнер {{ serverless-containers-name }}

Создайте [триггер для {{ cloud-logging-name }}](../concepts/trigger/cloud-logging-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при добавлении записей в [лог-группу](../../logging/concepts/log-group.md).

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* Лог-группа, при добавлении записей в которую триггер будет запускаться. Если у вас нет лог-группы, [создайте ее](../../logging/operations/create-group.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
   
        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}** укажите:

        {% include [logging-settings](../../_includes/functions/logging-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 100, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Число сообщений при этом не превышает указанный размер группы.

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create logging \
      --name <имя_триггера> \
      --log-group-name <имя_лог-группы> \
      --batch-size 1 \
      --batch-cutoff 1s \
      --resource-ids <идентификатор_ресурса> \
      --resource-types <тип_ресурса> \
      --stream-names <поток_логирования> \
      --log-levels <уровень_логирования> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--log-group-name` — имя лог-группы, при добавлении записей в которую будет вызываться контейнер.

    {% include [batch-settings-messages](../../_includes/serverless-containers/batch-settings-messages.md) %}

    {% include [logging-cli-param](../../_includes/functions/logging-cli-param.md) %}

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: logging-trigger
    rule:
      logging:
        log_group_id: e23bidnftlh2********
        resource_type:
          - serverless.functions
        resource_id:
          - d4e1gpsgam78********
        stream_name:
          - test
        levels:
          - INFO
        batch_settings:
          size: "1"
          cutoff: 1s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:dlq
            service-account-id: aje3lebfemh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ cloud-logging-name }}

  1. Опишите в конфигурационном файле параметры триггера:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<имя_триггера>"
        container {
          id                 = "<идентификатор_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = "<количество_повторных_вызовов>"
          retry_interval     = "<интервал_между_повторными_вызовами>"
        }
        logging {
          group_id       = "<идентификатор_лог-группы>"
          resource_types = [ "<тип_ресурса>" ]
          resource_ids   = [ "<идентификатор_ресурса>" ]
          levels         = [ "INFO", "ERROR" ]
          stream_names   = [ "<поток_логирования>" ]
          batch_cutoff   = "<время_ожидания>"
          batch_size     = "<размер_группы_событий>"
        }
        dlq {
         queue_id           = "<идентификатор_очереди_DLQ>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
      }
      ```

      Где:

      * `name` — имя триггера. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

      * `container` — параметры контейнера:

        {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

        {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      * `logging` — параметры триггера:

        * `group_id` — идентификатор лог-группы.
        * `resource_types` — типы ресурсов, например функции {{ sf-name }}. Необязательный параметр.
        * `resource_ids` — идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например функций {{ sf-name }}. Необязательный параметр.
        * `levels` — уровни логирования. Необязательный параметр.
        * `stream_names` — потоки логирования. Необязательный параметр.

          Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем следующим параметрам: `resource_ids`, `resource_types`, `stream_names` и `levels`. Если параметр не задан, триггер срабатывает при любом его значении.

        {% include [tf-batch-msg-params](../../_includes/serverless-containers/tf-batch-msg-params.md) %}

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  Чтобы создать триггер для {{ cloud-logging-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ cloud-logging-name }}, который вызывает функцию {{ sf-name }}](../../functions/operations/trigger/cloud-logging-trigger-create.md).
