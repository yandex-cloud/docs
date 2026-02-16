---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/addCertificate.md
---

# IoT Core Service, gRPC: RegistryService.AddCertificate

Adds a certificate.

## gRPC request

**rpc AddCertificate ([AddRegistryCertificateRequest](#yandex.cloud.iot.devices.v1.AddRegistryCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddRegistryCertificateRequest {#yandex.cloud.iot.devices.v1.AddRegistryCertificateRequest}

```json
{
  "registry_id": "string",
  "certificate_data": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry for which the certificate is being added.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|| certificate_data | **string**

Public part of the certificate that is being added. ||
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
    "registry_id": "string",
    "fingerprint": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "registry_id": "string",
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
|| metadata | **[AddRegistryCertificateMetadata](#yandex.cloud.iot.devices.v1.AddRegistryCertificateMetadata)**

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
|| response | **[RegistryCertificate](#yandex.cloud.iot.devices.v1.RegistryCertificate)**

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

## AddRegistryCertificateMetadata {#yandex.cloud.iot.devices.v1.AddRegistryCertificateMetadata}

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry certificate that is being added. ||
|| fingerprint | **string**

Fingerprint of the certificate that is being added. ||
|#

## RegistryCertificate {#yandex.cloud.iot.devices.v1.RegistryCertificate}

A registry certificate. For more information, see [Managing registry certificates](/docs/iot-core/operations/certificates/registry-certificates).

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry that the certificate belongs to. ||
|| fingerprint | **string**

SHA256 hash of the certificates. ||
|| certificate_data | **string**

Public part of the certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#