---
editable: false
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Registry/listCertificates.md
---

# IoT Core Service, REST: Registry.ListCertificates

Retrieves the list of registry certificates for the specified registry.

## HTTP request

```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}/certificates
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry to list certificates for. ||
|#

## Response {#yandex.cloud.iot.devices.v1.ListRegistryCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificates": [
    {
      "registryId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#