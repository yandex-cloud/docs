---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/listCertificates.md
---

# IoT Core Service, gRPC: DeviceService.ListCertificates

Retrieves the list of device certificates for the specified device.

## gRPC request

**rpc ListCertificates ([ListDeviceCertificatesRequest](#yandex.cloud.iot.devices.v1.ListDeviceCertificatesRequest)) returns ([ListDeviceCertificatesResponse](#yandex.cloud.iot.devices.v1.ListDeviceCertificatesResponse))**

## ListDeviceCertificatesRequest {#yandex.cloud.iot.devices.v1.ListDeviceCertificatesRequest}

```json
{
  "device_id": "string"
}
```

#|
||Field | Description ||
|| device_id | **string**

Required field. ID of the device to list certificates for. ||
|#

## ListDeviceCertificatesResponse {#yandex.cloud.iot.devices.v1.ListDeviceCertificatesResponse}

```json
{
  "certificates": [
    {
      "device_id": "string",
      "fingerprint": "string",
      "certificate_data": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| certificates[] | **[DeviceCertificate](#yandex.cloud.iot.devices.v1.DeviceCertificate)**

List of certificates for the specified device. ||
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