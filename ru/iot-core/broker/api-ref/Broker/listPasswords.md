---
editable: false
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/Broker/listPasswords.md
---

# IoT Core Broker Service, REST: Broker.ListPasswords

Retrieves the list of passwords for the specified broker.

## HTTP request

```
GET https://{{ api-host-iot-broker }}/iot-broker/v1/brokers/{brokerId}/passwords
```

## Path parameters

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of the broker to list passwords in.

To get a broker ID make a [BrokerService.List](/docs/iot-core/broker/api-ref/Broker/list#List) request. ||
|#

## Response {#yandex.cloud.iot.broker.v1.ListBrokerPasswordsResponse}

**HTTP Code: 200 - OK**

```json
{
  "passwords": [
    {
      "brokerId": "string",
      "id": "string",
      "createdAt": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| passwords[] | **[BrokerPassword](#yandex.cloud.iot.broker.v1.BrokerPassword)**

List of passwords for the specified broker. ||
|#

## BrokerPassword {#yandex.cloud.iot.broker.v1.BrokerPassword}

A broker password.

#|
||Field | Description ||
|| brokerId | **string**

ID of the broker that the password belongs to. ||
|| id | **string**

ID of the password. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#