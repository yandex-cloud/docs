All times in the log are [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time). You can filter records using a [filter expression language](../../logging/concepts/filter.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the log group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Click the row with the log group whose records you want to view.
  1. The page that opens will show the log group records.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  When viewing the log, you can set a specific time interval using the `--since` and `--until` parameters. If you do not specify a time interval, the log will show info for the last hour.

  Using parameters:

  * `--since`: Time N and later (you can skip the `--since` parameter and specify the time directly).
  * `--until`: Time N and earlier.

  If you only specify a single parameter, you will see info for one hour before or after time N, depending on the parameter.

  You can use one of these time formats:

  * `HH:MM:SS`, e.g., `15:04:05`.
  * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), e.g., `2006-01-02T15:04:05Z`, `2h`, or `3h30m ago`.

  To access a log group, use its name or unique ID. To find them out, [get](../../logging/operations/list.md) a list of log groups in the folder. If you do not specify the name or ID, the output will contain records from the [default log group](../../logging/concepts/log-group.md) in the current folder. You can skip the `--group-name` and `--group-id` parameters and specify the group name or ID directly.

  To limit the number of output records, use the `--limit` parameter. The values may range from 1 to 1,000.

  To view the records in JSON format, run this command:

  ```bash
  yc logging read --group-name=default --format=json
  ```

  Result:

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

  To read records as they appear, use the `--follow` flag:

  ```bash
  yc logging read --group-name=default --follow
  ```

  This command will display records from the last hour and will continue streaming new ones until you stop it with **Ctrl** + **C**. The `--follow` flag cannot be used together with the `--since` and `--until` parameters.

- SDK {#sdk}

  You can read records in {{ cloud-logging-name }} using the [{{ yandex-cloud }} SDK](../../overview/sdk/quickstart), which is available for various languages. Below are examples of using the Python SDK. You can work with code in your infrastructure or in [{{ sf-full-name }}](../../functions/).

  **Locally**

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
    criteria = Criteria(log_group_id='<log_group_ID>', resource_ids=['<resource_ID>'])
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
      criteria = Criteria(log_group_id='<log_group_ID>', resource_ids=['<resource_ID>'])
      read_request = ReadRequest(criteria=criteria)

      logs = cloud_logging_service.Read(read_request)
      return logs
  ```

  {% include [parameters-description](parameters-description.md) %}

  Function parameters:

  * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python38`.
  * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
  * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `3`.
  * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 MB`.

- API {#api}

  To view [log group](../../logging/concepts/log-group.md) records, use the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

  **Example**

  To view log group entries for the last hour using [gRPCurl](https://github.com/fullstorydev/grpcurl), follow these steps:

  1. Get an IAM token and write it to the variable:

      ```bash
      IAM_TOKEN=`yc iam create-token`
      ```

  1. Calculate and write timestamps into variables:

      ```bash
      NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
      ONE_HOUR_AGO=$(date -u -d "1 hour ago" +"%Y-%m-%dT%H:%M:%SZ")
      ```

      You can specify a different period instead of 1 hour: `"1 hour ago"`. For example, an interval such as `1 month, 2 weeks, 3 days, and 4 hours` would look like this:

      ```text
      "1 month ago 2 weeks ago 3 days ago 4 hours ago"
      ```

      {% cut "macOS" %}

      For macOS, use:

      ```bash
      NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
      ONE_HOUR_AGO=$(date -u -v-1H +"%Y-%m-%dT%H:%M:%SZ")
      ```

      {% endcut %}

  1. Write the ID of the required log group to the variable:

      ```bash
      LOG_GROUP_ID="<log_group_ID>"
      ```

  1. Make a request using gRPCurl:

      ```bash
      grpcurl -H "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "criteria": {
            "log_group_id": "'$LOG_GROUP_ID'",
            "since": "'$ONE_HOUR_AGO'",
            "until": "'$NOW'",
            "page_size": 10
          }
        }' \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/logging/v1/log_reading_service.proto \
        {{ logging-endpoint-reader }}:443 \
        yandex.cloud.logging.v1.LogReadingService/Read
      ```

      Where:

      * `log_group_id`: Log group ID.
      * `since`: Start of the period.
      * `until`: End of the period.
      * `page_size`: Number of entries in the result.

      Result:

      ```text
      {
        "logGroupId": "e23hf37rnj71********",
        "entries": [
          {
            "uid": "26:10******:*",
            "resource": {},
            "timestamp": "2025-05-22T14:42:12.896587Z",
            "ingestedAt": "2025-05-22T14:42:14.098Z",
            "savedAt": "2025-05-22T14:42:15.697585Z",
            "level": "INFO",
            "message": "test_message",
            "jsonPayload": {
              "host": "test_host",
              "request_id": "1234"
            }
          },
      ...
          {
            "uid": "7:1a******:*",
            "resource": {},
            "timestamp": "2025-05-22T14:42:25.864347Z",
            "ingestedAt": "2025-05-22T14:42:27.019Z",
            "savedAt": "2025-05-22T14:42:28.575509Z",
            "level": "INFO",
            "message": "test_message",
            "jsonPayload": {
              "host": "test_host",
              "request_id": "1234"
            }
          }
        ],
        "nextPageToken": "KLUv..."
      }
      ```

{% endlist %}
