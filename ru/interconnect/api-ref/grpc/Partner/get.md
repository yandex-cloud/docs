---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/Partner/get.md
---

# Cloud Interconnect API, gRPC: PartnerService.Get

Returns the specified Partner resource.

To get the list of available Partner resources, make a [List](/docs/cic/workload/api-ref/grpc/Partner/list#List) request.

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
To get the partner ID use a [PartnerService.List](/docs/cic/workload/api-ref/grpc/Partner/list#List) request. ||
|#

## Partner {#yandex.cloud.cic.v1.Partner}

```json
{
  "id": "string",
  "region_id": "string",
  "status": "Status"
}
```

A Partner resource.

#|
||Field | Description ||
|| id | **string**

ID of the partner. ||
|| region_id | **string**

ID of the region that the partner belongs to. ||
|| status | enum **Status**

Status of the partner.

- `STATUS_UNSPECIFIED`
- `UP`
- `DOWN` ||
|#