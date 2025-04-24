---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Bus/get.md
---

# EventRouter Service, gRPC: BusService.Get

Returns the specified bus.
To get the list of all available buses, make a [List](/docs/serverless-integrations/eventrouter/api-ref/grpc/Bus/list#List) request.

## gRPC request

**rpc Get ([GetBusRequest](#yandex.cloud.serverless.eventrouter.v1.GetBusRequest)) returns ([Bus](#yandex.cloud.serverless.eventrouter.v1.Bus))**

## GetBusRequest {#yandex.cloud.serverless.eventrouter.v1.GetBusRequest}

```json
{
  "bus_id": "string"
}
```

#|
||Field | Description ||
|| bus_id | **string**

Required field. ID of the bus to get. ||
|#

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

```json
{
  "id": "string",
  "folder_id": "string",
  "cloud_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "deletion_protection": "bool",
  "status": "Status",
  "logging_enabled": "bool",
  "log_options": {
    // Includes only one of the fields `log_group_id`, `folder_id`
    "log_group_id": "string",
    "folder_id": "string",
    // end of the list of possible fields
    "min_level": "Level",
    "service_account_id": "string"
  }
}
```

#|
||Field | Description ||
|| id | **string**

ID of the bus. ||
|| folder_id | **string**

ID of the folder that the bus belongs to. ||
|| cloud_id | **string**

ID of the cloud that the bus resides in. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the bus. ||
|| description | **string**

Description of the bus. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| deletion_protection | **bool**

Deletion protection. ||
|| status | enum **Status**

Status of the bus.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `ACTIVE`
- `DELETING` ||
|| logging_enabled | **bool**

Is logging from the bus enabled. ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.eventrouter.v1.LogOptions)**

Options for logging from the bus. ||
|#

## LogOptions {#yandex.cloud.serverless.eventrouter.v1.LogOptions}

#|
||Field | Description ||
|| log_group_id | **string**

Entry will be written to log group resolved by ID.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| folder_id | **string**

Entry will be written to default log group for specified folder.

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
|| service_account_id | **string**

Required field. Service account, which has permission to write to destination ||
|#