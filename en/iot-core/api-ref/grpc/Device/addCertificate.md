---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/addCertificate.md
---

# IoT Core Service, gRPC: DeviceService.AddCertificate

Adds a certificate.

## gRPC request

**rpc AddCertificate ([AddDeviceCertificateRequest](#yandex.cloud.iot.devices.v1.AddDeviceCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddDeviceCertificateRequest {#yandex.cloud.iot.devices.v1.AddDeviceCertificateRequest}

```json
{
  "device_id": "string",
  "certificate_data": "string"
}
```

#|
||Field | Description ||
|| device_id | **string**

Required field. ID of the device for which the certificate is being added.

To get a device ID make a [DeviceService.List](/docs/iot-core/api-ref/grpc/Device/list#List) request. ||
|| certificate_data | **string**

Public part of the certificate. ||
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
  "metadata": {
    "device_id": "string",
    "fingerprint": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "device_id": "string",
    "fingerprint": "string",
    "certificate_data": "string",
    "created_at": "google.protobuf.Timestamp"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddDeviceCertificateMetadata](#yandex.cloud.iot.devices.v1.AddDeviceCertificateMetadata)**

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
|| response | **[DeviceCertificate](#yandex.cloud.iot.devices.v1.DeviceCertificate)**

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

## AddDeviceCertificateMetadata {#yandex.cloud.iot.devices.v1.AddDeviceCertificateMetadata}

#|
||Field | Description ||
|| device_id | **string**

ID of the device certificate that is being added. ||
|| fingerprint | **string**

Fingerprint of the certificate that is being added. ||
|#

## DeviceCertificate {#yandex.cloud.iot.devices.v1.DeviceCertificate}

A device certificate. For more information, see [Managing device certificates](/docs/iot-core/operations/certificates/device-certificates).

#|
||Field | Description ||
|| device_id | **string**

ID of the device that the certificate belongs to. ||
|| fingerprint | **string**

SHA256 hash of the certificate. ||
|| certificate_data | **string**

Public part of the certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#