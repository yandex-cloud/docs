---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Bus/list.md
---

# EventRouter Service, gRPC: BusService.List {#List}

Retrieves the list of buses in the specified folder.

## gRPC request

**rpc List ([ListBusesRequest](#yandex.cloud.serverless.eventrouter.v1.ListBusesRequest)) returns ([ListBusesResponse](#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse))**

## ListBusesRequest {#yandex.cloud.serverless.eventrouter.v1.ListBusesRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list buses in. ||
|| pageSize | **int64**

Maximum number of buses to return. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListBusesResponse.nextPageToken](#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse) returned by a previous list request. ||
|| filter | **string**

Supported fields for filter:
name
created_at ||
|#

## ListBusesResponse {#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse}

```json
{
  "buses": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| buses[] | **[Bus](#yandex.cloud.serverless.eventrouter.v1.Bus)**

List of buses. ||
|| nextPageToken | **string**

Token for getting the next page of the list of buses. ||
|#

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

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