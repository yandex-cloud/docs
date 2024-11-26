---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/addDashboardsNodeGroup.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.AddDashboardsNodeGroup

Creates a Dashboards type host group.

## gRPC request

**rpc AddDashboardsNodeGroup ([AddDashboardsNodeGroupRequest](#yandex.cloud.mdb.opensearch.v1.AddDashboardsNodeGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddDashboardsNodeGroupRequest {#yandex.cloud.mdb.opensearch.v1.AddDashboardsNodeGroupRequest}

```json
{
  "cluster_id": "string",
  "node_group_spec": {
    "name": "string",
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

Required field. ID of the OpenSearch cluster to create the Dashboards type host group in.

To get the ID, use a [ClusterService.List](/docs/managed-opensearch/api-ref/grpc/Cluster/list#List) request. ||
|| node_group_spec | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup)**

Configuration of the new host group. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hosts_count | **int64**

Number of hosts in the group. ||
|| zone_ids[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnet_ids[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assign_public_ip | **bool**

Determines whether a public IP is assigned to the hosts in the group. ||
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
|| metadata | **[AddNodeGroupMetadata](#yandex.cloud.mdb.opensearch.v1.AddNodeGroupMetadata)**

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

## AddNodeGroupMetadata {#yandex.cloud.mdb.opensearch.v1.AddNodeGroupMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the OpenSearch cluster where the host group is being created. ||
|| name | **string**

Name of the host group being created. ||
|#