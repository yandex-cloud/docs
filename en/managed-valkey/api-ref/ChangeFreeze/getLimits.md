---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-redis/v1/changeFreezeLimits
    method: get
    path: null
    query:
      type: object
      properties:
        resourceId:
          description: |-
            **string**
            Required field. ID of the resource to get change freeze limits for.
            The maximum string length in characters is 50.
          type: string
      required:
        - resourceId
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for Redis API, REST: ChangeFreeze.GetLimits

Retrieves change freeze limits for the specified resource.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/changeFreezeLimits
```

## Query parameters {#yandex.cloud.maintenance.v2.GetChangeFreezeLimitsRequest}

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource to get change freeze limits for.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.maintenance.v2.ChangeFreezeLimitsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resourceId": "string",
  "constraints": {
    "yearlyLimitSeconds": "string",
    "maxPeriodSeconds": "string",
    "minGapSeconds": "string",
    "maxAdvanceSeconds": "string"
  },
  "usedSecondsThisYear": "string",
  "remainingSecondsThisYear": "string"
}
```

#|
||Field | Description ||
|| resourceId | **string**

ID of the resource. ||
|| constraints | **[ChangeFreezeConstraints](#yandex.cloud.maintenance.v2.ChangeFreezeConstraints)**

Constraints for change freezes. ||
|| usedSecondsThisYear | **string** (int64)

Number of seconds already used this year. ||
|| remainingSecondsThisYear | **string** (int64)

Number of seconds remaining this year. ||
|#

## ChangeFreezeConstraints {#yandex.cloud.maintenance.v2.ChangeFreezeConstraints}

#|
||Field | Description ||
|| yearlyLimitSeconds | **string** (int64)

Maximum total duration of change freezes per year, in seconds. ||
|| maxPeriodSeconds | **string** (int64)

Maximum duration of a single change freeze, in seconds. ||
|| minGapSeconds | **string** (int64)

Minimum gap between change freezes, in seconds. ||
|| maxAdvanceSeconds | **string** (int64)

Maximum advance time for scheduling a change freeze, in seconds. ||
|#