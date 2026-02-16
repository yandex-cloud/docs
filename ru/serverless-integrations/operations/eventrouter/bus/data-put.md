---
title: Как отправить события в шину {{ er-name }} напрямую
description: Следуя данной инструкции, вы сможете отправить события в шину {{ er-full-name }} напрямую с помощью метода put.
---

# Отправить события в шину напрямую

{% note info %}

Отправлять события в шину напрямую можно только, если к ней привязано хотя бы одно [правило](../../../concepts/eventrouter/rule.md).

{% endnote %}

Чтобы [отправить](../../../concepts/eventrouter/sending-events.md) события в [шину](../../../concepts/eventrouter/bus.md) напрямую:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная шина.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![object-align-center-vertical](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. На панели сверху нажмите кнопку ![comment-plus](../../../../_assets/console-icons/comment-plus.svg) **{{ ui-key.yacloud.serverless-event-router.button_send-event }}**.
  1. В открывшемся окне введите отправляемое в шину событие в формате [JSON](https://ru.wikipedia.org/wiki/JSON). Например: `{"name": "value"}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-event-router.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание [команды CLI](../../../../cli/cli-ref/serverless/cli-ref/eventrouter/put-event.md) для непосредственной отправки событий в шину:

      ```bash
      yc serverless eventrouter put-event --help
      ```
  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. Отправьте событие в выбранную шину:

      ```bash
      yc serverless eventrouter put-event \
        --name <имя_шины> \
        --event '<событие>' \
        --file <путь_к_файлу>
      ```

      Где:
      * `--name` — имя шины, в которую вы передаете событие.
      
          Вместо имени шины вы можете передать в команде ее идентификатор в параметре `--id`.
      * `--event` — отправляемое событие в формате [JSON](https://ru.wikipedia.org/wiki/JSON). Например: `{"name": "value"}`.

      * `--file` — путь к файлу, в котором содержится отправляемое в шину событие в формате JSON.

      Параметры `--event` и `--file` — взаимоисключающие, можно использовать только один из них.

- API {#api}

  Чтобы отправить событие в шину напрямую, воспользуйтесь вызовом gRPC API [EventService/Put](../../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md):

  1. Если у вас не установлена утилита gRPCurl, [установите](https://github.com/fullstorydev/grpcurl) ее.
  1. {% include [cli-install](../../../../_includes/cli-install.md) %}
  1. Получите [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) для [аутентификации](../../../api-ref/eventrouter/authentication.md) в API.

      ```bash
      IAM_TOKEN=$(yc iam create-token)
      ```

      Команда сохранит полученный IAM-токен в переменную `IAM_TOKEN`.
  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. Создайте файл с телом запроса (например, `body.json`):

      ```json
      {
        "bus_id": "<идентификатор_шины>",
        "body": "<событие>"
      }
      ```

      Где:
      * `bus_id` — идентификатор шины, в которую вы отправляете событие.
      * `body` — отправляемое событие в формате [JSON](https://ru.wikipedia.org/wiki/JSON). Например: `{'name': 'value'}`.
  1. Выполните gRPC-вызов, указав путь к созданному ранее файлу `body.json`:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ < body.json \
        events.eventrouter.serverless.yandexcloud.net:443 yandex.cloud.serverless.eventrouter.v1.EventService/Put
      ```

{% endlist %}