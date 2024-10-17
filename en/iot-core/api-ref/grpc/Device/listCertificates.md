---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Device/listCertificates.md
---

# IoT Core Service, gRPC: DeviceService.ListCertificates {#ListCertificates}

Retrieves the list of device certificates for the specified device.

## gRPC request

**rpc ListCertificates ([ListDeviceCertificatesRequest](#yandex.cloud.iot.devices.v1.ListDeviceCertificatesRequest)) returns ([ListDeviceCertificatesResponse](#yandex.cloud.iot.devices.v1.ListDeviceCertificatesResponse))**

## ListDeviceCertificatesRequest {#yandex.cloud.iot.devices.v1.ListDeviceCertificatesRequest}

```json
{
  "deviceId": "string"
}
```

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device to list certificates for. ||
|#

## ListDeviceCertificatesResponse {#yandex.cloud.iot.devices.v1.ListDeviceCertificatesResponse}

```json
{
  "certificates": [
    {
      "deviceId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "google.protobuf.Timestamp"
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
|| deviceId | **string**

ID of the device that the certificate belongs to. ||
|| fingerprint | **string**

SHA256 hash of the certificate. ||
|| certificateData | **string**

Public part of the certificate. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#