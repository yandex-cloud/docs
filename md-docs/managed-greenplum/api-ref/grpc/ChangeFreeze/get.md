[Документация Yandex Cloud](../../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [ChangeFreeze](index.md) > Get

# Managed Service for Greenplum® API, gRPC: ChangeFreezeService.Get

Retrieves the specific change freeze by ID.

## gRPC request

**rpc Get ([maintenance.v2.GetChangeFreezeRequest](#yandex.cloud.maintenance.v2.GetChangeFreezeRequest)) returns ([maintenance.v2.ChangeFreeze](#yandex.cloud.maintenance.v2.ChangeFreeze))**

## maintenance.v2.GetChangeFreezeRequest {#yandex.cloud.maintenance.v2.GetChangeFreezeRequest}

```json
{
  "change_freeze_id": "string"
}
```

#|
||Field | Description ||
|| change_freeze_id | **string**

Required field. ID of the change freeze to retrieve.

The maximum string length in characters is 50. ||
|#

## maintenance.v2.ChangeFreeze {#yandex.cloud.maintenance.v2.ChangeFreeze}

```json
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
```

#|
||Field | Description ||
|| id | **string**

ID of the change freeze. ||
|| resource_path[] | **[Resource](#yandex.cloud.maintenance.v2.Resource)**

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

## Resource {#yandex.cloud.maintenance.v2.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#