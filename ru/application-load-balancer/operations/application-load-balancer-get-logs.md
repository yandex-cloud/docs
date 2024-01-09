# Посмотреть логи L7-балансировщика

Вы можете [настроить](application-load-balancer-manage-logs.md) поставку [логов](../concepts/application-load-balancer.md#logging) L7-балансировщика в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

Чтобы посмотреть логи L7-балансировщика:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите балансировщик, логи которого хотите посмотреть.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. Чтобы посмотреть полную информацию о сообщении, в начале строки нажмите на стрелку.
  
{% endlist %}

Также вы можете посмотреть логи в сервисе [{{ cloud-logging-full-name }}](../../logging/):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Выберите лог-группу, в которую передаются логи балансировщика.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. Чтобы посмотреть полную информацию о сообщении, в начале строки нажмите на стрелку.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть записи в формате JSON, выполните команду:

    ```bash
    yc logging read \
      --group-name=<имя_лог-группы> \
      --format=json
    ```

    Где:

    * `--group-name` — имя лог группы, в которую передаются логи балансировщика.
    * `--format` — формат вывода логов.

    Результат:

    ```json
    [
      {
        "uid": "488ece3c-75b8-4d35-95ac-2b49********",
        "resource": {},
        "timestamp": "2021-06-22T02:10:40Z",
        "ingested_at": "2021-06-22T08:49:15.716Z",
        "saved_at": "2021-06-22T08:49:16.176097Z",
        "level": "INFO",
        "message": "My message",
        "json_payload": {
          "request_id": "1234"
        }
      }
    ]
    ```

    Подробнее о чтении логов с помощью CLI см. в разделе [{#T}](../../logging/operations/read-logs.md).

- API {#api}

  Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/log_reading_service.md#Read).

{% endlist %}