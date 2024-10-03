---
title: Создать триггер, который передает сообщения в контейнер {{ serverless-containers-name }} из топика брокера {{ iot-full-name }}
description: Создайте триггер для топика брокера {{ iot-name }} для обработки копии сообщений в контейнере {{ serverless-containers-name }}.
---

# Создать триггер, который передает сообщения в контейнер {{ serverless-containers-name }} из топика брокера {{ iot-full-name }}

Создайте [триггер](../concepts/trigger/iot-core-trigger.md) для топика брокера {{ iot-name }} и обрабатывайте копии сообщений с помощью [контейнера](../concepts/container.md) {{ serverless-containers-name }}.

{% note warning %}

Триггер должен находиться в одном облаке с брокером, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Брокер](../../iot-core/concepts/index.md#broker), из топика которого триггер будет принимать копии сообщений. Если у вас нет брокера, [создайте его](../../iot-core/operations/broker/broker-create.md).

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
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot-broker }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:
      
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_broker }}** укажите брокер.
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** укажите MQTT-топик. Если MQTT-топик не указан, триггер срабатывает для всех топиков брокера.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

        {% include [batch-messages](../../_includes/serverless-containers/batch-messages.md) %} 
    
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
    yc serverless trigger create iot-broker \
      --name <имя_триггера> \
      --broker-id <идентификатор_брокера> \
      --mqtt-topic '<MQTT-топик>' \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts <количество_повторных_вызовов> \
      --retry-interval <интервал_между_повторными_вызовами> \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--broker-id` — [идентификатор брокера](../../iot-core/operations/broker/broker-list.md).
    * `--mqtt-topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков брокера.

    {% include [trigger-param](../../_includes/iot-core/trigger-param-sc.md) %}

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: iot-broker-trigger
    rule:
      iot_broker_message:
        broker_id: arenou2oj4h2********
        mqtt_topic: topic-for-broker
        batch_settings:
          size: "1"
          cutoff: 0s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje3932acdh2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [{#T}](../../functions/operations/trigger/iot-core-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/iot-core-trigger-broker-create.md)
