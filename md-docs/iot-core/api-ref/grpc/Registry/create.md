# IoT Core Service, gRPC: RegistryService.Create

Creates a registry in the specified folder.

## gRPC request

**rpc Create ([CreateRegistryRequest](#yandex.cloud.iot.devices.v1.CreateRegistryRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateRegistryRequest {#yandex.cloud.iot.devices.v1.CreateRegistryRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "certificates": [
    {
      "certificate_data": "string"
    }
  ],
  "password": "string",
  "log_options": {
    // Includes only one of the fields `log_group_id`, `folder_id`
    "log_group_id": "string",
    "folder_id": "string",
    // end of the list of possible fields
    "disabled": "bool",
    "min_level": "Level"
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a registry in.
To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the registry. The name must be unique within the folder.

The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the registry.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| certificates[] | **[Certificate](#yandex.cloud.iot.devices.v1.CreateRegistryRequest.Certificate)**

Registry certificates. ||
|| password | **string**

Registry passwords.
The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. ||
|| log_options | **[LogOptions](#yandex.cloud.iot.devices.v1.LogOptions)**

Options for logging registry events ||
|#

## Certificate {#yandex.cloud.iot.devices.v1.CreateRegistryRequest.Certificate}

Specification of a registry certificate.

#|
||Field | Description ||
|| certificate_data | **string**

Public part of the registry certificate. ||
|#

## LogOptions {#yandex.cloud.iot.devices.v1.LogOptions}

#|
||Field | Description ||
|| log_group_id | **string**

Entry should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| folder_id | **string**

Entry should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| disabled | **bool**

Is logging from registry disabled. ||
|| min_level | enum **Level**

Minimum log entry level.
See [LogLevel.Level](../../../../logging/api-ref/grpc/Export/get.md#yandex.cloud.logging.v1.LogLevel.Level) for details.

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#