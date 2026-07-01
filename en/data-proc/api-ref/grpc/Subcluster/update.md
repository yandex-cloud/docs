---
editable: false
---

# Yandex Data Processing API, gRPC: SubclusterService.Update

Updates the specified subcluster.

## gRPC request

**rpc Update ([UpdateSubclusterRequest](#yandex.cloud.dataproc.v1.UpdateSubclusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSubclusterRequest {#yandex.cloud.dataproc.v1.UpdateSubclusterRequest}

```json
{
  "cluster_id": "string",
  "subcluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "resources": {
    "resource_preset_id": "string",
    "disk_type_id": "string",
    "disk_size": "int64"
  },
  "name": "string",
  "hosts_count": "int64",
  "decommission_timeout": "int64",
  "autoscaling_config": {
    "max_hosts_count": "int64",
    "preemptible": "bool",
    "measurement_duration": "google.protobuf.Duration",
    "warmup_duration": "google.protobuf.Duration",
    "stabilization_duration": "google.protobuf.Duration",
    "cpu_utilization_target": "double",
    "decommission_timeout": "int64"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to update a subcluster in.
To get a cluster ID, make a [ClusterService.List](/docs/data-proc/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| subcluster_id | **string**

Required field. ID of the subcluster to update.
To get a subcluster ID, make a [SubclusterService.List](/docs/data-proc/api-ref/grpc/Subcluster/list#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the subcluster should be updated. ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

New configuration of resources that should be allocated for each host in the subcluster. ||
|| name | **string**

New name for the subcluster. The name must be unique within the cluster.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| hosts_count | **int64**

New number of hosts in the subcluster.

The minimum value is 0. ||
|| decommission_timeout | **int64**

Timeout to gracefully decommission nodes. In seconds. Default value: 0

Acceptable values are 0 to 86400, inclusive. ||
|| autoscaling_config | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig)**

Configuration for instance group based subclusters ||
|#

## Resources {#yandex.cloud.dataproc.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the resource preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types).

The maximum string length in characters is 50. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive.

The maximum string length in characters is 50. ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes.

The minimum value is 0. ||
|#

## AutoscalingConfig {#yandex.cloud.dataproc.v1.AutoscalingConfig}

#|
||Field | Description ||
|| max_hosts_count | **int64**

Upper limit for total instance subcluster count.

Acceptable values are 1 to 100, inclusive. ||
|| preemptible | **bool**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|| measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Time in seconds allotted for averaging metrics. ||
|| warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| cpu_utilization_target | **double**

Defines an autoscaling rule based on the average CPU utilization of the instance group.

Acceptable values are 0 to 100, inclusive. ||
|| decommission_timeout | **int64**

Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120

Acceptable values are 0 to 86400, inclusive. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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