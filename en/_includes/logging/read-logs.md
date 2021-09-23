The maximum record retention period is 3 days. The log uses Coordinated Universal Time, [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

You can filter records using the [language of filter expressions](../../logging/concepts/filter.md).

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the log group is located.
  1. Open **{{ cloud-logging-name }}**.
  1. Click the **Groups** tab.
  1. Click on the line with the log group you want to view.
  1. Click the **Logs** tab.
  1. The page that opens will show the log group records.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  When viewing the log, you can set a specific interval using the `--since` and `--until` flags. If no interval is specified when invoking a function, information for the last hour is displayed.

  The following flags are used:

  * `--since`: Time N and later.
  * `--until`: Time N and earlier.

  If you only specify one flag, information is displayed for the hour before or after N depending on the flag.

  Allowed time formats:

  * `HH:MM:SS`. Example: `15:04:05`.
  * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Example: `2006-01-02T15:04:05Z`, `2h`, `3h30m ago`.

  To access a log group, use its name or unique ID. To find them, [get](../../logging/operations/list.md) a list of log groups in the folder. If you don't specify the name or ID, the records are output from the [default log group](../../logging/concepts/log-group.md) of the current folder.

  To view the records in JSON format, run the command:

  ```
  yc logging read --group-name=default --format=json
  ```

  Result:
  
  ```
  [
    {
      "uid": "488ece3c-75b8-4d35-95ac-2b491b123472",
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

  To read records as they appear, use the `--follow` flag:

  ```
  yc logging read --group-name=default --follow
  ```

  This command will return records for the last hour and continue to return new ones until you interrupt it with **Ctrl+C**. The `--follow` flag is not compatible with the `--since` and `--until` flags.

{% endlist %}
