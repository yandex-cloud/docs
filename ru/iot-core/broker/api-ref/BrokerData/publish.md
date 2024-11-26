---
editable: false
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/BrokerData/publish.md
---

# IoT Core Broker Service, REST: BrokerData.Publish

Publishes message on behalf of specified broker

## HTTP request

```
POST https://iot-data.{{ api-host }}/iot-broker/v1/brokers/{brokerId}/publish
```

## Path parameters

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of broker publishing message ||
|#

## Body parameters {#yandex.cloud.iot.broker.v1.PublishBrokerDataRequest}

```json
{
  "topic": "string",
  "data": "string"
}
```

#|
||Field | Description ||
|| topic | **string**

Required field. Topic where message should be published ||
|| data | **string** (bytes)

Content of the message ||
|#

## Response {#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse}

**HTTP Code: 200 - OK**