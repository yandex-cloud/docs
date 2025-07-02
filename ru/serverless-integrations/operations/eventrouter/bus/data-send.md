---
title: Как отправить события в шину {{ er-full-name }} с помощью коннектора
description: Следуя данной инструкции, вы сможете отправить события в шину {{ er-name }} с помощью коннектора.
---

# Отправить события в шину с помощью коннектора

## Таймер {#timer}

Чтобы [отправить](../../../concepts/eventrouter/sending-events.md) события в [шину](../../../concepts/eventrouter/bus.md) через коннектор с типом источника [таймер](../../../concepts/eventrouter/connector.md#timer), укажите необходимые данные в настройках коннектора — они будут отправлены в шину, когда сработает таймер.

## Коннектор для API {{ er-name }} {#er-api}

{% note info %}

Отправлять события в шину с помощью коннектора для API {{ er-name }} можно только, если к ней привязано хотя бы одно [правило](../../../concepts/eventrouter/rule.md).

{% endnote %}

Чтобы отправить события в шину через [коннектор](../../../concepts/eventrouter/connector.md#from-api) с типом источника API {{ er-name }}:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание [команды CLI](../../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md) для отправки событий в шину с помощью коннектора для API {{ er-name }}:

      ```bash
      yc serverless eventrouter send-event --help
      ```
  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Отправьте событие в шину с помощью выбранного коннектора:

      ```bash
      yc serverless eventrouter send-event \
        --name <имя_коннектора> \
        --event '<событие>' \
        --file <путь_к_файлу>
      ```

      Где:
      * `--name` — имя коннектора, с помощью которого вы передаете событие в шину.
      
          Вместо имени коннектора вы можете передать в команде его идентификатор в параметре `--id`.
      * `--event` — отправляемое событие в формате [JSON](https://ru.wikipedia.org/wiki/JSON). Например: `{"name": "value"}`.

      * `--file` — путь к файлу, в котором содержится отправляемое событие или группа событий в формате JSON.

          С помощью параметра `--file` вы можете отправить в шину как одно, так и одновременно несколько событий, передав их в команду в форме JSON-массива. Например: `[{"name1": "value1"},{"name2": "value2"}]`.

      Параметры `--event` и `--file` — взаимоисключающие, можно использовать только один из них.

- API {#api}

  Чтобы отправить событие в шину с помощью коннектора для API {{ er-name }}, воспользуйтесь вызовом gRPC API [EventService/Send](../../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md):

  1. Если у вас не установлена утилита gRPCurl, [установите](https://github.com/fullstorydev/grpcurl) ее.
  1. {% include [cli-install](../../../../_includes/cli-install.md) %}
  1. Получите [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) для [аутентификации](../../../api-ref/eventrouter/authentication.md) в API.

      ```bash
      IAM_TOKEN=$(yc iam create-token)
      ```

      Команда сохранит полученный IAM-токен в переменную `IAM_TOKEN`.
  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Создайте файл с телом запроса (например, `body.json`):

      ```json
      {
        "connector_id": "<идентификатор_коннектора>",
        "message": <событие_или_массив_событий>
      }
      ```

      Где:
      * `connector_id` — идентификатор коннектора, с помощью которого вы передаете событие в шину.
      * `message` — отправляемое событие в формате [JSON](https://ru.wikipedia.org/wiki/JSON). Например: `"{\"name\": \"value\"}"`.

          Вы можете отправить в шину как одно, так и одновременно несколько событий, передав их в поле `message` в форме JSON-массива. Например: `["{\"name1\": \"value1\"}","{\"name2\": \"value2\"}"]`.
  1. Выполните gRPC-вызов, указав путь к созданному ранее файлу `body.json`:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ < body.json \
        events.eventrouter.serverless.yandexcloud.net:443 yandex.cloud.serverless.eventrouter.v1.EventService/Send
      ```

{% endlist %}

## Коннектор для {{ yds-full-name }} {#yds}

Через коннектор с типом источника [{{ yds-full-name }}](../../../../data-streams/index.yaml) события в шину поступают из [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts).

## Коннектор для {{ message-queue-full-name }} {#ymq}

Через коннектор с типом источника [{{ message-queue-full-name }}](../../../../message-queue/index.yaml) события в шину поступают из [очереди сообщений](../../../../message-queue/concepts/queue.md).