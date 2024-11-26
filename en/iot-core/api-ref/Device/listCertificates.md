---
editable: false
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Device/listCertificates.md
---

# IoT Core Service, REST: Device.ListCertificates

Retrieves the list of device certificates for the specified device.

## HTTP request

```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/devices/{deviceId}/certificates
```

## Path parameters

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device to list certificates for. ||
|#

## Response {#yandex.cloud.iot.devices.v1.ListDeviceCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificates": [
    {
      "deviceId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#