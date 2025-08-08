---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:serialPortOutput
    method: get
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            Required field. ID of the instance to return the serial port output for.
          type: string
      required:
        - instanceId
      additionalProperties: false
    query:
      type: object
      properties:
        port:
          description: |-
            **string** (int64)
            Serial port to retrieve data from. The default is 1.
          type: string
          format: int64
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/Instance/getSerialPortOutput.md
---

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

Required field. ID of the instance to return the serial port output for. ||
|#

## Query parameters {#yandex.cloud.compute.v1.GetInstanceSerialPortOutputRequest}

#|
||Field | Description ||
|| port | **string** (int64)

Serial port to retrieve data from. The default is 1. ||
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