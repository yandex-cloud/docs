---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Bus/get.md
---

# EventRouter Service, gRPC: BusService.Get {#Get}

Returns the specified bus.
To get the list of all available buses, make a [List](/docs/functions/eventrouter/api-ref/grpc/Bus/list#List) request.

## gRPC request

**rpc Get ([GetBusRequest](#yandex.cloud.serverless.eventrouter.v1.GetBusRequest)) returns ([Bus](#yandex.cloud.serverless.eventrouter.v1.Bus))**

## GetBusRequest {#yandex.cloud.serverless.eventrouter.v1.GetBusRequest}

```json
{
  "busId": "string"
}
```

#|
||Field | Description ||
|| busId | **string**

Required field. ID of the bus to get. ||
|#

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "deletionProtection": "bool",
  "status": "Status"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the bus. ||
|| folderId | **string**

ID of the folder that the bus belongs to. ||
|| cloudId | **string**

ID of the cloud that the bus resides in. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the bus. ||
|| description | **string**

Description of the bus. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| deletionProtection | **bool**

Deletion protection. ||
|| status | enum **Status**

Status of the bus.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `ACTIVE`
- `DELETING` ||
|#