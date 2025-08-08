---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Maintenance/get.md
---

# Compute Cloud API, gRPC: MaintenanceService.Get

Retrieves the specific Maintenance by ID.

## gRPC request

**rpc Get ([yandex.cloud.maintenance.v2.GetMaintenanceRequest](#yandex.cloud.maintenance.v2.GetMaintenanceRequest)) returns ([yandex.cloud.maintenance.v2.Maintenance](#yandex.cloud.maintenance.v2.Maintenance))**

## yandex.cloud.maintenance.v2.GetMaintenanceRequest {#yandex.cloud.maintenance.v2.GetMaintenanceRequest}

```json
{
  "maintenance_id": "string"
}
```

GetMaintenanceRequest allows getting Maintenance by ID.

#|
||Field | Description ||
|| maintenance_id | **string**

Required field.  ||
|#

## yandex.cloud.maintenance.v2.Maintenance {#yandex.cloud.maintenance.v2.Maintenance}

```json
{
  "id": "string",
  "resource_path": [
    {
      "id": "string",
      "type": "string"
    }
  ],
  "description": "string",
  "details": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "status": "Status",
  "created_at": "google.protobuf.Timestamp",
  "start_scheduled_at": "google.protobuf.Timestamp",
  "completion_scheduled_at": "google.protobuf.Timestamp",
  "max_start_scheduled_at": "google.protobuf.Timestamp",
  "started_at": "google.protobuf.Timestamp",
  "succeeded_at": "google.protobuf.Timestamp",
  "cancelled_at": "google.protobuf.Timestamp",
  "user_controllable": "bool"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the maintenance. ||
|| resource_path[] | **[Resource](#yandex.cloud.maintenance.v2.Maintenance.Resource)**

Full path to the resource affected by maintenance,
represented as a hierarchy from specific resource to top-level container.
Example for a Compute instance with ID "I" in folder "F" and cloud "C":
resource_path = [
{ "compute.instance", "I" },
{ "resource-manager.folder", "F" },
{ "resource-manager.cloud", "C" }
] ||
|| description | **string**

Describes action to be performed. ||
|| details[] | **[Detail](#yandex.cloud.maintenance.v2.Maintenance.Detail)**

Service-specific details. ||
|| status | enum **Status**

Status of the maintenance.

- `STATUS_UNSPECIFIED`: Not set.
- `SCHEDULED`: Maintenance is scheduled for a future time.
- `RUNNING`: Maintenance is currently running.
- `SUCCEEDED`: Maintenance completed successfully.
- `CANCELLED`: Maintenance is cancelled and will not run. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The creation time of the maintenance. ||
|| start_scheduled_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the maintenance was scheduled to start. ||
|| completion_scheduled_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the maintenance is estimated to complete. Optional. ||
|| max_start_scheduled_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Latest time the maintenance can be postponed to. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time time when the maintenance has actually started. ||
|| succeeded_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time time when the maintenance has actually completed successfully. ||
|| cancelled_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time time when the maintenance has actually been cancelled. ||
|| user_controllable | **bool**

Indicates whether the user can control (reschedule) the maintenance. ||
|#

## Resource {#yandex.cloud.maintenance.v2.Maintenance.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#

## Detail {#yandex.cloud.maintenance.v2.Maintenance.Detail}

#|
||Field | Description ||
|| key | **string**

Unique key (service-specific). ||
|| value | **string**

Description (service-specific). ||
|#