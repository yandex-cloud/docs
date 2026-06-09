# Compute Cloud API, gRPC: InstanceService.GetSerialPortOutput

Returns the serial port output of the specified Instance resource.

## gRPC request

**rpc GetSerialPortOutput ([GetInstanceSerialPortOutputRequest](#yandex.cloud.compute.v1.GetInstanceSerialPortOutputRequest)) returns ([GetInstanceSerialPortOutputResponse](#yandex.cloud.compute.v1.GetInstanceSerialPortOutputResponse))**

## GetInstanceSerialPortOutputRequest {#yandex.cloud.compute.v1.GetInstanceSerialPortOutputRequest}

```json
{
  "instance_id": "string",
  "port": "int64"
}
```

#|
||Field | Description ||
|| instance_id | **string**

ID of the instance to return the serial port output for.
The length must be less than or equal to 50.
This field is required. ||
|| port | **int64**

Serial port to retrieve data from. The default is 1.
The value must satisfy: 1,2,3,4. ||
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