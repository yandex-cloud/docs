---
editable: false
---

# Yandex Cloud SIEM Queries API, gRPC: SearchService.Get

Returns the specified Search.

## gRPC request

**rpc Get ([GetSearchRequest](#yandex.cloud.siem.v1.queries.GetSearchRequest)) returns ([Search](#yandex.cloud.siem.v1.queries.Search))**

## GetSearchRequest {#yandex.cloud.siem.v1.queries.GetSearchRequest}

```json
{
  "search_id": "string"
}
```

#|
||Field | Description ||
|| search_id | **string**

Required field. Required. ID of the Search to return.

The maximum string length in characters is 50. ||
|#

## Search {#yandex.cloud.siem.v1.queries.Search}

```json
{
  "id": "string",
  "session_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "status": "Status",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "updated_by": "string"
}
```

Search is a resource describing a single search in session.

#|
||Field | Description ||
|| id | **string**

Required field. Required. Unique ID of the Search.
This ID is assigned by services in the process of creating a Search.

The maximum string length in characters is 50. ||
|| session_id | **string**

Required field. Required. ID of the Session that Search belongs to.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Required. Name of the Search.
The name is unique within the Session. 1-64 characters long.

The maximum string length in characters is 64. ||
|| description | **string**

The description of the Search. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | enum **Status**

Search status

- `CREATING`: Search is being created
- `ACTIVE`: Search is active
- `UPDATING`: Search is being updated
- `DELETING`: Search is being deleted
- `DELETED`: Search is deleted ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Search was created at. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Search was last updated at. ||
|| created_by | **string**

ID of the user or service account who created the Search. ||
|| updated_by | **string**

ID of the user or service account who updated the Search. ||
|#