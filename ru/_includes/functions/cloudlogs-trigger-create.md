Создайте [триггер для {{ cloud-logs-name }}](../../functions/concepts/trigger/cloudlogs-trigger.md), который будет вызывать вашу функцию при поступлении сообщений в [лог-группу](../../functions/concepts/log-group.md).

Для создания триггера вам понадобятся:
1. [Функция](../../functions/concepts/function.md), которую триггер будет запускать. Если у вас еще нет функции:
    * [Создайте функцию](../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).
1. Очередь [Dead Letter Queue](../../functions/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).
1. Сервисный аккаунт с правами на вызов функции. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Консоль управления
        
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
    1. Откройте сервис **{{ sf-name }}**.
    1. Перейдите на вкладку **Триггеры**.
    1. Нажмите кнопку **Создать триггер**.
    1. В блоке **Базовые параметры**:
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Cloud Logs**.
    1. В блоке **Настройки Cloud Logs** укажите, сообщения из каких источников будет обрабатывать функция. Лог-группы определятся автоматически.
    1. В блоке **Настройки группирования сообщений** укажите размер группы сообщений и максимальное время ожидания. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет указанного размера группы или истечет максимальное время ожидания.
    1. В блоке **Настройки функции**:
        * Выберите функцию, которую будет вызывать триггер.

          {% note alert %}

          Выбор функции, которая служит источником логов для триггера, может привести к экспоненциальному росту вызовов.

          {% endnote %}

        * Укажите [тег версии функции](../../functions/concepts/function.md#tag).
        * Укажите сервисный аккаунт, от имени которого будет вызываться функция.
    1. В блоке **Настройки повторных запросов**:
        * В поле **Интервал** укажите время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд.
        * В поле **Количество попыток** укажите количество повторных вызовов функции, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Допустимые значения — от 1 до 5.
    1. В блоке **Настройки Dead Letter Queue** выберите очередь [Dead Letter Queue](../../functions/concepts/dlq.md) и сервисный аккаунт с правами на запись в нее.
    1. Нажмите кнопку **Создать триггер**.


- CLI

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
    * `--log-groups` — список идентификаторов [лог-групп](../../functions/concepts/log-group.md).
    * `--batch-size` — размер группы сообщений. Допустимые значения от 1 до 10, значение по умолчанию — 1
    * `--batch-cutoff` — максимальное время ожидания. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер отправит группу сообщений в функцию, когда число сообщений в лог-группе достигнет `batch-size` или истечет `batch-cutoff`.
    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    * `--retry-attempts` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--retry-interval` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--dlq-queue-id` — идентификатор очереди [Dead Letter Queue](../../functions/concepts/dlq.md).
    * `--dlq-service-account-id` — сервисный аккаунт с правами на запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md).


    Результат:

    ```
    id: a1s92agr8mpgeo3kjt48
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2020-08-13T10:46:55.947Z"
    name: log-trigger
    rule:
      cloud_logs:
        log_group_id:
        - eolhui6rdfg564kl8h67
        - eol7tkttsd345gju74df
        batch_settings:
          size: "1"
          cutoff: 10s
        invoke_function:
          function_id: d4eofc7n0m03lmudsk7y
          function_tag: $latest
          service_account_id: aje3932acd0c5ur7drte
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:dlq
            service-account-id: aje3932acd0c5ur7dagp
    status: ACTIVE
  ```

-  API

    Создать триггер для {{ cloud-logs-name }} можно с помощью метода API [create](../../functions/triggers/api-ref/Trigger/create.md).

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
