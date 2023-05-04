---
editable: false
sourcePath: en/_api-ref-grpc/iot-core/api-ref/grpc/registry_data_service.md
---

# IoT Core Service, gRPC: RegistryDataService

A set of methods to work with IoT Core messages on behalf of registry

| Call | Description |
| --- | --- |
| [Publish](#Publish) | Publishes message on behalf of specified registry |

## Calls RegistryDataService {#calls}

## Publish {#Publish}

Publishes message on behalf of specified registry

**rpc Publish ([PublishRegistryDataRequest](#PublishRegistryDataRequest)) returns ([PublishRegistryDataResponse](#PublishRegistryDataResponse))**

### PublishRegistryDataRequest {#PublishRegistryDataRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of registry publishing message The maximum string length in characters is 50.
topic | **string**<br>Required. Topic where message should be published The maximum string length in characters is 1024.
data | **bytes**<br>Content of the message The maximum string length in characters is 262144.


### PublishRegistryDataResponse {#PublishRegistryDataResponse}

Empty

