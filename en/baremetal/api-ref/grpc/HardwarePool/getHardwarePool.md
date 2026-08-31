---
editable: false
---

# BareMetal API, gRPC: HardwarePoolService.GetHardwarePool

Returns the specific HardwarePool resource.

To get the list of available HardwarePool resource, make a [List] request.

https://google.aip.dev/130 --)

## gRPC request

**rpc GetHardwarePool ([GetHardwarePoolRequest](#yandex.cloud.baremetal.v2.GetHardwarePoolRequest)) returns ([HardwarePool](#yandex.cloud.baremetal.v2.HardwarePool))**

## GetHardwarePoolRequest {#yandex.cloud.baremetal.v2.GetHardwarePoolRequest}

```json
{
  "zone_id": "string",
  "hardware_pool_id": "string"
}
```

#|
||Field | Description ||
|| zone_id | **string**

ID of the zone where the hardware pool is located.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|| hardware_pool_id | **string**

ID of the HardwarePool resource to return.

To get the hardware pool ID, use a [HardwarePoolService.List] request.

The maximum string length in characters is 20. ||
|#

## HardwarePool {#yandex.cloud.baremetal.v2.HardwarePool}

```json
{
  "hardware_pool_id": "string",
  "zone_id": "string"
}
```

A HardwarePool resource.

#|
||Field | Description ||
|| hardware_pool_id | **string**

ID of the hardware pool. ||
|| zone_id | **string**

ID of the zone where the hardware pool is located.

To get the zone ID use a [ZoneService.List] request. ||
|#