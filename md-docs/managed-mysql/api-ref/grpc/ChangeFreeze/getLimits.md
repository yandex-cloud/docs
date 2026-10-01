[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for MySQL®](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [ChangeFreeze](index.md) > GetLimits

# Managed Service for MySQL API, gRPC: ChangeFreezeService.GetLimits

Retrieves change freeze limits for the specified resource.

## gRPC request

**rpc GetLimits ([maintenance.v2.GetChangeFreezeLimitsRequest](#yandex.cloud.maintenance.v2.GetChangeFreezeLimitsRequest)) returns ([maintenance.v2.ChangeFreezeLimitsResponse](#yandex.cloud.maintenance.v2.ChangeFreezeLimitsResponse))**

## maintenance.v2.GetChangeFreezeLimitsRequest {#yandex.cloud.maintenance.v2.GetChangeFreezeLimitsRequest}

```json
{
  "resource_id": "string"
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource to get change freeze limits for.

The maximum string length in characters is 50. ||
|#

## maintenance.v2.ChangeFreezeLimitsResponse {#yandex.cloud.maintenance.v2.ChangeFreezeLimitsResponse}

```json
{
  "resource_id": "string",
  "constraints": {
    "yearly_limit_seconds": "int64",
    "max_period_seconds": "int64",
    "min_gap_seconds": "int64",
    "max_advance_seconds": "int64"
  },
  "used_seconds_this_year": "int64",
  "remaining_seconds_this_year": "int64"
}
```

#|
||Field | Description ||
|| resource_id | **string**

ID of the resource. ||
|| constraints | **[ChangeFreezeConstraints](#yandex.cloud.maintenance.v2.ChangeFreezeConstraints)**

Constraints for change freezes. ||
|| used_seconds_this_year | **int64**

Number of seconds already used this year. ||
|| remaining_seconds_this_year | **int64**

Number of seconds remaining this year. ||
|#

## ChangeFreezeConstraints {#yandex.cloud.maintenance.v2.ChangeFreezeConstraints}

#|
||Field | Description ||
|| yearly_limit_seconds | **int64**

Maximum total duration of change freezes per year, in seconds. ||
|| max_period_seconds | **int64**

Maximum duration of a single change freeze, in seconds. ||
|| min_gap_seconds | **int64**

Minimum gap between change freezes, in seconds. ||
|| max_advance_seconds | **int64**

Maximum advance time for scheduling a change freeze, in seconds. ||
|#