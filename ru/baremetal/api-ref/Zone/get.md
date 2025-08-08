---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/zones/{zoneId}
    method: get
    path:
      type: object
      properties:
        zoneId:
          description: |-
            **string**
            ID of the Zone resource to return.
            To get the zone ID, use a [ZoneService.List](/docs/baremetal/api-ref/Zone/list#List) request.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Zone/get.md
---

# BareMetal API, REST: Zone.Get

Returns the specific Zone resource.

To get the list of Zone resources, make a [List](/docs/baremetal/api-ref/Zone/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/zones/{zoneId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the Zone resource to return.

To get the zone ID, use a [ZoneService.List](/docs/baremetal/api-ref/Zone/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.Zone}

**HTTP Code: 200 - OK**

```json
{
  "id": "string"
}
```

Availability zone.

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|#