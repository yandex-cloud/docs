Создайте [триггер](../../functions/concepts/trigger/iot-core-trigger.md) для топика брокера {{ iot-name }} и обрабатывайте копии сообщений с помощью [функции](../../functions/concepts/function.md) {{ sf-name }}.

{% note warning %}

Триггер должен находиться в одном облаке с брокером, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Брокер](../../iot-core/concepts/index.md#broker), из топика которого триггер будет принимать копии сообщений. Если у вас нет брокера, [создайте его](../../iot-core/operations/broker/broker-create.md).

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
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot-broker }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:
      
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_broker }}** укажите брокер.
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** укажите MQTT-топик. Если MQTT-топик не указан, тригер срабатывает для всех топиков брокера.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        {% include [batch-settings](batch-settings.md) %}

        {% include [batch-messages](batch-messages.md) %}

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        {% include [function-settings](function-settings.md) %}
        
    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create iot-broker \
      --name <имя_триггера> \
      --broker-id <идентификатор_брокера> \
      --mqtt-topic '<MQTT-топик_брокера>' \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--broker-id` — [идентификатор брокера](../../iot-core/operations/broker/broker-list.md).
    * `--mqtt-topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков брокера.
    
    {% include [trigger-param](../iot-core/trigger-param-cf.md) %}
    
    {% include [trigger-cli-param](trigger-cli-param.md) %}

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

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}

## См. также {#see-also}

* [{#T}](../../serverless-containers/operations/iot-core-trigger-broker-create.md)
* [{#T}](../../api-gateway/operations/trigger/iot-core-trigger-broker-create.md)
