---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/deletePassword.md
---

# IoT Core Service, gRPC: DeviceService.DeletePassword {#DeletePassword}

Deletes the specified password.

## gRPC request

**rpc DeletePassword ([DeleteDevicePasswordRequest](#yandex.cloud.iot.devices.v1.DeleteDevicePasswordRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DeleteDevicePasswordRequest {#yandex.cloud.iot.devices.v1.DeleteDevicePasswordRequest}

```json
{
  "deviceId": "string",
  "passwordId": "string"
}
```

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device to delete a password for.

To get a device ID make a [DeviceService.List](/docs/iot-core/api-ref/grpc/Device/list#List) request. ||
|| passwordId | **string**

Required field. ID of the password to delete.

To get a password ID make a [DeviceService.ListPasswords](/docs/iot-core/api-ref/grpc/Device/listPasswords#ListPasswords) request. ||
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
    "deviceId": "string",
    "passwordId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| metadata | **[DeleteDevicePasswordMetadata](#yandex.cloud.iot.devices.v1.DeleteDevicePasswordMetadata)**

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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## DeleteDevicePasswordMetadata {#yandex.cloud.iot.devices.v1.DeleteDevicePasswordMetadata}

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device for which the password is being deleted. ||
|| passwordId | **string**

Required field. ID of the password that is being deleted. ||
|#