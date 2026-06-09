# Отправить события в шину напрямую

{% note info %}

Отправлять события в шину напрямую можно только, если к ней привязано хотя бы одно [правило](../../../concepts/eventrouter/rule.md).

{% endnote %}

Чтобы [отправить](../../../concepts/eventrouter/sending-events.md) события в [шину](../../../concepts/eventrouter/bus.md) напрямую:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная шина.
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева выберите ![object-align-center-vertical](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. На панели сверху нажмите кнопку ![comment-plus](../../../../_assets/console-icons/comment-plus.svg) **Отправить событие**.
  1. В открывшемся окне введите отправляемое в шину событие в формате [JSON](https://ru.wikipedia.org/wiki/JSON). Например: `{"name": "value"}`.
  1. Нажмите кнопку **Отправить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание [команды CLI](../../../../cli/cli-ref/serverless/cli-ref/eventrouter/put-event.md) для непосредственной отправки событий в шину:

      ```bash
      yc serverless eventrouter put-event --help
      ```
  1. Получите список шин:
     
     ```bash
     yc serverless eventrouter bus list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------------+----------------------+--------+---------------------+
     |          ID          |       NAME       |      FOLDER ID       | STATUS | DELETION PROTECTION |
     +----------------------+------------------+----------------------+--------+---------------------+
     | f6676a9ti657******** | my-new-bus-17    | b1g681qpemb4******** | ACTIVE | false               |
     | f66aevm4ithv******** | my-favourite-bus | b1g681qpemb4******** | ACTIVE | true                |
     | f66m2q222n92******** | my-bus-42        | b1g681qpemb4******** | ACTIVE | false               |
     +----------------------+------------------+----------------------+--------+---------------------+
     ```
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

  Чтобы отправить событие в шину напрямую, воспользуйтесь вызовом gRPC API [EventService/Put](../../../eventrouter/api-ref/grpc/Event/put.md):

  1. Если у вас не установлена утилита gRPCurl, [установите](https://github.com/fullstorydev/grpcurl) ее.
  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).
  1. Получите [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) для [аутентификации](../../../api-ref/eventrouter/authentication.md) в API.

      ```bash
      IAM_TOKEN=$(yc iam create-token)
      ```

      Команда сохранит полученный IAM-токен в переменную `IAM_TOKEN`.
  1. Получите список шин:
     
     ```bash
     yc serverless eventrouter bus list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------------+----------------------+--------+---------------------+
     |          ID          |       NAME       |      FOLDER ID       | STATUS | DELETION PROTECTION |
     +----------------------+------------------+----------------------+--------+---------------------+
     | f6676a9ti657******** | my-new-bus-17    | b1g681qpemb4******** | ACTIVE | false               |
     | f66aevm4ithv******** | my-favourite-bus | b1g681qpemb4******** | ACTIVE | true                |
     | f66m2q222n92******** | my-bus-42        | b1g681qpemb4******** | ACTIVE | false               |
     +----------------------+------------------+----------------------+--------+---------------------+
     ```
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