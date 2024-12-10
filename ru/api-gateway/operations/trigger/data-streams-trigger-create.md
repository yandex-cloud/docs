---
title: Создать триггер для {{ yds-full-name }}, который отправляет сообщения в WebSocket-соединения
description: Следуя данной инструкции, вы сможете создать триггер для {{ yds-name }}, который отправляет сообщения в WebSocket-соединения, а также проверить результат его работы.
---

# Создать триггер для {{ yds-name }}, который отправляет сообщения в WebSocket-соединения

 Создайте [триггер для {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md), который будет отправлять сообщения в [WebSocket-соединения](../../concepts/extensions/websocket.md) при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

{% note info %}

{% include [trigger-message-format-note](../../../_includes/functions/trigger-message-format-note.md) %}

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* Поток, при отправке данных в который триггер будет запускаться.  Если у вас нет потока, [создайте его](../../../data-streams/quickstart/create-stream.md). 

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
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}** выберите поток данных и сервисный аккаунт с правами на чтение из потока данных и запись в него.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * размер группы сообщений в байтах. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в WebSocket-соединения. Суммарный объем данных, которые передаются в соединения, может превышать указанный размер группы, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает размер группы.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который отправляет сообщения в WebSocket-соединения, выполните команду:

    ```bash
    yc serverless trigger create yds \
      --name <имя_триггера> \
      --database <размещение_базы_данных> \
      --stream <имя_потока_данных> \
      --batch-size 1b \
      --batch-cutoff 1s \
      --stream-service-account-id <идентификатор_сервисного_аккаунта> \
      --gateway-id <идентификатор_API-шлюза> \
      --gateway-websocket-broadcast-path <путь> \
      --gateway-websocket-broadcast-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--database` — размещение базы данных {{ ydb-short-name }}, к которой привязан поток {{ yds-name }}.

      Чтобы узнать, где размещена база данных, выполните команду `yc ydb database list`. Размещение базы данных указано в столбце `ENDPOINT`, в параметре `database`, например `/{{ region-id }}/b1gia87mbah2********/etn7hehf6gh3********`.

    * `--stream` — имя потока данных.

    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.

    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в WebSocket-соединения. Суммарный объем данных, которые передаются в соединения, может превышать `batch-size`, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает `batch-size`.

    * `--stream-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на чтение из потока данных и запись в него.

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T14:07:04.693126923Z"
    name: data-streams-trigger
    rule:
      data_stream:
        database: /{{ region-id }}/b1gia87mbah2********/etn7hehh2********
        stream: streams-name
        service_account_id: ajep8qm0kh2********
        batch_settings:
          size: "1"
          cutoff: 1s
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для {{ yds-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}](../../../functions/operations/trigger/data-streams-trigger-create.md)
* [Триггер для {{ yds-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/data-streams-trigger-create.md)
