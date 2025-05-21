Время в журнале указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время). Записи можно отфильтровать с помощью [языка фильтрующих выражений](../../logging/concepts/filter.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите на строку с лог-группой, записи в которой хотите посмотреть.
    1. На открывшейся странице отобразятся записи.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    При просмотре журнала вы можете указать конкретный временной интервал с помощью параметров `--since` и `--until`. Если временной интервал не был указан, отображается информация за последний час.

    Использование параметров:

    * `--since` — момент времени N и позже (параметр `--since` можно опустить и указать сразу время).
    * `--until` — момент времени N и раньше.

    Если был указан только один параметр, отображается информация за один час до или после момента времени N в зависимости от указанного параметра.

    Допустимые форматы указания времени:

    * `ЧЧ:ММ:СС`. Например, `15:04:05`.
    * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Например: `2006-01-02T15:04:05Z`, `2h`, `3h30m ago`.

    Для обращения к лог-группе используйте ее имя или уникальный идентификатор. Чтобы узнать их, [получите](../../logging/operations/list.md) список лог-групп в каталоге. Если имя или идентификатор не указаны, выводятся записи из [лог-группы по умолчанию](../../logging/concepts/log-group.md) текущего каталога. Параметры `--group-name` и `--group-id` можно опустить и указать сразу имя или идентификатор группы.

    Ограничить количество выводимых записей можно с помощью параметра `--limit`. Допустимые значения — от 1 до 1000.

    Чтобы посмотреть записи в формате JSON, выполните команду:

    ```bash
    yc logging read --group-name=default --format=json
    ```

    Результат:

    ```text
    [
      {
        "uid": "488ece3c-75b8-4d35-95ac-2b49********",
        "resource": {},
        "timestamp": "2023-06-22T02:10:40Z",
        "ingested_at": "2023-06-22T08:49:15.716Z",
        "saved_at": "2023-06-22T08:49:16.176097Z",
        "level": "INFO",
        "message": "My message",
        "json_payload": {
          "request_id": "1234"
        }
      }
    ]
    ```

    Чтобы читать записи по мере их поступления, используйте флаг `--follow`:

    ```bash
    yc logging read --group-name=default --follow
    ```

    Такая команда выведет записи за последний час и продолжит выводить новые до тех пор, пока вы не прервете ее, нажав **Ctrl** + **C**. Флаг `--follow` не совместим с параметрами `--since` и `--until`.

- API {#api}

    Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

- SDK {#sdk}

    Читать записи в {{ cloud-logging-name }} можно с помощью {{ yandex-cloud }} SDK, реализованного для различных языков. Ниже приведены примеры использования Python SDK.

    **Локально**

    ```python
    import os
    import yandexcloud
    import pprint
    from yandex.cloud.logging.v1.log_reading_service_pb2 import ReadRequest
    from yandex.cloud.logging.v1.log_reading_service_pb2 import Criteria
    from yandex.cloud.logging.v1.log_reading_service_pb2_grpc import LogReadingServiceStub

    def handler():
      cloud_logging_service = yandexcloud.SDK(iam_token=os.environ['iam']).client(LogReadingServiceStub)
      logs = {}
      criteria = Criteria(log_group_id='<id_log_группы>', resource_ids=['<id_ресурса>'])
      read_request = ReadRequest(criteria=criteria)

      logs = cloud_logging_service.Read(read_request)
      return logs

    pprint.pprint(handler())
    ```

    {% include [parameters-description](parameters-description.md) %}

    **{{ sf-full-name }}**

    ```python
    import yandexcloud
    from yandex.cloud.logging.v1.log_reading_service_pb2 import ReadRequest
    from yandex.cloud.logging.v1.log_reading_service_pb2 import Criteria
    from yandex.cloud.logging.v1.log_reading_service_pb2_grpc import LogReadingServiceStub

    def handler(event, context):
        cloud_logging_service = yandexcloud.SDK().client(LogReadingServiceStub)
        logs = {}
        criteria = Criteria(log_group_id='<id_log_группы>', resource_ids=['<id_ресурса>'])
        read_request = ReadRequest(criteria=criteria)

        logs = cloud_logging_service.Read(read_request)
        return logs
    ```

    {% include [parameters-description](parameters-description.md) %}

    Параметры функции:
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python38`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `3`.
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 МБ`.
 
{% endlist %}