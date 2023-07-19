# Создать триггер для {{ iot-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}

Создайте [триггер](../concepts/trigger/iot-core-trigger.md) для топика устройства или реестра сервиса {{ iot-name }} и обрабатывайте копии сообщений с помощью [контейнера](../concepts/container.md) {{ serverless-containers-name }}.

{% note warning %}

Триггер должен находиться в одном облаке с реестром или устройством, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Реестр](../../iot-core/concepts/index.md#registry) или [устройство](../../iot-core/concepts/index.md#device), из топиков которых триггер будет принимать копии сообщений. Если у вас их нет:

    * [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
    * [Создайте устройство](../../iot-core/operations/device/device-create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ serverless-containers-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **{{ iot-name }}**.
        * В поле Запускаемый ресурс выберите **Контейнер**.

    1. В блоке **Настройки сообщений {{ iot-name }}** укажите реестр, устройство и MQTT-топик, для которого хотите создать триггер. Если вы создаете триггер для топика реестра, устройство и MQTT-топик можно не указывать.

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (Опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (Опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create internet-of-things \
      --name <имя_триггера> \
      --registry-id <идентификатор_реестра> \
      --device-id <идентификатор_устройства> \
      --mqtt-topic '$devices/<идентификатор_устройства>/events' \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```
    Где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
    * `--device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
    * `--mqtt-topic` — топик, для которого вы хотите создать триггер.

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktij**********
    folder_id: b1gmit33hg**********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: iot-trigger
    rule:
      iot_message:
        registry_id: arenou2oj4**********
        device_id: areqjd6un3**********
        mqtt_topic: $devices/areqjd6un**********/events
        invoke_container:
          container_id: bba5jb38o8**********
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
   ```

- API

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения в функцию {{ sf-name }}](../../functions/operations/trigger/iot-core-trigger-create.md).
