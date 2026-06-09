# Добавление записей

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/operations/trigger/cloud-logging-trigger-create.md) {{ sf-name }} или [контейнер](../../serverless-containers/operations/cloud-logging-trigger-create.md) {{ serverless-containers-name }} при добавлении записей в лог-группу.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы добавить записи в лог-группу, выполните команду:

    * Linux, MacOS:
        ```bash
        yc logging write \
          --group-name=default \
          --message="My message" \
          --level=INFO \
          --json-payload='{"request_id": "1234"}'
        ```
    * Windows (cmd):
        ```cmd
        yc logging write ^
          --group-name=default ^
          --message="My message" ^
          --level=INFO ^
          --json-payload="{"request_id": "1234"}"
        ```
    * Windows (PowerShell):
        ```powershell
        yc logging write `
          --group-name=default `
          --message="My message" `
          --level=INFO `
          --json-payload='"{ \"request_id\": \"1234\" }"'
        ```
        
    Где:

    * `--group-name` — имя лог-группы, в которую вы хотите добавить записи. Если параметр не указан, записи добавляются в [лог-группу по умолчанию](../concepts/log-group.md) текущего каталога. Вместо `--group-name` можно указать `--group-id` — идентификатор группы. 
    * `--message` — сообщение.
    * `--level` — уровень логирования.
    * `--json-payload` — дополнительная информация в формате JSON.

   Параметры `--group-name`, `--message`, `--json-payload` можно опустить и указать только значения параметров, соблюдая порядок. Например: `default "My message" '{"request_id": "1234"}'`.

   {% note info %}

   Возможна задержка появления записей в лог-группе до 60 секунд, поскольку системе требуется время на их обработку.

   {% endnote %}

- API {#api}

  Чтобы добавить записи в лог-группу, воспользуйтесь вызовом gRPC API [LogIngestionService/Write](../api-ref/grpc/LogIngestion/write.md).

{% endlist %}


### См. также {#see-also}

- [Чтение записей](read-logs.md)
- [Мониторинг](monitoring.md)