[Документация Yandex Cloud](../../../../index.md) > [Yandex IoT Core](../../../index.md) > Справочник API Broker > [REST (англ.)](../index.md) > [BrokerData](index.md) > Publish

# IoT Core Broker Service, REST: BrokerData.Publish

Publishes message on behalf of specified broker

## HTTP request

```
POST https://iot-data.api.cloud.yandex.net/iot-broker/v1/brokers/{brokerId}/publish
```

## Path parameters

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of broker publishing message

The maximum string length in characters is 50. ||
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

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **string** (bytes)

Content of the message

The maximum string length in characters is 262144. ||
|#

## Response {#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse}

**HTTP Code: 200 - OK**