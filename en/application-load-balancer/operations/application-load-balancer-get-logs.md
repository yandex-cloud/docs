# Viewing L7 load balancer logs

You can [configure](application-load-balancer-manage-logs.md) the delivery of L7 load balancer [logs](../concepts/application-load-balancer.md#logging) to a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md).

To view L7 Load balancer logs:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select the load balancer you need.
  1. Navigate to the **{{ ui-key.yacloud.common.logs }}** tab.
  1. Select the number of messages per page and the time interval: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. To see the message details, click the arrow icon on its left.
  
{% endlist %}

You can also view logs in [{{ cloud-logging-full-name }}](../../logging/):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your log group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the log group receiving your load balancer logs.
  1. Select the number of messages per page and the time interval: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. To see the message details, click the arrow icon on its left.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To see the messages in JSON format, run this command:

    ```bash
    yc logging read \
      --group-name=<log_group_name> \
      --format=json
    ```

    Where:

    * `--group-name`: Name of the log group receiving your load balancer logs.
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

    For more information on how to view logs with CLI, see [this](../../logging/operations/read-logs.md) {#T} article.

- API {#api}

  To view log group messages, use the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

{% endlist %}