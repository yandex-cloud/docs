---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Subcluster/list.md
---

# Data Proc API, REST: Subcluster.List

Retrieves a list of subclusters in the specified cluster.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/subclusters
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Data Proc cluster to list subclusters in. ||
|#

## Query parameters {#yandex.cloud.dataproc.v1.ListSubclustersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListSubclustersResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListSubclustersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListSubclustersResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListSubclustersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters subclusters listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Subcluster.name](#yandex.cloud.dataproc.v1.Subcluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=dataproc123_subcluster456`. ||
|#

## Response {#yandex.cloud.dataproc.v1.ListSubclustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "subclusters": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| subclusters[] | **[Subcluster](#yandex.cloud.dataproc.v1.Subcluster)**

List of subclusters in the specified cluster. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListSubclustersRequest.pageSize](#yandex.cloud.dataproc.v1.ListSubclustersRequest), use `next_page_token` as the value
for the [ListSubclustersRequest.pageToken](#yandex.cloud.dataproc.v1.ListSubclustersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Subcluster {#yandex.cloud.dataproc.v1.Subcluster}

A Data Proc subcluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the subcluster. Generated at creation time. ||
|| clusterId | **string**

ID of the Data Proc cluster that the subcluster belongs to. ||
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