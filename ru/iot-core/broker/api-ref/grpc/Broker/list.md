---
editable: false
sourcePath: en/_api-ref-grpc/iot/broker/v1/broker/api-ref/grpc/Broker/list.md
---

# IoT Core Broker Service, gRPC: BrokerService.List

Retrieves the list of brokers in the specified folder.

## gRPC request

**rpc List ([ListBrokersRequest](#yandex.cloud.iot.broker.v1.ListBrokersRequest)) returns ([ListBrokersResponse](#yandex.cloud.iot.broker.v1.ListBrokersResponse))**

## ListBrokersRequest {#yandex.cloud.iot.broker.v1.ListBrokersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list brokers in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a [ListBrokersResponse.next_page_token](#yandex.cloud.iot.broker.v1.ListBrokersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListBrokersResponse.next_page_token](#yandex.cloud.iot.broker.v1.ListBrokersResponse) returned by a previous list request. ||
|#

## ListBrokersResponse {#yandex.cloud.iot.broker.v1.ListBrokersResponse}

```json
{
  "brokers": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "Status",
      "log_options": {
        "disabled": "bool",
        // Includes only one of the fields `log_group_id`, `folder_id`
        "log_group_id": "string",
        "folder_id": "string",
        // end of the list of possible fields
        "min_level": "Level"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| brokers[] | **[Broker](#yandex.cloud.iot.broker.v1.Broker)**

List of brokers. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListBrokersRequest.page_size](#yandex.cloud.iot.broker.v1.ListBrokersRequest), use `next_page_token` as the value
for the [ListBrokersRequest.page_token](#yandex.cloud.iot.broker.v1.ListBrokersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Broker {#yandex.cloud.iot.broker.v1.Broker}

A broker.

#|
||Field | Description ||
|| id | **string**

ID of the broker. ||
|| folder_id | **string**

ID of the folder that the broker belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the broker. The name is unique within the folder. ||
|| description | **string**

Description of the broker. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| status | enum **Status**

Status of the broker.

- `STATUS_UNSPECIFIED`
- `CREATING`: Broker is being created.
- `ACTIVE`: Broker is ready to use.
- `DELETING`: Broker is being deleted. ||
|| log_options | **[LogOptions](#yandex.cloud.iot.broker.v1.LogOptions)**

Options for logging broker events ||
|#

## LogOptions {#yandex.cloud.iot.broker.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from broker disabled. ||
|| log_group_id | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| folder_id | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| min_level | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#