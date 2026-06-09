# Cloud Interconnect API, REST: Partner.Get

Returns the specified Partner resource.
To get the list of available Partner resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/partners/{partnerId}
```

## Path parameters

#|
||Field | Description ||
|| partnerId | **string**

Required field. ID of the Partner resource to return.
To get the partner ID use a [PartnerService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.cic.v1.Partner}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "url": "string",
  "popIds": [
    "string"
  ],
  "status": "string"
}
```

A Partner resource.

#|
||Field | Description ||
|| id | **string**

ID of the partner. ||
|| name | **string**

Name of the partner. ||
|| url | **string**

Link to info about the partner. ||
|| popIds[] | **string**

List of pointOfPresence IDs that the partner is connected to. ||
|| status | **enum** (Status)

Status of the partner.

- `UP`: Partner is up and operational.
- `DOWN`: Partner is down and not operational. ||
|#