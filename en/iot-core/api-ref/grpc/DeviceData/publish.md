---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/DeviceData/publish.md
---

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

Required field. ID of device publishing message ||
|| topic | **string**

Required field. Topic where message should be published ||
|| data | **bytes**

Content of the message ||
|#

## PublishDeviceDataResponse {#yandex.cloud.iot.devices.v1.PublishDeviceDataResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#