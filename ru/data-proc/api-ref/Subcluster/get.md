---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Subcluster/get.md
---

# Yandex Data Processing API, REST: Subcluster.Get

Returns the specified subcluster.

To get the list of all available subclusters, make a [SubclusterService.List](/docs/data-proc/api-ref/Subcluster/list#List) request.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/subclusters/{subclusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Yandex Data Processing cluster that the subcluster belongs to. ||
|| subclusterId | **string**

Required field. ID of the subcluster to return.

To get a subcluster ID make a [SubclusterService.List](/docs/data-proc/api-ref/Subcluster/list#List) request. ||
|#

## Response {#yandex.cloud.dataproc.v1.Subcluster}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "clusterId": "string",
  "createdAt": "string",
  "name": "string",
  "role": "string",
  "resources": {
    "resourcePresetId": "string",
    "diskTypeId": "string",
    "diskSize": "string"
  },
  "subnetId": "string",
  "hostsCount": "string",
  "assignPublicIp": "boolean",
  "autoscalingConfig": {
    "maxHostsCount": "string",
    "preemptible": "boolean",
    "measurementDuration": "string",
    "warmupDuration": "string",
    "stabilizationDuration": "string",
    "cpuUtilizationTarget": "string",
    "decommissionTimeout": "string"
  },
  "instanceGroupId": "string"
}
```

A Yandex Data Processing subcluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the subcluster. Generated at creation time. ||
|| clusterId | **string**

ID of the Yandex Data Processing cluster that the subcluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the subcluster. The name is unique within the cluster. ||
|| role | **enum** (Role)

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
|| subnetId | **string**

ID of the VPC subnet used for hosts in the subcluster. ||
|| hostsCount | **string** (int64)

Number of hosts in the subcluster. ||
|| assignPublicIp | **boolean**

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
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|#

## AutoscalingConfig {#yandex.cloud.dataproc.v1.AutoscalingConfig}

#|
||Field | Description ||
|| maxHostsCount | **string** (int64)

Upper limit for total instance subcluster count. ||
|| preemptible | **boolean**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|| measurementDuration | **string** (duration)

Required field. Time in seconds allotted for averaging metrics. ||
|| warmupDuration | **string** (duration)

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilizationDuration | **string** (duration)

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| cpuUtilizationTarget | **string**

Defines an autoscaling rule based on the average CPU utilization of the instance group. ||
|| decommissionTimeout | **string** (int64)

Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120 ||
|#