---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Subcluster/update.md
---

# Yandex Data Processing API, REST: Subcluster.Update

Updates the specified subcluster.

## HTTP request

```
PATCH https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/subclusters/{subclusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to update a subcluster in.

To get a cluster ID, make a [ClusterService.List](/docs/data-proc/api-ref/Cluster/list#List) request. ||
|| subclusterId | **string**

Required field. ID of the subcluster to update.

To get a subcluster ID, make a [SubclusterService.List](/docs/data-proc/api-ref/Subcluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.dataproc.v1.UpdateSubclusterRequest}

```json
{
  "updateMask": "string",
  "resources": {
    "resourcePresetId": "string",
    "diskTypeId": "string",
    "diskSize": "string"
  },
  "name": "string",
  "hostsCount": "string",
  "decommissionTimeout": "string",
  "autoscalingConfig": {
    "maxHostsCount": "string",
    "preemptible": "boolean",
    "measurementDuration": "string",
    "warmupDuration": "string",
    "stabilizationDuration": "string",
    "cpuUtilizationTarget": "string",
    "decommissionTimeout": "string"
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

New configuration of resources that should be allocated for each host in the subcluster. ||
|| name | **string**

New name for the subcluster. The name must be unique within the cluster. ||
|| hostsCount | **string** (int64)

Required field. New number of hosts in the subcluster. ||
|| decommissionTimeout | **string** (int64)

Timeout to gracefully decommission nodes. In seconds. Default value: 0 ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "subclusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateSubclusterMetadata](#yandex.cloud.dataproc.v1.UpdateSubclusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## UpdateSubclusterMetadata {#yandex.cloud.dataproc.v1.UpdateSubclusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster whose subcluster is being updated. ||
|| subclusterId | **string**

ID of the subcluster that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Subcluster {#yandex.cloud.dataproc.v1.Subcluster}

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
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources2)**

Resources allocated for each host in the subcluster. ||
|| subnetId | **string**

ID of the VPC subnet used for hosts in the subcluster. ||
|| hostsCount | **string** (int64)

Number of hosts in the subcluster. ||
|| assignPublicIp | **boolean**

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
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|#

## AutoscalingConfig {#yandex.cloud.dataproc.v1.AutoscalingConfig2}

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