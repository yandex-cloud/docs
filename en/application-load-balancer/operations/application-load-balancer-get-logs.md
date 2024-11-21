# Viewing L7 load balancer logs

You can [configure](application-load-balancer-manage-logs.md) the delivery of L7 load balancer [logs](../concepts/application-load-balancer.md#logging) to a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md).

To view logs of the L7 Load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select the load balancer to view logs for.
  1. Go to the **{{ ui-key.yacloud.common.logs }}** tab.
  1. Select the number of messages per page and the period: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. To view full information about the message, click the arrow at the beginning of the row.

{% endlist %}

You can also view logs in [{{ cloud-logging-full-name }}](../../logging/):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the log group the load balancer logs will be sent to.
  1. Select the number of messages per page and the period: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. To view full information about the message, click the arrow at the beginning of the row.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view the records in JSON format, run the command:

    ```bash
    yc logging read \
      --group-name=<log_group_name> \
      --format=json
    ```

    Where:

    * `--group-name`: Name of the log group the load balancer logs are sent to.
    * `--format`: Log output format.

    Result:

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

    For more information on how to read logs using the CLI, see [{#T}](../../logging/operations/read-logs.md).

- API {#api}

  To view log group records, use the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

{% endlist %}