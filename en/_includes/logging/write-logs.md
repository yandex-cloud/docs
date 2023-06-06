{% list tabs %}

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To add records to a log group, run the command:

   
   * Linux, MacOS:
        ```
        yc logging write \
          --group-name=default \
          --message="My message" \
          --level=INFO \
          --json-payload='{"request_id": "1234"}'
        ```
    * Windows (cmd):
        ```
        yc logging write ^
          --group-name=default ^
          --message="My message" ^
          --level=INFO ^
          --json-payload="{"request_id": "1234"}"
        ```
    * Windows (PowerShell):
        ```
        yc logging write `
          --group-name=default `
          --message="My message" `
          --level=INFO `
          --json-payload='"{ \"request_id\": \"1234\" }"'
        ```



      Where:

      * `--group-name`: Name of the log group to add records to. If this parameter is not specified, records are added to the [default log group](../../logging/concepts/log-group.md) in the current folder.
      * `--message`: Message.
      * `--level`: Logging level.
      * `--json-payload`: Additional information in JSON format.

- API

   To add entries to the log group, use the [LogIngestionService/Write](../../logging/api-ref/grpc/log_ingestion_service.md#Write) gRPC API call.

{% endlist %}
