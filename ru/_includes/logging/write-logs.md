{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

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

        * `--group-name` — имя лог-группы, в которую вы хотите добавить записи. Если параметр не указан, записи добавляются в [лог-группу по умолчанию](../../logging/concepts/log-group.md) текущего каталога. Вместо `--group-name` можно указать `--group-id` — идентификатор группы. 
        * `--message` — сообщение.
        * `--level` — уровень логирования.
        * `--json-payload` — дополнительная информация в формате JSON.

   {% note info %}

   Флаги `--group-name`, `--message`, `--json-payload` можно опустить и указать только значения параметров, соблюдая порядок. Например: `default "My message" '{"request_id": "1234"}'`.

   {% endnote %}

- API {#api}

  Чтобы добавить записи в лог-группу, воспользуйтесь вызовом gRPC API [LogIngestionService/Write](../../logging/api-ref/grpc/log_ingestion_service.md#Write).

{% endlist %}