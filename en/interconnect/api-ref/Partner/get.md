---
editable: false
sourcePath: en/_api-ref/cic/v1/api-ref/Partner/get.md
---

# Cloud Interconnect API, REST: Partner.Get

Returns the specified Partner resource.

To get the list of available Partner resources, make a [List](/docs/cic/workload/api-ref/Partner/list#List) request.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/partners/{partnerId}
```

## Path parameters

#|
||Field | Description ||
|| partnerId | **string**

Required field. ID of the Partner resource to return.
To get the partner ID use a [PartnerService.List](/docs/cic/workload/api-ref/Partner/list#List) request. ||
|#

## Response {#yandex.cloud.cic.v1.Partner}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "regionId": "string",
  "status": "string"
}
```

A Partner resource.

#|
||Field | Description ||
|| id | **string**

ID of the partner. ||
|| regionId | **string**

ID of the region that the partner belongs to. ||
|| status | **enum** (Status)

Status of the partner.

- `STATUS_UNSPECIFIED`
- `UP`
- `DOWN` ||
|#