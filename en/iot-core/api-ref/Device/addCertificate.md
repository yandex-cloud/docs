---
editable: false
apiPlayground:
  - url: https://iot-devices.{{ api-host }}/iot-devices/v1/devices/{deviceId}/certificates
    method: post
    path:
      type: object
      properties:
        deviceId:
          description: |-
            **string**
            Required field. ID of the device for which the certificate is being added.
            To get a device ID make a [DeviceService.List](/docs/iot-core/api-ref/Device/list#List) request.
          type: string
      required:
        - deviceId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        certificateData:
          description: |-
            **string**
            Public part of the certificate.
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Device/addCertificate.md
---

# IoT Core Service, REST: Device.AddCertificate

Adds a certificate.

## HTTP request

```
POST https://iot-devices.{{ api-host }}/iot-devices/v1/devices/{deviceId}/certificates
```

## Path parameters

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of the device for which the certificate is being added.

To get a device ID make a [DeviceService.List](/docs/iot-core/api-ref/Device/list#List) request. ||
|#

## Body parameters {#yandex.cloud.iot.devices.v1.AddDeviceCertificateRequest}

```json
{
  "certificateData": "string"
}
```

#|
||Field | Description ||
|| certificateData | **string**

Public part of the certificate. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "deviceId": "string",
    "fingerprint": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "deviceId": "string",
    "fingerprint": "string",
    "certificateData": "string",
    "createdAt": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddDeviceCertificateMetadata](#yandex.cloud.iot.devices.v1.AddDeviceCertificateMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| deviceId | **string**

ID of the device certificate that is being added. ||
|| fingerprint | **string**

Fingerprint of the certificate that is being added. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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