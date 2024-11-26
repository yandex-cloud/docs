---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/updateDashboardsNodeGroup.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.UpdateDashboardsNodeGroup

Updates a Dashboards type host group.

## gRPC request

**rpc UpdateDashboardsNodeGroup ([UpdateDashboardsNodeGroupRequest](#yandex.cloud.mdb.opensearch.v1.UpdateDashboardsNodeGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDashboardsNodeGroupRequest {#yandex.cloud.mdb.opensearch.v1.UpdateDashboardsNodeGroupRequest}

```json
{
  "cluster_id": "string",
  "name": "string",
  "update_mask": "google.protobuf.FieldMask",
  "node_group_spec": {
    "resources": {
      "resource_preset_id": "string",
      "disk_size": "int64",
      "disk_type_id": "string"
    },
    "hosts_count": "int64",
    "zone_ids": [
      "string"
    ],
    "subnet_ids": [
      "string"
    ],
    "assign_public_ip": "bool",
    "disk_size_autoscaling": {
      "planned_usage_threshold": "int64",
      "emergency_usage_threshold": "int64",
      "disk_size_limit": "int64"
    }
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the OpenSearch cluster to update the Dashboards type host group in. ||
|| name | **string**

Required field. Name of the Dashboards type host group to be updated. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the host group configuration should be updated. ||
|| node_group_spec | **[DashboardsNodeGroupUpdateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsNodeGroupUpdateSpec)**

New configuration for the host group. ||
|#

## DashboardsNodeGroupUpdateSpec {#yandex.cloud.mdb.opensearch.v1.DashboardsNodeGroupUpdateSpec}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hosts_count | **int64**

Number of hosts in the group. ||
|| zone_ids[] | **string**

IDs of the availability zones for hosts ||
|| subnet_ids[] | **string**

IDs of the subnets for hosts ||
|| assign_public_ip | **bool**

Whether the hosts should get a public IP address. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources allocated to a host. ||
|| disk_size | **int64**

Volume of the storage used by the host, in bytes. ||
|| disk_type_id | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **int64**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **int64**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **int64**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateNodeGroupMetadata](#yandex.cloud.mdb.opensearch.v1.UpdateNodeGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateNodeGroupMetadata {#yandex.cloud.mdb.opensearch.v1.UpdateNodeGroupMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the OpenSearch cluster where the host group is being updated. ||
|| name | **string**

Name of the host group being updated. ||
|#