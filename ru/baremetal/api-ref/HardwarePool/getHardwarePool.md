---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/zones/{zoneId}/hardwarePools/{hardwarePoolId}
    method: get
    path:
      type: object
      properties:
        zoneId:
          description: |-
            **string**
            ID of the zone where the hardware pool is located.
            To get the zone ID, use a [ZoneService.List] request.
            The maximum string length in characters is 20.
          type: string
        hardwarePoolId:
          description: |-
            **string**
            ID of the HardwarePool resource to return.
            To get the hardware pool ID, use a [HardwarePoolService.List] request.
            The maximum string length in characters is 20.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: HardwarePool.GetHardwarePool

Returns the specific HardwarePool resource.

To get the list of available HardwarePool resource, make a [List] request.


## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/zones/{zoneId}/hardwarePools/{hardwarePoolId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the zone where the hardware pool is located.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|| hardwarePoolId | **string**

Required field. ID of the HardwarePool resource to return.

To get the hardware pool ID, use a [HardwarePoolService.List] request.

The maximum string length in characters is 20. ||
|#

## Response {#yandex.cloud.baremetal.v2.HardwarePool}

**HTTP Code: 200 - OK**

```json
{
  "hardwarePoolId": "string",
  "zoneId": "string"
}
```

A HardwarePool resource.

#|
||Field | Description ||
|| hardwarePoolId | **string**

ID of the hardware pool. ||
|| zoneId | **string**

ID of the zone where the hardware pool is located.

To get the zone ID use a [ZoneService.List] request. ||
|#