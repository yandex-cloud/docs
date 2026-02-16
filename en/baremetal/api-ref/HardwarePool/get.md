---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/hardwarePools/{hardwarePoolId}
    method: get
    path:
      type: object
      properties:
        hardwarePoolId:
          description: |-
            **string**
            ID of the HardwarePool resource to return.
            To get the hardware pool ID, use a [HardwarePoolService.List](/docs/baremetal/api-ref/HardwarePool/list#List) request.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/HardwarePool/get.md
---

# BareMetal API, REST: HardwarePool.Get

Returns the specific HardwarePool resource.

To get the list of available HardwarePool resource, make a [List](/docs/baremetal/api-ref/HardwarePool/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/hardwarePools/{hardwarePoolId}
```

## Path parameters

#|
||Field | Description ||
|| hardwarePoolId | **string**

Required field. ID of the HardwarePool resource to return.

To get the hardware pool ID, use a [HardwarePoolService.List](/docs/baremetal/api-ref/HardwarePool/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.HardwarePool}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "zoneId": "string"
}
```

A HardwarePool resource.

#|
||Field | Description ||
|| id | **string**

ID of the hardware pool. ||
|| zoneId | **string**

ID of the zone where the hardware pool is located.

To get the zone ID use a [ZoneService.List](/docs/baremetal/api-ref/Zone/list#List) request. ||
|#