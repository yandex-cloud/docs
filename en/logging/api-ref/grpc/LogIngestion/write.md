---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogIngestion/write.md
---

# Cloud Logging Service, gRPC: LogIngestionService.Write {#Write}

Write log entries to specified destination.

## gRPC request

**rpc Write ([WriteRequest](#yandex.cloud.logging.v1.WriteRequest)) returns ([WriteResponse](#yandex.cloud.logging.v1.WriteResponse))**

## WriteRequest {#yandex.cloud.logging.v1.WriteRequest}

```json
{
  "destination": {
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string"
    // end of the list of possible fields
  },
  "resource": {
    "type": "string",
    "id": "string"
  },
  "entries": [
    {
      "timestamp": "google.protobuf.Timestamp",
      "level": "Level",
      "message": "string",
      "jsonPayload": "google.protobuf.Struct",
      "streamName": "string"
    }
  ],
  "defaults": {
    "level": "Level",
    "jsonPayload": "google.protobuf.Struct",
    "streamName": "string"
  }
}
```

#|
||Field | Description ||
|| destination | **[Destination](#yandex.cloud.logging.v1.Destination)**

Required field. Log entries destination.

See [Destination](#yandex.cloud.logging.v1.Destination) for details. ||
|| resource | **[LogEntryResource](#yandex.cloud.logging.v1.LogEntryResource)**

Common resource (type, ID) specification for log entries. ||
|| entries[] | **[IncomingLogEntry](#yandex.cloud.logging.v1.IncomingLogEntry)**

List of log entries. ||
|| defaults | **[LogEntryDefaults](#yandex.cloud.logging.v1.LogEntryDefaults)**

Log entries defaults.

See [LogEntryDefaults](#yandex.cloud.logging.v1.LogEntryDefaults) for details. ||
|#

## Destination {#yandex.cloud.logging.v1.Destination}

#|
||Field | Description ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Entry destination. ||
|| folderId | **string**

Entry should be written to default log group for the folder.

Includes only one of the fields `logGroupId`, `folderId`.

Entry destination. ||
|#

## LogEntryResource {#yandex.cloud.logging.v1.LogEntryResource}

Log entry resource specification.

May be used either by services and by user.

#|
||Field | Description ||
|| type | **string**

Resource type, i.e., `serverless.function` ||
|| id | **string**

Resource ID, i.e., ID of the function producing logs. ||
|#

## IncomingLogEntry {#yandex.cloud.logging.v1.IncomingLogEntry}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Timestamp of the entry. ||
|| level | enum **Level**

Entry severity.

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
|| message | **string**

Entry text message. ||
|| jsonPayload | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

Entry annotation. ||
|| streamName | **string**

Entry stream name. ||
|#

## LogEntryDefaults {#yandex.cloud.logging.v1.LogEntryDefaults}

#|
||Field | Description ||
|| level | enum **Level**

Default entry severity.
Will be applied if entry level is unspecified.

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
|| jsonPayload | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

Default entry annotation.
Will be merged with entry annotation.
Any conflict will be resolved in favor of entry own annotation. ||
|| streamName | **string**

Entry stream name. ||
|#

## WriteResponse {#yandex.cloud.logging.v1.WriteResponse}

```json
{
  "errors": "google.rpc.Status"
}
```

#|
||Field | Description ||
|| errors | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation. ||
|#