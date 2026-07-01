---
editable: false
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

Required field. ID of registry publishing message

The maximum string length in characters is 50. ||
|| topic | **string**

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **bytes**

Content of the message

The maximum string length in characters is 262144. ||
|#

## PublishRegistryDataResponse {#yandex.cloud.iot.devices.v1.PublishRegistryDataResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#