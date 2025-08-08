---
editable: false
apiPlayground:
  - url: https://{{ api-host-iot-data }}/iot-devices/v1/devices/{deviceId}/publish
    method: post
    path:
      type: object
      properties:
        deviceId:
          description: |-
            **string**
            Required field. ID of device publishing message
          type: string
      required:
        - deviceId
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
sourcePath: en/_api-ref/iot/devices/v1/api-ref/DeviceData/publish.md
---

# IoT Core Service, REST: DeviceData.Publish

Publishes message on behalf of specified device

## HTTP request

```
POST https://{{ api-host-iot-data }}/iot-devices/v1/devices/{deviceId}/publish
```

## Path parameters

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of device publishing message ||
|#

## Body parameters {#yandex.cloud.iot.devices.v1.PublishDeviceDataRequest}

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

## Response {#yandex.cloud.iot.devices.v1.PublishDeviceDataResponse}

**HTTP Code: 200 - OK**