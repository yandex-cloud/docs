# Создать триггер, который передает сообщения в функцию {{ sf-name }} из топика брокера {{ iot-full-name }}

Создайте [триггер](../../concepts/trigger/iot-core-trigger.md) для топика брокера {{ iot-name }} и обрабатывайте копии сообщений с помощью [функции](../../concepts/function.md) {{ sf-name }}.

{% note warning %}

Триггер должен находиться в одном облаке с брокером, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../function/function-create.md).
    * [Создайте версию функции](../function/version-manage.md).

* (Опционально) Очередь [Dead Letter Queue](../../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами на вызов функции и (опционально) запись в очередь Dead Letter Queue. Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* [Брокер](../../../iot-core/concepts/index.md#broker), из топика которого триггер будет принимать копии сообщений. Если у вас нет брокера, [создайте его](../../../iot-core/operations/broker/broker-create.md).

## Создать триггер {#trigger-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot-broker }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:
      
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_broker }}** укажите брокер.
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** укажите MQTT-топик. Если MQTT-топик не указан, тригер срабатывает для всех топиков брокера.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 100, значение по умолчанию — 1.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию. Число сообщений при этом не превышает указанный размер группы.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        * [{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}](../../concepts/function.md#tag).
        * [{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}](../../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться функция.
        
    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** укажите время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** укажите количество повторных вызовов функции, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create iot-broker \
      --name <имя_триггера> \
      --broker-id <идентификатор_брокера> \
      --mqtt-topic '<MQTT-топик>' \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts <количество_повторных_вызовов> \
      --retry-interval <интервал_между_повторными_вызовами> \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--broker-id` — [идентификатор брокера](../../../iot-core/operations/broker/broker-list.md).
    * `--mqtt-topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков брокера.
    
    * `--batch-size` — размер группы сообщений из MQTT-топиков. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Число сообщений при этом не превышает `batch-size`.
    
    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.
    * `--retry-attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--retry-interval` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--dlq-queue-id` — идентификатор очереди Dead Letter Queue. Необязательный параметр.
    * `--dlq-service-account-id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue. Необязательный параметр.

    Результат:
    
    ```text
    id: a1sl0mkmimfj********
    folder_id: b1g88tflru0e********
    created_at: "2019-09-25T13:54:35.654935Z"
    name: iot-broker-trigger
    rule:
      iot_broker_message:
        broker_id: arenou2oj4**********
        mqtt_topic: topic-for-broker
        batch_settings:
          size: "1"
          cutoff: 0s
        invoke_function:
          function_id: d4eofc7n0m03********
          function_tag: $latest
          service_account_id: aje3932acd0c********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи функции](../function/function-logs.md), в них отображается информация о вызовах.

## См. также {#see-also}

* [{#T}](../../../serverless-containers/operations/iot-core-trigger-broker-create.md)
* [{#T}](../../../api-gateway/operations/trigger/iot-core-trigger-broker-create.md)