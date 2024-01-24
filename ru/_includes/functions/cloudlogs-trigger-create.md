{% note alert %}

Триггер для {{ cloud-logs-name }} устарел. Используйте [триггер для {{ cloud-logging-name }}](../../functions/concepts/trigger/cloud-logging-trigger.md).

{% endnote %}

Создайте [триггер для {{ cloud-logs-name }}](../../functions/concepts/trigger/cloudlogs-trigger.md), который будет вызывать вашу функцию при поступлении сообщений в лог-группу.

Для создания триггера вам понадобятся:

* [Функция](../../functions/concepts/function.md), которую триггер будет запускать. Если у вас еще нет функции:

    * [Создайте функцию](../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../functions/operations/function/version-manage.md).

* (Опционально) Очередь [Dead Letter Queue](../../functions/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на вызов функции и (опционально) запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md). Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
        
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_cloud-logs }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_cloud-logs }}** укажите, сообщения из каких источников будет обрабатывать функция. Лог-группы определятся автоматически.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет указанного размера группы или истечет максимальное время ожидания.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 10, значение по умолчанию — 1.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

        * Выберите функцию, которую будет вызывать триггер.

          {% note alert %}

          Выбор функции, которая служит источником логов для триггера, может привести к экспоненциальному росту вызовов.

          {% endnote %}

        * Укажите [тег версии функции](../../functions/concepts/function.md#tag).
        * Укажите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться функция.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** укажите время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** укажите количество повторных вызовов функции, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь [Dead Letter Queue](../../functions/concepts/dlq.md) и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, выполните команду:

    ```
    yc serverless trigger create cloud-logs \
      --name <имя триггера> \
      --log-groups <идентификаторы лог-групп через запятую> \
      --batch-size 10 \
      --batch-cutoff 10s \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    где:

    * `--name` — имя триггера.
    * `--log-groups` — список идентификаторов лог-групп.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет `batch-size` или истечет `batch-cutoff`.
    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    * `--retry-attempts` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--retry-interval` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--dlq-queue-id` — идентификатор очереди [Dead Letter Queue](../../functions/concepts/dlq.md). Необязательный параметр.
    * `--dlq-service-account-id` — сервисный аккаунт с правами на запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md). Необязательный параметр.


    Результат:

    ```
    id: a1s92agr8mpg********
    folder_id: b1g88tflru0e********
    created_at: "2020-08-13T10:46:55.947Z"
    name: log-trigger
    rule:
      cloud_logs:
        log_group_id:
        - eolhui6rdfg5********
        - eol7tkttsd34********
        batch_settings:
          size: "1"
          cutoff: 10s
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

- API {#api}

  Чтобы создать триггер для {{ cloud-logs-name }}, воспользуйтесь методом REST API [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- Functions

    Проверьте, что триггер работает корректно. Для этого [посмотрите](../../functions/operations/function/function-logs.md) логи:
    * функции, которую вызывает триггер.
    * функций, которые указали как источники логов.

- IoT Core

    [Посмотрите](../../iot-core/operations/logs.md) логи реестров и устройств, которые указали как источники логов.

{% endlist %}
