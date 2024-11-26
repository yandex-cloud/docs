---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Bus/get.md
---

# EventRouter Service, gRPC: BusService.Get

Returns the specified bus.
To get the list of all available buses, make a [List](/docs/functions/eventrouter/api-ref/grpc/Bus/list#List) request.

## gRPC request

**rpc Get ([GetBusRequest](#yandex.cloud.serverless.eventrouter.v1.GetBusRequest)) returns ([Bus](#yandex.cloud.serverless.eventrouter.v1.Bus))**

## GetBusRequest {#yandex.cloud.serverless.eventrouter.v1.GetBusRequest}

```json
{
  "bus_id": "string"
}
```

#|
||Field | Description ||
|| bus_id | **string**

Required field. ID of the bus to get. ||
|#

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

```json
{
  "id": "string",
  "folder_id": "string",
  "cloud_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "deletion_protection": "bool",
  "status": "Status"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the bus. ||
|| folder_id | **string**

ID of the folder that the bus belongs to. ||
|| cloud_id | **string**

ID of the cloud that the bus resides in. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the bus. ||
|| description | **string**

Description of the bus. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| deletion_protection | **bool**

Deletion protection. ||
|| status | enum **Status**

Status of the bus.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `ACTIVE`
- `DELETING` ||
|#