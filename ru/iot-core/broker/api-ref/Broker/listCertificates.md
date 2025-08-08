---
editable: false
apiPlayground:
  - url: https://{{ api-host-iot-broker }}/iot-broker/v1/brokers/{brokerId}/certificates
    method: get
    path:
      type: object
      properties:
        brokerId:
          description: |-
            **string**
            Required field. ID of the broker to list certificates for.
          type: string
      required:
        - brokerId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/Broker/listCertificates.md
---

# IoT Core Broker Service, REST: Broker.ListCertificates

Retrieves the list of broker certificates for the specified broker.

## HTTP request

```
GET https://{{ api-host-iot-broker }}/iot-broker/v1/brokers/{brokerId}/certificates
```

## Path parameters

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of the broker to list certificates for. ||
|#

## Response {#yandex.cloud.iot.broker.v1.ListBrokerCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificates": [
    {
      "brokerId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| certificates[] | **[BrokerCertificate](#yandex.cloud.iot.broker.v1.BrokerCertificate)**

List of certificates for the specified broker. ||
|#

## BrokerCertificate {#yandex.cloud.iot.broker.v1.BrokerCertificate}

A broker certificate.

#|
||Field | Description ||
|| brokerId | **string**

ID of the broker that the certificate belongs to. ||
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