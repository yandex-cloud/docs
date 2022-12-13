---
editable: false
---

# IoT Core Service, gRPC: DeviceDataService

A set of methods to work with IoT Core messages on behalf of device

| Call | Description |
| --- | --- |
| [Publish](#Publish) | Publishes message on behalf of specified device |

## Calls DeviceDataService {#calls}

## Publish {#Publish}

Publishes message on behalf of specified device

**rpc Publish ([PublishDeviceDataRequest](#PublishDeviceDataRequest)) returns ([PublishDeviceDataResponse](#PublishDeviceDataResponse))**

### PublishDeviceDataRequest {#PublishDeviceDataRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of device publishing message The maximum string length in characters is 50.
topic | **string**<br>Required. Topic where message should be published The maximum string length in characters is 1024.
data | **bytes**<br>Content of the message The maximum string length in characters is 262144.


### PublishDeviceDataResponse {#PublishDeviceDataResponse}



