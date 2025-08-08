---
editable: false
apiPlayground:
  - url: https://{{ api-host-iot-data }}/iot-devices/v1/registries/{registryId}/publish
    method: post
    path:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            Required field. ID of registry publishing message
          type: string
      required:
        - registryId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        topic:
          description: |-
            **string**
            Required field. Topic where message should be published
          type: string
        data:
          description: |-
            **string** (bytes)
            Content of the message
          type: string
          format: bytes
      required:
        - topic
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/iot/devices/v1/api-ref/RegistryData/publish.md
---

# IoT Core Service, REST: RegistryData.Publish

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