# IoT Core Service, gRPC: RegistryService.AddDataStreamExport

Adds YDS export for the specified registry.

## gRPC request

**rpc AddDataStreamExport ([AddDataStreamExportRequest](#yandex.cloud.iot.devices.v1.AddDataStreamExportRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddDataStreamExportRequest {#yandex.cloud.iot.devices.v1.AddDataStreamExportRequest}

```json
{
  "name": "string",
  "registry_id": "string",
  "mqtt_topic_filter": "string",
  "database": "string",
  "stream": "string",
  "service_account_id": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the YDS export. The name must be unique within the folder.

The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| registry_id | **string**

Required field. ID of the registry to add a YDS export for.
To get a registry ID make a [RegistryService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| mqtt_topic_filter | **string**

MQTT topic whose messages export to YDS.

The maximum string length in characters is 1024. ||
|| database | **string**

Required field. YDS database.

The maximum string length in characters is 512. ||
|| stream | **string**

Required field. YDS stream name.

The maximum string length in characters is 512. ||
|| service_account_id | **string**

Required field. ID of the service account which has permission to write to data stream.

The maximum string length in characters is 50. ||
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