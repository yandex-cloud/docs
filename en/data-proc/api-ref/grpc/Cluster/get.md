---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Cluster/get.md
---

# Data Proc API, gRPC: ClusterService.Get {#Get}

Returns the specified cluster.

To get the list of all available clusters, make a [ClusterService.List](/docs/data-proc/api-ref/grpc/Cluster/list#List) request.

## gRPC request

**rpc Get ([GetClusterRequest](#yandex.cloud.dataproc.v1.GetClusterRequest)) returns ([Cluster](#yandex.cloud.dataproc.v1.Cluster))**

## GetClusterRequest {#yandex.cloud.dataproc.v1.GetClusterRequest}

```json
{
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Data Proc cluster.

To get a cluster ID make a [ClusterService.List](/docs/data-proc/api-ref/grpc/Cluster/list#List) request. ||
|#

## Cluster {#yandex.cloud.dataproc.v1.Cluster}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
    "versionId": "string",
    "hadoop": {
      "services": [
        "Service"
      ],
      "properties": "string",
      "sshPublicKeys": [
        "string"
      ],
      "initializationActions": [
        {
          "uri": "string",
          "args": [
            "string"
          ],
          "timeout": "int64"
        }
      ]
    }
  },
  "health": "Health",
  "status": "Status",
  "zoneId": "string",
  "serviceAccountId": "string",
  "bucket": "string",
  "uiProxy": "bool",
  "securityGroupIds": [
    "string"
  ],
  "hostGroupIds": [
    "string"
  ],
  "deletionProtection": "bool",
  "logGroupId": "string"
}
```

A Data Proc cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the cluster. The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **string**

Cluster labels as `key:value` pairs. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.dataproc.v1.Monitoring)**

Monitoring systems relevant to the cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.dataproc.v1.ClusterConfig)**

Configuration of the cluster. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data).
- `ALIVE`: Object is alive and well (for example, all hosts of the cluster are alive).
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions). ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| zoneId | **string**

ID of the availability zone where the cluster resides. ||
|| serviceAccountId | **string**

ID of service account for the Data Proc manager agent. ||
|| bucket | **string**

Object Storage bucket to be used for Data Proc jobs that are run in the cluster. ||
|| uiProxy | **bool**

Whether UI Proxy feature is enabled. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletionProtection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| logGroupId | **string**

ID of the cloud logging log group to write logs. If not set, default log group for the folder will be used.
To prevent logs from being sent to the cloud set cluster property dataproc:disable_cloud_logging = true ||
|#

## Monitoring {#yandex.cloud.dataproc.v1.Monitoring}

Metadata of a monitoring system for a Data Proc cluster.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## ClusterConfig {#yandex.cloud.dataproc.v1.ClusterConfig}

#|
||Field | Description ||
|| versionId | **string**

Image version for cluster provisioning.
All available versions are listed in the [documentation](/docs/data-proc/concepts/environment). ||
|| hadoop | **[HadoopConfig](#yandex.cloud.dataproc.v1.HadoopConfig)**

Data Proc specific configuration options. ||
|#

## HadoopConfig {#yandex.cloud.dataproc.v1.HadoopConfig}

Hadoop configuration that describes services installed in a cluster,
their properties and settings.

#|
||Field | Description ||
|| services[] | enum **Service**

Set of services used in the cluster (if empty, the default set is used).

- `SERVICE_UNSPECIFIED`
- `HDFS`
- `YARN`
- `MAPREDUCE`
- `HIVE`
- `TEZ`
- `ZOOKEEPER`
- `HBASE`
- `SQOOP`
- `FLUME`
- `SPARK`
- `ZEPPELIN`
- `OOZIE`
- `LIVY` ||
|| properties | **string**

Properties set for all hosts in `*-site.xml` configurations. The key should indicate
the service and the property.

For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property
in the file `/etc/hadoop/conf/hdfs-site.xml`. ||
|| sshPublicKeys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initializationActions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction)**

Set of init-actions ||
|#

## InitializationAction {#yandex.cloud.dataproc.v1.InitializationAction}

#|
||Field | Description ||
|| uri | **string**

URI of the executable file ||
|| args[] | **string**

Arguments to the initialization action ||
|| timeout | **int64**

Execution timeout ||
|#