---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/RegistryData/publish.md
---

# IoT Core Service, gRPC: RegistryDataService.Publish

Publishes message on behalf of specified registry

## gRPC request

**rpc Publish ([PublishRegistryDataRequest](#yandex.cloud.iot.devices.v1.PublishRegistryDataRequest)) returns ([PublishRegistryDataResponse](#yandex.cloud.iot.devices.v1.PublishRegistryDataResponse))**

## PublishRegistryDataRequest {#yandex.cloud.iot.devices.v1.PublishRegistryDataRequest}

```json
{
  "registry_id": "string",
  "topic": "string",
  "data": "bytes"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of registry publishing message ||
|| topic | **string**

Required field. Topic where message should be published ||
|| data | **bytes**

Content of the message ||
|#

## PublishRegistryDataResponse {#yandex.cloud.iot.devices.v1.PublishRegistryDataResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#