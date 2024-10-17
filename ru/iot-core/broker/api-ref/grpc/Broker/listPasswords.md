---
editable: false
sourcePath: en/_api-ref-grpc/iot/broker/v1/broker/api-ref/grpc/Broker/listPasswords.md
---

# IoT Core Broker Service, gRPC: BrokerService.ListPasswords {#ListPasswords}

Retrieves the list of passwords for the specified broker.

## gRPC request

**rpc ListPasswords ([ListBrokerPasswordsRequest](#yandex.cloud.iot.broker.v1.ListBrokerPasswordsRequest)) returns ([ListBrokerPasswordsResponse](#yandex.cloud.iot.broker.v1.ListBrokerPasswordsResponse))**

## ListBrokerPasswordsRequest {#yandex.cloud.iot.broker.v1.ListBrokerPasswordsRequest}

```json
{
  "brokerId": "string"
}
```

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of the broker to list passwords in.

To get a broker ID make a [BrokerService.List](/docs/iot-core/broker/api-ref/grpc/Broker/list#List) request. ||
|#

## ListBrokerPasswordsResponse {#yandex.cloud.iot.broker.v1.ListBrokerPasswordsResponse}

```json
{
  "passwords": [
    {
      "brokerId": "string",
      "id": "string",
      "createdAt": "google.protobuf.Timestamp"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#