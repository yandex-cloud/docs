---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Subcluster/get.md
---

# Yandex Data Processing API, gRPC: SubclusterService.Get

Returns the specified subcluster.

To get the list of all available subclusters, make a [SubclusterService.List](/docs/data-proc/api-ref/grpc/Subcluster/list#List) request.

## gRPC request

**rpc Get ([GetSubclusterRequest](#yandex.cloud.dataproc.v1.GetSubclusterRequest)) returns ([Subcluster](#yandex.cloud.dataproc.v1.Subcluster))**

## GetSubclusterRequest {#yandex.cloud.dataproc.v1.GetSubclusterRequest}

```json
{
  "cluster_id": "string",
  "subcluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Yandex Data Processing cluster that the subcluster belongs to. ||
|| subcluster_id | **string**

Required field. ID of the subcluster to return.

To get a subcluster ID make a [SubclusterService.List](/docs/data-proc/api-ref/grpc/Subcluster/list#List) request. ||
|#

## Subcluster {#yandex.cloud.dataproc.v1.Subcluster}

```json
{
  "id": "string",
  "cluster_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "role": "Role",
  "resources": {
    "resource_preset_id": "string",
    "disk_type_id": "string",
    "disk_size": "int64"
  },
  "subnet_id": "string",
  "hosts_count": "int64",
  "assign_public_ip": "bool",
  "autoscaling_config": {
    "max_hosts_count": "int64",
    "preemptible": "bool",
    "measurement_duration": "google.protobuf.Duration",
    "warmup_duration": "google.protobuf.Duration",
    "stabilization_duration": "google.protobuf.Duration",
    "cpu_utilization_target": "double",
    "decommission_timeout": "int64"
  },
  "instance_group_id": "string"
}
```

A Yandex Data Processing subcluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the subcluster. Generated at creation time. ||
|| cluster_id | **string**

ID of the Yandex Data Processing cluster that the subcluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
- `DATANODE`: The subcluster is a DATANODE in a Yandex Data Processing cluster.

  DATANODE can run the following services, depending on the requested components:
* HDFS DataNode
* YARN NodeManager
* HBase RegionServer
* Spark libraries
- `COMPUTENODE`: The subcluster is a COMPUTENODE in a Yandex Data Processing cluster.

  COMPUTENODE can run the following services, depending on the requested components:
* YARN NodeManager
* Spark libraries ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

Resources allocated for each host in the subcluster. ||
|| subnet_id | **string**

ID of the VPC subnet used for hosts in the subcluster. ||
|| hosts_count | **int64**

Number of hosts in the subcluster. ||
|| assign_public_ip | **bool**

Assign public ip addresses for all hosts in subcluter. ||
|| autoscaling_config | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig)**

Configuration for instance group based subclusters ||
|| instance_group_id | **string**

ID of Compute Instance Group for autoscaling subclusters ||
|#

## Resources {#yandex.cloud.dataproc.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the resource preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types). ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive. ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|#

## AutoscalingConfig {#yandex.cloud.dataproc.v1.AutoscalingConfig}

#|
||Field | Description ||
|| max_hosts_count | **int64**

Upper limit for total instance subcluster count. ||
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

Defines an autoscaling rule based on the average CPU utilization of the instance group. ||
|| decommission_timeout | **int64**

Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120 ||
|#