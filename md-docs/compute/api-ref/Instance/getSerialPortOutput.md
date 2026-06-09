# Compute Cloud API, REST: Instance.GetSerialPortOutput

Returns the serial port output of the specified Instance resource.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:serialPortOutput
```

## Path parameters

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the instance to return the serial port output for.
The length must be less than or equal to 50.
This field is required. ||
|#

## Query parameters {#yandex.cloud.compute.v1.GetInstanceSerialPortOutputRequest}

#|
||Field | Description ||
|| port | **string** (int64)

Serial port to retrieve data from. The default is 1.
The value must satisfy: 1,2,3,4. ||
|#

## Response {#yandex.cloud.compute.v1.GetInstanceSerialPortOutputResponse}

**HTTP Code: 200 - OK**

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