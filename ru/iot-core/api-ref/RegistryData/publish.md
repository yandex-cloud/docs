---
editable: false
sourcePath: en/_api-ref/iot/devices/v1/api-ref/RegistryData/publish.md
---

# IoT Core Service, REST: RegistryData.Publish {#Publish}

Publishes message on behalf of specified registry

## HTTP request

```
POST https://{{ api-host-iot-data }}/iot-devices/v1/registries/{registryId}/publish
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of registry publishing message ||
|#

## Body parameters {#yandex.cloud.iot.devices.v1.PublishRegistryDataRequest}

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

## Response {#yandex.cloud.iot.devices.v1.PublishRegistryDataResponse}

**HTTP Code: 200 - OK**