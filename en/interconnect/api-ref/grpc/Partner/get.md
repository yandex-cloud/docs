---
editable: false
---

# Cloud Interconnect API, gRPC: PartnerService.Get

Returns the specified Partner resource.
To get the list of available Partner resources, make a [List](/docs/interconnect/api-ref/grpc/Partner/list#List) request.

## gRPC request

**rpc Get ([GetPartnerRequest](#yandex.cloud.cic.v1.GetPartnerRequest)) returns ([Partner](#yandex.cloud.cic.v1.Partner))**

## GetPartnerRequest {#yandex.cloud.cic.v1.GetPartnerRequest}

```json
{
  "partner_id": "string"
}
```

#|
||Field | Description ||
|| partner_id | **string**

Required field. ID of the Partner resource to return.
To get the partner ID use a [PartnerService.List](/docs/interconnect/api-ref/grpc/Partner/list#List) request.

The maximum string length in characters is 50. ||
|#

## Partner {#yandex.cloud.cic.v1.Partner}

```json
{
  "id": "string",
  "name": "string",
  "url": "string",
  "pop_ids": [
    "string"
  ],
  "status": "Status"
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
|| pop_ids[] | **string**

List of pointOfPresence IDs that the partner is connected to. ||
|| status | enum **Status**

Status of the partner.

- `UP`: Partner is up and operational.
- `DOWN`: Partner is down and not operational. ||
|#