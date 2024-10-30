---
editable: false
sourcePath: en/_api-ref-grpc/iot/broker/v1/broker/api-ref/grpc/BrokerData/publish.md
---

# IoT Core Broker Service, gRPC: BrokerDataService.Publish {#Publish}

Publishes message on behalf of specified broker

## gRPC request

**rpc Publish ([PublishBrokerDataRequest](#yandex.cloud.iot.broker.v1.PublishBrokerDataRequest)) returns ([PublishBrokerDataResponse](#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse))**

## PublishBrokerDataRequest {#yandex.cloud.iot.broker.v1.PublishBrokerDataRequest}

```json
{
  "brokerId": "string",
  "topic": "string",
  "data": "bytes"
}
```

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of broker publishing message ||
|| topic | **string**

Required field. Topic where message should be published ||
|| data | **bytes**

Content of the message ||
|#

## PublishBrokerDataResponse {#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#