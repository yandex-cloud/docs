---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/addDataStreamExport.md
---

# IoT Core Service, gRPC: RegistryService.AddDataStreamExport {#AddDataStreamExport}

Adds YDS export for the specified registry.

## gRPC request

**rpc AddDataStreamExport ([AddDataStreamExportRequest](#yandex.cloud.iot.devices.v1.AddDataStreamExportRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddDataStreamExportRequest {#yandex.cloud.iot.devices.v1.AddDataStreamExportRequest}

```json
{
  "name": "string",
  "registryId": "string",
  "mqttTopicFilter": "string",
  "database": "string",
  "stream": "string",
  "serviceAccountId": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the YDS export. The name must be unique within the folder. ||
|| registryId | **string**

Required field. ID of the registry to add a YDS export for.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|| mqttTopicFilter | **string**

MQTT topic whose messages export to YDS. ||
|| database | **string**

Required field. YDS database. ||
|| stream | **string**

Required field. YDS stream name. ||
|| serviceAccountId | **string**

Required field. ID of the service account which has permission to write to data stream. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "registryId": "string",
    "dataStreamExportId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "registryId": "string",
    "mqttTopicFilter": "string",
    "database": "string",
    "stream": "string",
    "serviceAccountId": "string",
    "createdAt": "google.protobuf.Timestamp"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddDataStreamExportMetadata](#yandex.cloud.iot.devices.v1.AddDataStreamExportMetadata)**

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
|| response | **[DataStreamExport](#yandex.cloud.iot.devices.v1.DataStreamExport)**

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

## AddDataStreamExportMetadata {#yandex.cloud.iot.devices.v1.AddDataStreamExportMetadata}

#|
||Field | Description ||
|| registryId | **string**

ID of the registry for which the YDS export was added. ||
|| dataStreamExportId | **string**

ID of the added YDS export. ||
|#

## DataStreamExport {#yandex.cloud.iot.devices.v1.DataStreamExport}

A Yandex Data Streams export.

#|
||Field | Description ||
|| id | **string**

ID of the YDS export. ||
|| name | **string**

Name of the YDS export. ||
|| registryId | **string**

ID of the registry that the YDS export belongs to. ||
|| mqttTopicFilter | **string**

MQTT topic whose messages export to YDS. ||
|| database | **string**

YDS database. ||
|| stream | **string**

YDS stream name. ||
|| serviceAccountId | **string**

ID of the service account which has permission to write to data stream. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#