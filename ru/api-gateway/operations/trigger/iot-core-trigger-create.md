---
title: "Создать триггер, который передает сообщения в соединения по протоколу WebSocket {{ api-gw-full-name }} из топика реестра или устройства {{ iot-full-name }}"
description: "Создайте триггер для топика устройства или реестра {{ iot-name }} для отправки копий сообщений в соединения по протоколу WebSocket {{ api-gw-full-name }}." 
---

# Создать триггер, который отправляет сообщения в WebSocket-соединения из топика реестра или устройства {{ iot-full-name }}

Создайте [триггер](../../concepts/trigger/iot-core-trigger.md) для топика устройства или реестра {{ iot-name }} и отправляйте копии сообщений в [WebSocket-соединения](../../concepts/extensions/websocket.md).

{% note warning %}

Триггер должен находиться в одном облаке с реестром или устройством, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* [Реестр](../../../iot-core/concepts/index.md#registry) или [устройство](../../../iot-core/concepts/index.md#device), из топиков которых триггер будет принимать копии сообщений. Если у вас их нет:

    * [Создайте реестр](../../../iot-core/operations/registry/registry-create.md).
    * [Создайте устройство](../../../iot-core/operations/device/device-create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}** укажите реестр, устройство и MQTT-топик, для которого хотите создать триггер. Если вы создаете триггер для топика реестра, устройство и MQTT-топик можно не указывать. Если MQTT-топик не указан, триггер срабатывает для всех топиков реестра или устройства.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в WebSocket-соединения. Число сообщений при этом не превышает указанный размер группы.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который отправляет сообщения в WebSocket-соединения, выполните команду:

    ```bash
    yc serverless trigger create internet-of-things \
      --name <имя_триггера> \
      --registry-id <идентификатор_реестра> \
      --device-id <идентификатор_устройства> \
      --mqtt-topic '$devices/<идентификатор_устройства>/events' \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../../iot-core/operations/registry/registry-list.md).
    * `--device-id` — [идентификатор устройства](../../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
    * `--mqtt-topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков реестра или устройства.

    {% include [batch-settings-messages](../../../_includes/api-gateway/batch-settings-messages.md) %}

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: iot-trigger
    rule:
      iot_message:
        registry_id: arenou2oj4h2********
        device_id: areqjd6un3h2********
        mqtt_topic: $devices/areqjd6unh2********/events
        batch_settings:
          size: "1"
          cutoff: 0s
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения из топиков реестров и устройств в функцию {{ sf-name }}](../../../functions/operations/trigger/iot-core-trigger-create.md)
* [Триггер для {{ iot-name }}, который передает сообщения из топиков реестров и устройств в контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/iot-core-trigger-create.md)
