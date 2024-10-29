---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Subcluster/get.md
---

# Data Proc API, gRPC: SubclusterService.Get {#Get}

Returns the specified subcluster.

To get the list of all available subclusters, make a [SubclusterService.List](/docs/data-proc/api-ref/grpc/Subcluster/list#List) request.

## gRPC request

**rpc Get ([GetSubclusterRequest](#yandex.cloud.dataproc.v1.GetSubclusterRequest)) returns ([Subcluster](#yandex.cloud.dataproc.v1.Subcluster))**

## GetSubclusterRequest {#yandex.cloud.dataproc.v1.GetSubclusterRequest}

```json
{
  "clusterId": "string",
  "subclusterId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Data Proc cluster that the subcluster belongs to. ||
|| subclusterId | **string**

Required field. ID of the subcluster to return.

To get a subcluster ID make a [SubclusterService.List](/docs/data-proc/api-ref/grpc/Subcluster/list#List) request. ||
|#

## Subcluster {#yandex.cloud.dataproc.v1.Subcluster}

```json
{
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
```

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
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

Resources allocated for each host in the subcluster. ||
|| subnetId | **string**

ID of the VPC subnet used for hosts in the subcluster. ||
|| hostsCount | **int64**

Number of hosts in the subcluster. ||
|| assignPublicIp | **bool**

Assign public ip addresses for all hosts in subcluter. ||
|| autoscalingConfig | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig)**

Configuration for instance group based subclusters ||
|| instanceGroupId | **string**

ID of Compute Instance Group for autoscaling subclusters ||
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