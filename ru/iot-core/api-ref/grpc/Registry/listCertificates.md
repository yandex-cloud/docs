---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listCertificates.md
---

# IoT Core Service, gRPC: RegistryService.ListCertificates

Retrieves the list of registry certificates for the specified registry.

## gRPC request

**rpc ListCertificates ([ListRegistryCertificatesRequest](#yandex.cloud.iot.devices.v1.ListRegistryCertificatesRequest)) returns ([ListRegistryCertificatesResponse](#yandex.cloud.iot.devices.v1.ListRegistryCertificatesResponse))**

## ListRegistryCertificatesRequest {#yandex.cloud.iot.devices.v1.ListRegistryCertificatesRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry to list certificates for. ||
|#

## ListRegistryCertificatesResponse {#yandex.cloud.iot.devices.v1.ListRegistryCertificatesResponse}

```json
{
  "certificates": [
    {
      "registry_id": "string",
      "fingerprint": "string",
      "certificate_data": "string",
      "created_at": "google.protobuf.Timestamp"
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
|| registry_id | **string**

ID of the registry that the certificate belongs to. ||
|| fingerprint | **string**

SHA256 hash of the certificates. ||
|| certificate_data | **string**

Public part of the certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#