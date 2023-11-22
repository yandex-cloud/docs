# Создать триггер для {{ cloud-logging-name }}, который вызывает функцию {{ sf-name }}

Создайте [триггер для {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} при добавлении записей в [лог-группу](../../../logging/concepts/log-group.md).

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* Лог-группа, при добавлении записей в которую триггер будет запускаться. Если у вас нет лог-группы, [создайте ее](../../../logging/operations/create-group.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}** укажите:

        {% include [logging-settings](../../../_includes/functions/logging-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 100, значение по умолчанию — 1.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию. Число сообщений при этом не превышает указанный размер группы.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    
    ```bash
    yc serverless trigger create logging \
      --name <имя триггера> \
      --log-group-name <имя лог-группы> \
      --batch-size 1 \
      --batch-cutoff 1s \
      --resource-ids <идентификатор_ресурса> \
      --resource-types <тип_ресурса> \
      --stream-names <поток_логирования> \
      --log-levels <уровень_логирования> \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```
  

    Где:

    * `--name` — имя триггера.
    * `--log-group-name` — имя лог-группы, при добавлении записей в которую будет вызываться функция.

    {% include [batch-settings-messages](../../../_includes/functions/batch-settings-messages.md) %}

    {% include [logging-cli-param](../../../_includes/functions/logging-cli-param.md) %}

    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    
    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: logging-trigger
    rule:
      logging:
        log-group-name: default
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
        invoke_function:
          function_id: d4eofc7n0m**********
          function_tag: $latest
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
            service-account-id: aje3932a**********
    status: ACTIVE
    ```
  

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ cloud-logging-name }}:

  1. Опишите в конфигурационном файле параметры триггера.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя триггера>"
       description = "<описание триггера>"
       logging {
          group_id       = "<идентификатор лог-группы>"
          resource_types = [ "<тип ресурса>" ]
          resource_ids   = [ "<идентификатор ресурса>" ]
          levels         = [ "INFO", "ERROR" ]
          stream_names   = [ "<поток логирования>" ]
          batch_cutoff   = 1
          batch_size     = 1
       function {
          id                 = "<идентификатор функции>"
          service_account_id = "<идентификатор сервисного аккаунта>"
       }
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание триггера.
     * `logging` — параметры записей, при добавлении в лог-группу которых будет срабатывать триггер, и настройки группирования сообщений:
        * `group_id` — идентификатор лог-группы.
        * `resource_types` — типы ресурсов, например функции {{ sf-name }} `resource_types = [ "serverless.function" ]`. Можно указать сразу несколько типов. 
        * `resource_ids` — идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например функций `resource_ids = [ "<идентификатор функции>" ]`. Вы можете указать несколько идентификаторов. 
        * `levels` — уровни логирования. Например, `levels = [ "INFO", "ERROR"]`.
        * `stream_names` — потоки логирования.
          Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем следующим параметрам: `resource-ids`, `resource-types`, `stream-names` и `levels`. Если параметр не задан, триггер срабатывает при любом его значении.
        * `batch_cutoff` — максимальное время ожидания. Допустимые значения от 0 до 60 секунд. Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию или контейнер. Число сообщений при этом не превышает указанный размер группы `batch-size`.
        * `batch_size` — размер группы сообщений. Допустимые значения от 1 до 100.
     * `function` — настройки функции, которую будет запускать триггер:
        * `id` — идентификатор функции.
        * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../../cli/quickstart.md):

        ```
        yc serverless trigger get <идентификатор триггера>
        ```

- API

  Чтобы создать триггер для {{ cloud-logging-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ cloud-logging-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/cloud-logging-trigger-create.md).
