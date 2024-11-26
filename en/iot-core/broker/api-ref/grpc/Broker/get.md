---
editable: false
sourcePath: en/_api-ref-grpc/iot/broker/v1/broker/api-ref/grpc/Broker/get.md
---

# IoT Core Broker Service, gRPC: BrokerService.Get

Returns the specified broker.

To get the list of available brokers, make a [List](/docs/iot-core/broker/api-ref/grpc/Broker/list#List) request.

## gRPC request

**rpc Get ([GetBrokerRequest](#yandex.cloud.iot.broker.v1.GetBrokerRequest)) returns ([Broker](#yandex.cloud.iot.broker.v1.Broker))**

## GetBrokerRequest {#yandex.cloud.iot.broker.v1.GetBrokerRequest}

```json
{
  "broker_id": "string"
}
```

#|
||Field | Description ||
|| broker_id | **string**

Required field. ID of the broker to return.

To get a broker ID make a [BrokerService.List](/docs/iot-core/broker/api-ref/grpc/Broker/list#List) request. ||
|#

## Broker {#yandex.cloud.iot.broker.v1.Broker}

```json
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
```

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