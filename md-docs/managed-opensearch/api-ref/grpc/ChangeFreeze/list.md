[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for OpenSearch](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [ChangeFreeze](index.md) > List

# Managed Service for OpenSearch API, gRPC: ChangeFreezeService.List

Lists change freezes by conditions, specified in request.

## gRPC request

**rpc List ([maintenance.v2.ListChangeFreezesRequest](#yandex.cloud.maintenance.v2.ListChangeFreezesRequest)) returns ([maintenance.v2.ListChangeFreezesResponse](#yandex.cloud.maintenance.v2.ListChangeFreezesResponse))**

## maintenance.v2.ListChangeFreezesRequest {#yandex.cloud.maintenance.v2.ListChangeFreezesRequest}

```json
{
  "resource_path": [
    {
      "id": "string",
      "type": "string"
    }
  ],
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| resource_path[] | **[Resource](#yandex.cloud.maintenance.v2.Resource)**

Full path to the resource to list change freezes for.

The number of elements must be in the range 1-128. ||
|| page_size | **int64**

The maximum number of change freezes to return per response.

The maximum value is 1000. ||
|| page_token | **string**

Token to retrieve the next page of results. Omitted on the first request.

The maximum string length in characters is 500. ||
|| filter | **string**

Filter list by various fields.

The maximum string length in characters is 300. ||
|#

## Resource {#yandex.cloud.maintenance.v2.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#

## maintenance.v2.ListChangeFreezesResponse {#yandex.cloud.maintenance.v2.ListChangeFreezesResponse}

```json
{
  "change_freezes": [
    {
      "id": "string",
      "resource_path": [
        {
          "id": "string",
          "type": "string"
        }
      ],
      "start_at": "google.protobuf.Timestamp",
      "end_at": "google.protobuf.Timestamp",
      "duration_seconds": "int64",
      "reason": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "status": "Status",
      "updated_by": "string",
      "updated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| change_freezes[] | **[ChangeFreeze](#yandex.cloud.maintenance.v2.ChangeFreeze)**

List of change freezes. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## ChangeFreeze {#yandex.cloud.maintenance.v2.ChangeFreeze}

#|
||Field | Description ||
|| id | **string**

ID of the change freeze. ||
|| resource_path[] | **[Resource](#yandex.cloud.maintenance.v2.Resource2)**

Full path to the resource affected by the change freeze,
represented as a hierarchy from specific resource to top-level container. ||
|| start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the change freeze is scheduled to start. ||
|| end_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the change freeze is scheduled to end. ||
|| duration_seconds | **int64**

Duration of the change freeze in seconds. ||
|| reason | **string**

Reason for the change freeze. ||
|| created_by | **string**

The user who created the change freeze. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The creation time of the change freeze. ||
|| status | enum **Status**

Status of the change freeze.

- `SCHEDULED`: Change freeze is scheduled for a future time.
- `ACTIVE`: Change freeze is currently active.
- `COMPLETED`: Change freeze is completed.
- `CANCELLED`: Change freeze is cancelled. ||
|| updated_by | **string**

The user who last updated the change freeze. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the change freeze was last updated. ||
|#

## Resource {#yandex.cloud.maintenance.v2.Resource2}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#