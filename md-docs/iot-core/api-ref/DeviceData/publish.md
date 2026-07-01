# IoT Core Service, REST: DeviceData.Publish

Publishes message on behalf of specified device

## HTTP request

```
POST https://iot-data.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}/publish
```

## Path parameters

#|
||Field | Description ||
|| deviceId | **string**

Required field. ID of device publishing message

The maximum string length in characters is 50. ||
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

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **string** (bytes)

Content of the message

The maximum string length in characters is 262144. ||
|#

## Response {#yandex.cloud.iot.devices.v1.PublishDeviceDataResponse}

**HTTP Code: 200 - OK**