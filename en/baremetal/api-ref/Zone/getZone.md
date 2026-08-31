---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/zones/{zoneId}
    method: get
    path:
      type: object
      properties:
        zoneId:
          description: |-
            **string**
            ID of the Zone resource to return.
            To get the zone ID, use a [ZoneService.List] request.
            The maximum string length in characters is 20.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: Zone.GetZone


https://google.aip.dev/130 --)
Returns the specific Zone resource.

To get the list of Zone resources, make a [List] request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/zones/{zoneId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the Zone resource to return.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|#

## Response {#yandex.cloud.baremetal.v2.Zone}

**HTTP Code: 200 - OK**

```json
{
  "zoneId": "string"
}
```

Availability zone.

#|
||Field | Description ||
|| zoneId | **string**

ID of the Zone. ||
|#