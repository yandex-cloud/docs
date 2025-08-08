---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/zones/{zoneId}
    method: get
    path:
      type: object
      properties:
        zoneId:
          description: |-
            **string**
            Required field. ID of the availability zone to return information about.
          type: string
      required:
        - zoneId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/Zone/get.md
---

# Compute Cloud API, REST: Zone.Get

Returns the information about the specified availability zone.

To get the list of availability zones, make a [List](/docs/compute/api-ref/Zone/list#List) request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/zones/{zoneId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone to return information about. ||
|#

## Response {#yandex.cloud.compute.v1.Zone}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "regionId": "string",
  "status": "string"
}
```

Availability zone. For more information, see [Availability zones](/docs/overview/concepts/geo-scope).

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|| regionId | **string**

ID of the region. ||
|| status | **enum** (Status)

Status of the zone.

- `STATUS_UNSPECIFIED`
- `UP`: Zone is available. You can access the resources allocated in this zone.
- `DOWN`: Zone is not available. ||
|#