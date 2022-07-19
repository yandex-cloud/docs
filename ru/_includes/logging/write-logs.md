{% list tabs %}

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы добавить записи в лог-группу, выполните команду:

    * Linux, MacOS:
        ```
        yc logging write \
          --group-name=default \
          --message="My message" \
          --timestamp="2021-06-08T19:10:40.000Z" \
          --level=INFO \
          --json-payload='{"request_id": "1234"}'
        ```
    * Windows (cmd):
        ```
        yc logging write ^
          --group-name=default ^
          --message="My message" ^
          --timestamp="2021-06-08T19:10:40.000Z" ^
          --level=INFO ^
          --json-payload="{"request_id": "1234"}"
        ```
    * Windows (PowerShell):
        ```
        yc logging write `
          --group-name=default `
          --message="My message" `
          --timestamp="2021-06-08T19:10:40.000Z" `
          --level=INFO `
          --json-payload='"{ \"request_id\": \"1234\" }"'
        ```

        Где:

        * `--group-name` — имя лог-группы, в которую вы хотите добавить записи. Если параметр не указан, записи добавляются в [лог-группу по умолчанию](../../logging/concepts/log-group.md) текущего каталога.
        * `--message` — сообщение.
        * `--timestamp` — время отправки записи.
        * `--level` — уровень логирования.
        * `--json-payload` — дополнительная информация в формате JSON.

- API

    Добавить записи в лог-группу можно с помощью метода API [write](../../logging/api-ref/grpc/log_ingestion_service.md).

{% endlist %}
