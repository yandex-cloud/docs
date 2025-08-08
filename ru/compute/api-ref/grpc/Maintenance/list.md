---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Maintenance/list.md
---

# Compute Cloud API, gRPC: MaintenanceService.List

Lists maintenances by conditions, specified in request.

## gRPC request

**rpc List ([yandex.cloud.maintenance.v2.ListMaintenancesRequest](#yandex.cloud.maintenance.v2.ListMaintenancesRequest)) returns ([yandex.cloud.maintenance.v2.ListMaintenancesResponse](#yandex.cloud.maintenance.v2.ListMaintenancesResponse))**

## yandex.cloud.maintenance.v2.ListMaintenancesRequest {#yandex.cloud.maintenance.v2.ListMaintenancesRequest}

```json
{
  // Includes only one of the fields `cloud_id`, `folder_id`, `resource_id`
  "cloud_id": "string",
  "folder_id": "string",
  "resource_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

ListMaintenancesRequest allows listing maintenances by cloud ID, folder ID, resource type or resource ID.

#|
||Field | Description ||
|| cloud_id | **string**

Cloud ID for the resources.

Includes only one of the fields `cloud_id`, `folder_id`, `resource_id`.

Container specifies the resources for which to list maintenances. (Required) ||
|| folder_id | **string**

Folder ID for the resources.

Includes only one of the fields `cloud_id`, `folder_id`, `resource_id`.

Container specifies the resources for which to list maintenances. (Required) ||
|| resource_id | **string**

Resource ID of the target resource.

Includes only one of the fields `cloud_id`, `folder_id`, `resource_id`.

Container specifies the resources for which to list maintenances. (Required) ||
|| page_size | **int64**

The maximum number of maintenances to return per response. ||
|| page_token | **string**

Token to retrieve the next page of results. Omitted on the first request. ||
|| order_by | **string**

By which field the listing should be ordered and in which direction,
format is "created_at desc". The default sorting order is ascending.
Supported fields: ["created_at", "start_scheduled_at", "started_at"]. ||
|| filter | **string**

Filter list by various fields.
Supported fields: ["status", "resource_type", "resource_id"] ||
|#

## yandex.cloud.maintenance.v2.ListMaintenancesResponse {#yandex.cloud.maintenance.v2.ListMaintenancesResponse}

```json
{
  "maintenances": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| maintenances[] | **[Maintenance](#yandex.cloud.maintenance.v2.Maintenance)**

List of maintenances. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Maintenance {#yandex.cloud.maintenance.v2.Maintenance}

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