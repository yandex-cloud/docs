---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Bus/list.md
---

# EventRouter Service, gRPC: BusService.List

Retrieves the list of buses in the specified folder.

## gRPC request

**rpc List ([ListBusesRequest](#yandex.cloud.serverless.eventrouter.v1.ListBusesRequest)) returns ([ListBusesResponse](#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse))**

## ListBusesRequest {#yandex.cloud.serverless.eventrouter.v1.ListBusesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list buses in. ||
|| page_size | **int64**

Maximum number of buses to return. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListBusesResponse.next_page_token](#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse) returned by a previous list request. ||
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
      "folder_id": "string",
      "cloud_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "deletion_protection": "bool",
      "status": "Status"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| buses[] | **[Bus](#yandex.cloud.serverless.eventrouter.v1.Bus)**

List of buses. ||
|| next_page_token | **string**

Token for getting the next page of the list of buses. ||
|#

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

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
|| labels | **object** (map<**string**, **string**>)

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