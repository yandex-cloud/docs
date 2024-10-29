---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Instance/getSerialPortOutput.md
---

# Compute Cloud API, gRPC: InstanceService.GetSerialPortOutput {#GetSerialPortOutput}

Returns the serial port output of the specified Instance resource.

## gRPC request

**rpc GetSerialPortOutput ([GetInstanceSerialPortOutputRequest](#yandex.cloud.compute.v1.GetInstanceSerialPortOutputRequest)) returns ([GetInstanceSerialPortOutputResponse](#yandex.cloud.compute.v1.GetInstanceSerialPortOutputResponse))**

## GetInstanceSerialPortOutputRequest {#yandex.cloud.compute.v1.GetInstanceSerialPortOutputRequest}

```json
{
  "instanceId": "string",
  "port": "int64"
}
```

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the instance to return the serial port output for. ||
|| port | **int64**

Serial port to retrieve data from. The default is 1. ||
|#

## GetInstanceSerialPortOutputResponse {#yandex.cloud.compute.v1.GetInstanceSerialPortOutputResponse}

```json
{
  "contents": "string"
}
```

#|
||Field | Description ||
|| contents | **string**

The contents of the serial port output, starting from the time when the instance
started to boot. ||
|#