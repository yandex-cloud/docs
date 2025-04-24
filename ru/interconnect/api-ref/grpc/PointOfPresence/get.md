---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/PointOfPresence/get.md
---

# Cloud Interconnect API, gRPC: PointOfPresenceService.Get

Returns the specified PointOfPresence resource.

To get the list of available PointOfPresence resources, make a [List](/docs/interconnect/api-ref/grpc/PointOfPresence/list#List) request.

## gRPC request

**rpc Get ([GetPointOfPresenceRequest](#yandex.cloud.cic.v1.GetPointOfPresenceRequest)) returns ([PointOfPresence](#yandex.cloud.cic.v1.PointOfPresence))**

## GetPointOfPresenceRequest {#yandex.cloud.cic.v1.GetPointOfPresenceRequest}

```json
{
  "point_of_presence_id": "string"
}
```

#|
||Field | Description ||
|| point_of_presence_id | **string**

Required field. ID of the PointOfPresence resource to return.
To get the pointOfPresence ID use a [PointOfPresenceService.List](/docs/interconnect/api-ref/grpc/PointOfPresence/list#List) request. ||
|#

## PointOfPresence {#yandex.cloud.cic.v1.PointOfPresence}

```json
{
  "id": "string",
  "region_id": "string"
}
```

A PointOfPresence resource.

#|
||Field | Description ||
|| id | **string**

ID of the pointOfPresence. ||
|| region_id | **string**

ID of the region that the pointOfPresence belongs to. ||
|#