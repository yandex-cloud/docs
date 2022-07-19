{% list tabs %}

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To add records to a log group, run the command:

   * Windows (`PowerShell`), Linux, MacOS:
      ```
      yc logging write \
        --group-name=default \
        --message="My message" \
        --timestamp="2021-06-08T19:10:40.000Z" \
        --level=INFO \
        --json-payload='{"request_id": "1234"}'
      ```
   * Windows (`cmd`):
      ```
      yc logging write \
        --group-name=default \
        --message="My message" \
        --timestamp="2021-06-08T19:10:40.000Z" \
        --level=INFO \
        --json-payload="{"request_id": "1234"}"
      ```

      Where:

      * `--group-name`: Name of the log group to add records to. Optional. If this parameter is omitted, records are added to the [default log group](../../logging/concepts/log-group.md) in the current folder.
      * `--message`: Message.
      * `--timestamp`: Time when the record is sent.
      * `--level`: Logging level.
      * `--json-payload`: Additional information in JSON format.

- API

   You can add entries to a log group using the API [write](../../logging/api-ref/grpc/log_ingestion_service.md) method.

{% endlist %}