[Документация Yandex Cloud](../../../../index.md) > [Yandex IoT Core](../../../index.md) > Справочник API Devices > [gRPC (англ.)](../index.md) > [DeviceData](index.md) > Publish

# IoT Core Service, gRPC: DeviceDataService.Publish

Publishes message on behalf of specified device

## gRPC request

**rpc Publish ([PublishDeviceDataRequest](#yandex.cloud.iot.devices.v1.PublishDeviceDataRequest)) returns ([PublishDeviceDataResponse](#yandex.cloud.iot.devices.v1.PublishDeviceDataResponse))**

## PublishDeviceDataRequest {#yandex.cloud.iot.devices.v1.PublishDeviceDataRequest}

```json
{
  "device_id": "string",
  "topic": "string",
  "data": "bytes"
}
```

#|
||Field | Description ||
|| device_id | **string**

Required field. ID of device publishing message

The maximum string length in characters is 50. ||
|| topic | **string**

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **bytes**

Content of the message

The maximum string length in characters is 262144. ||
|#

## PublishDeviceDataResponse {#yandex.cloud.iot.devices.v1.PublishDeviceDataResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#