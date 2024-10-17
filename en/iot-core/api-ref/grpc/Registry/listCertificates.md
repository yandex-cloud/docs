---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listCertificates.md
---

# IoT Core Service, gRPC: RegistryService.ListCertificates {#ListCertificates}

Retrieves the list of registry certificates for the specified registry.

## gRPC request

**rpc ListCertificates ([ListRegistryCertificatesRequest](#yandex.cloud.iot.devices.v1.ListRegistryCertificatesRequest)) returns ([ListRegistryCertificatesResponse](#yandex.cloud.iot.devices.v1.ListRegistryCertificatesResponse))**

## ListRegistryCertificatesRequest {#yandex.cloud.iot.devices.v1.ListRegistryCertificatesRequest}

```json
{
  "registryId": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to list certificates for. ||
|#

## ListRegistryCertificatesResponse {#yandex.cloud.iot.devices.v1.ListRegistryCertificatesResponse}

```json
{
  "certificates": [
    {
      "registryId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| certificates[] | **[RegistryCertificate](#yandex.cloud.iot.devices.v1.RegistryCertificate)**

List of certificates for the specified registry. ||
|#

## RegistryCertificate {#yandex.cloud.iot.devices.v1.RegistryCertificate}

A registry certificate. For more information, see [Managing registry certificates](/docs/iot-core/operations/certificates/registry-certificates).

#|
||Field | Description ||
|| registryId | **string**

ID of the registry that the certificate belongs to. ||
|| fingerprint | **string**

SHA256 hash of the certificates. ||
|| certificateData | **string**

Public part of the certificate. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#