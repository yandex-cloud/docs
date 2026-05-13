# Отправить события в шину с помощью коннектора

## Таймер {#timer}

Чтобы [отправить](../../../concepts/eventrouter/sending-events.md) события в [шину](../../../concepts/eventrouter/bus.md) через коннектор с типом источника [таймер](../../../concepts/eventrouter/connector.md#timer), укажите необходимые данные в настройках коннектора — они будут отправлены в шину, когда сработает таймер.

## Коннектор для API EventRouter {#er-api}

{% note info %}

Отправлять события в шину с помощью коннектора для API EventRouter можно только, если к ней привязано хотя бы одно [правило](../../../concepts/eventrouter/rule.md).

{% endnote %}

Чтобы отправить события в шину через [коннектор](../../../concepts/eventrouter/connector.md#from-api) с типом источника API EventRouter:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание [команды CLI](../../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md) для отправки событий в шину с помощью коннектора для API EventRouter:

      ```bash
      yc serverless eventrouter send-event --help
      ```
  1. Получите список коннекторов:
     
     ```bash
     yc serverless eventrouter connector list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     |          ID          |         NAME          |        BUS ID        |      FOLDER ID       | STATUS  | DELETION PROTECTION |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     | f66g4h59ih2g******** | connector-my-ydb-flow | f66qn4p7uk6p******** | b1g681qpemb4******** | STOPPED | true                |
     | f66g6jcnc5no******** | yds-via-cli           | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     | f66jfhcg1u71******** | mq-via-terraform      | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     ```
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

  Чтобы отправить событие в шину с помощью коннектора для API EventRouter, воспользуйтесь вызовом gRPC API [EventService/Send](../../../eventrouter/api-ref/grpc/Event/send.md):

  1. Если у вас не установлена утилита gRPCurl, [установите](https://github.com/fullstorydev/grpcurl) ее.
  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).
  1. Получите [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) для [аутентификации](../../../api-ref/eventrouter/authentication.md) в API.

      ```bash
      IAM_TOKEN=$(yc iam create-token)
      ```

      Команда сохранит полученный IAM-токен в переменную `IAM_TOKEN`.
  1. Получите список коннекторов:
     
     ```bash
     yc serverless eventrouter connector list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     |          ID          |         NAME          |        BUS ID        |      FOLDER ID       | STATUS  | DELETION PROTECTION |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     | f66g4h59ih2g******** | connector-my-ydb-flow | f66qn4p7uk6p******** | b1g681qpemb4******** | STOPPED | true                |
     | f66g6jcnc5no******** | yds-via-cli           | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     | f66jfhcg1u71******** | mq-via-terraform      | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     ```
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

## Коннектор для Yandex Data Streams {#yds}

Через коннектор с типом источника [Yandex Data Streams](../../../../data-streams/index.md) события в шину поступают из [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts).

## Коннектор для Yandex Message Queue {#ymq}

Через коннектор с типом источника [Yandex Message Queue](../../../../message-queue/index.md) события в шину поступают из [очереди сообщений](../../../../message-queue/concepts/queue.md).