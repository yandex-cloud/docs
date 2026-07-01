---
editable: false
---

# IoT Core Broker Service, gRPC: BrokerDataService.Publish

Publishes message on behalf of specified broker

## gRPC request

**rpc Publish ([PublishBrokerDataRequest](#yandex.cloud.iot.broker.v1.PublishBrokerDataRequest)) returns ([PublishBrokerDataResponse](#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse))**

## PublishBrokerDataRequest {#yandex.cloud.iot.broker.v1.PublishBrokerDataRequest}

```json
{
  "broker_id": "string",
  "topic": "string",
  "data": "bytes"
}
```

#|
||Field | Description ||
|| broker_id | **string**

Required field. ID of broker publishing message

The maximum string length in characters is 50. ||
|| topic | **string**

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **bytes**

Content of the message

The maximum string length in characters is 262144. ||
|#

## PublishBrokerDataResponse {#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#