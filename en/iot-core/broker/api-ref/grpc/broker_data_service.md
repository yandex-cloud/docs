---
editable: false
sourcePath: en/_api-ref-grpc/iot-core/broker/broker/api-ref/grpc/broker_data_service.md
---

# IoT Core Broker Service, gRPC: BrokerDataService

A set of methods to work with IoT Core messages on behalf of broker

| Call | Description |
| --- | --- |
| [Publish](#Publish) | Publishes message on behalf of specified broker |

## Calls BrokerDataService {#calls}

## Publish {#Publish}

Publishes message on behalf of specified broker

**rpc Publish ([PublishBrokerDataRequest](#PublishBrokerDataRequest)) returns ([PublishBrokerDataResponse](#PublishBrokerDataResponse))**

### PublishBrokerDataRequest {#PublishBrokerDataRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of broker publishing message The maximum string length in characters is 50.
topic | **string**<br>Required. Topic where message should be published The maximum string length in characters is 1024.
data | **bytes**<br>Content of the message The maximum string length in characters is 262144.


### PublishBrokerDataResponse {#PublishBrokerDataResponse}



