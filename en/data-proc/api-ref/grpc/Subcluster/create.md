---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Subcluster/create.md
---

# Data Proc API, gRPC: SubclusterService.Create {#Create}

Creates a subcluster in the specified cluster.

## gRPC request

**rpc Create ([CreateSubclusterRequest](#yandex.cloud.dataproc.v1.CreateSubclusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSubclusterRequest {#yandex.cloud.dataproc.v1.CreateSubclusterRequest}

```json
{
  "clusterId": "string",
  "name": "string",
  "role": "Role",
  "resources": {
    "resourcePresetId": "string",
    "diskTypeId": "string",
    "diskSize": "int64"
  },
  "subnetId": "string",
  "hostsCount": "int64",
  "autoscalingConfig": {
    "maxHostsCount": "int64",
    "preemptible": "bool",
    "measurementDuration": "google.protobuf.Duration",
    "warmupDuration": "google.protobuf.Duration",
    "stabilizationDuration": "google.protobuf.Duration",
    "cpuUtilizationTarget": "double",
    "decommissionTimeout": "int64"
  }
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Data Proc cluster to create a subcluster in.

To get a cluster ID, make a [ClusterService.List](/docs/data-proc/api-ref/grpc/Cluster/list#List) request. ||
|| name | **string**

Name of the subcluster. The name must be unique within the cluster. The name can't be
changed when the subcluster is created. ||
|| role | enum **Role**

Required field. Role that is fulfilled by hosts of the subcluster.

- `ROLE_UNSPECIFIED`
- `MASTERNODE`: The subcluster fulfills the master role.

  Master can run the following services, depending on the requested components:
* HDFS: Namenode, Secondary Namenode
* YARN: ResourceManager, Timeline Server
* HBase Master
* Hive: Server, Metastore, HCatalog
* Spark History Server
* Zeppelin
* ZooKeeper
- `DATANODE`: The subcluster is a DATANODE in a Data Proc cluster.

  DATANODE can run the following services, depending on the requested components:
* HDFS DataNode
* YARN NodeManager
* HBase RegionServer
* Spark libraries
- `COMPUTENODE`: The subcluster is a COMPUTENODE in a Data Proc cluster.

  COMPUTENODE can run the following services, depending on the requested components:
* YARN NodeManager
* Spark libraries ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

Required field. Resources allocated for each host in the subcluster. ||
|| subnetId | **string**

Required field. ID of the VPC subnet used for hosts in the subcluster. ||
|| hostsCount | **int64**

Required field. Number of hosts in the subcluster. ||
|| autoscalingConfig | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig)**

Configuration for instance group based subclusters ||
|#

## Resources {#yandex.cloud.dataproc.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the resource preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive. ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|#

## AutoscalingConfig {#yandex.cloud.dataproc.v1.AutoscalingConfig}

#|
||Field | Description ||
|| maxHostsCount | **int64**

Upper limit for total instance subcluster count. ||
|| preemptible | **bool**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|| measurementDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Time in seconds allotted for averaging metrics. ||
|| warmupDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilizationDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| cpuUtilizationTarget | **double**

Defines an autoscaling rule based on the average CPU utilization of the instance group. ||
|| decommissionTimeout | **int64**

Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120 ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "subclusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "clusterId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "role": "Role",
    "resources": {
      "resourcePresetId": "string",
      "diskTypeId": "string",
      "diskSize": "int64"
    },
    "subnetId": "string",
    "hostsCount": "int64",
    "assignPublicIp": "bool",
    "autoscalingConfig": {
      "maxHostsCount": "int64",
      "preemptible": "bool",
      "measurementDuration": "google.protobuf.Duration",
      "warmupDuration": "google.protobuf.Duration",
      "stabilizationDuration": "google.protobuf.Duration",
      "cpuUtilizationTarget": "double",
      "decommissionTimeout": "int64"
    },
    "instanceGroupId": "string"
  }
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSubclusterMetadata](#yandex.cloud.dataproc.v1.CreateSubclusterMetadata)**

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
|| response | **[Subcluster](#yandex.cloud.dataproc.v1.Subcluster)**

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

## CreateSubclusterMetadata {#yandex.cloud.dataproc.v1.CreateSubclusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that the subcluster is being added to. ||
|| subclusterId | **string**

ID of the subcluster that is being created. ||
|#

## Subcluster {#yandex.cloud.dataproc.v1.Subcluster}

A Data Proc subcluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the subcluster. Generated at creation time. ||
|| clusterId | **string**

ID of the Data Proc cluster that the subcluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the subcluster. The name is unique within the cluster. ||
|| role | enum **Role**

Role that is fulfilled by hosts of the subcluster.

- `ROLE_UNSPECIFIED`
- `MASTERNODE`: The subcluster fulfills the master role.

  Master can run the following services, depending on the requested components:
* HDFS: Namenode, Secondary Namenode
* YARN: ResourceManager, Timeline Server
* HBase Master
* Hive: Server, Metastore, HCatalog
* Spark History Server
* Zeppelin
* ZooKeeper
- `DATANODE`: The subcluster is a DATANODE in a Data Proc cluster.

  DATANODE can run the following services, depending on the requested components:
* HDFS DataNode
* YARN NodeManager
* HBase RegionServer
* Spark libraries
- `COMPUTENODE`: The subcluster is a COMPUTENODE in a Data Proc cluster.

  COMPUTENODE can run the following services, depending on the requested components:
* YARN NodeManager
* Spark libraries ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources2)**

Resources allocated for each host in the subcluster. ||
|| subnetId | **string**

ID of the VPC subnet used for hosts in the subcluster. ||
|| hostsCount | **int64**

Number of hosts in the subcluster. ||
|| assignPublicIp | **bool**

Assign public ip addresses for all hosts in subcluter. ||
|| autoscalingConfig | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig2)**

Configuration for instance group based subclusters ||
|| instanceGroupId | **string**

ID of Compute Instance Group for autoscaling subclusters ||
|#

## Resources {#yandex.cloud.dataproc.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the resource preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive. ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|#

## AutoscalingConfig {#yandex.cloud.dataproc.v1.AutoscalingConfig2}

#|
||Field | Description ||
|| maxHostsCount | **int64**

Upper limit for total instance subcluster count. ||
|| preemptible | **bool**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|| measurementDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Time in seconds allotted for averaging metrics. ||
|| warmupDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilizationDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| cpuUtilizationTarget | **double**

Defines an autoscaling rule based on the average CPU utilization of the instance group. ||
|| decommissionTimeout | **int64**

Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120 ||
|#