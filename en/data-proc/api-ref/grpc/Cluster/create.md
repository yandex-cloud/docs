---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Cluster/create.md
---

# Yandex Data Processing API, gRPC: ClusterService.Create

Creates a cluster in the specified folder.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.dataproc.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.dataproc.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "config_spec": {
    "version_id": "string",
    "hadoop": {
      "services": [
        "Service"
      ],
      "properties": "map<string, string>",
      "ssh_public_keys": [
        "string"
      ],
      "initialization_actions": [
        {
          "uri": "string",
          "args": [
            "string"
          ],
          "timeout": "int64"
        }
      ]
    },
    "subclusters_spec": [
      {
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
        }
      }
    ]
  },
  "zone_id": "string",
  "service_account_id": "string",
  "bucket": "string",
  "ui_proxy": "bool",
  "security_group_ids": [
    "string"
  ],
  "host_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "log_group_id": "string",
  "environment": "Environment"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a cluster in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the cluster. The name must be unique within the folder.
The name can't be changed after the Yandex Data Processing cluster is created. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| config_spec | **[CreateClusterConfigSpec](#yandex.cloud.dataproc.v1.CreateClusterConfigSpec)**

Required field. Configuration and resources for hosts that should be created with the cluster. ||
|| zone_id | **string**

Required field. ID of the availability zone where the cluster should be placed.

To get the list of available zones make a [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| service_account_id | **string**

Required field. ID of the service account to be used by the Yandex Data Processing manager agent. ||
|| bucket | **string**

Name of the Object Storage bucket to use for Yandex Data Processing jobs. ||
|| ui_proxy | **bool**

Enable UI Proxy feature. ||
|| security_group_ids[] | **string**

User security groups. ||
|| host_group_ids[] | **string**

Host groups to place VMs of cluster on. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| log_group_id | **string**

ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service ||
|| environment | enum **Environment**

Environment of the cluster

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`
- `PRESTABLE` ||
|#

## CreateClusterConfigSpec {#yandex.cloud.dataproc.v1.CreateClusterConfigSpec}

#|
||Field | Description ||
|| version_id | **string**

Version of the image for cluster provisioning.

All available versions are listed in the [documentation](/docs/data-proc/concepts/environment). ||
|| hadoop | **[HadoopConfig](#yandex.cloud.dataproc.v1.HadoopConfig)**

Yandex Data Processing specific options. ||
|| subclusters_spec[] | **[CreateSubclusterConfigSpec](#yandex.cloud.dataproc.v1.CreateSubclusterConfigSpec)**

Specification for creating subclusters. ||
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
|| properties | **object** (map<**string**, **string**>)

Properties set for all hosts in `*-site.xml` configurations. The key should indicate
the service and the property.

For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property
in the file `/etc/hadoop/conf/hdfs-site.xml`. ||
|| ssh_public_keys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initialization_actions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction)**

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

## CreateSubclusterConfigSpec {#yandex.cloud.dataproc.v1.CreateSubclusterConfigSpec}

#|
||Field | Description ||
|| name | **string**

Name of the subcluster. ||
|| role | enum **Role**

Required field. Role of the subcluster in the Yandex Data Processing cluster.

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

Required field. Resource configuration for hosts in the subcluster. ||
|| subnet_id | **string**

Required field. ID of the VPC subnet used for hosts in the subcluster. ||
|| hosts_count | **int64**

Number of hosts in the subcluster. ||
|| assign_public_ip | **bool**

Assign public ip addresses for all hosts in subcluter. ||
|| autoscaling_config | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig)**

Configuration for instance group based subclusters ||
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
    "cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version_id": "string",
      "hadoop": {
        "services": [
          "Service"
        ],
        "properties": "map<string, string>",
        "ssh_public_keys": [
          "string"
        ],
        "initialization_actions": [
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
    "zone_id": "string",
    "service_account_id": "string",
    "bucket": "string",
    "ui_proxy": "bool",
    "security_group_ids": [
      "string"
    ],
    "host_group_ids": [
      "string"
    ],
    "deletion_protection": "bool",
    "log_group_id": "string",
    "environment": "Environment"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.dataproc.v1.CreateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.dataproc.v1.Cluster)**

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

## CreateClusterMetadata {#yandex.cloud.dataproc.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the cluster that is being created. ||
|#

## Cluster {#yandex.cloud.dataproc.v1.Cluster}

A Yandex Data Processing cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the cluster. The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

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
|| zone_id | **string**

ID of the availability zone where the cluster resides. ||
|| service_account_id | **string**

ID of service account for the Yandex Data Processing manager agent. ||
|| bucket | **string**

Object Storage bucket to be used for Yandex Data Processing jobs that are run in the cluster. ||
|| ui_proxy | **bool**

Whether UI Proxy feature is enabled. ||
|| security_group_ids[] | **string**

User security groups. ||
|| host_group_ids[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| log_group_id | **string**

ID of the cloud logging log group to write logs. If not set, default log group for the folder will be used.
To prevent logs from being sent to the cloud set cluster property dataproc:disable_cloud_logging = true ||
|| environment | enum **Environment**

Environment of the cluster

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`
- `PRESTABLE` ||
|#

## Monitoring {#yandex.cloud.dataproc.v1.Monitoring}

Metadata of a monitoring system for a Yandex Data Processing cluster.

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
|| version_id | **string**

Image version for cluster provisioning.
All available versions are listed in the [documentation](/docs/data-proc/concepts/environment). ||
|| hadoop | **[HadoopConfig](#yandex.cloud.dataproc.v1.HadoopConfig2)**

Yandex Data Processing specific configuration options. ||
|#

## HadoopConfig {#yandex.cloud.dataproc.v1.HadoopConfig2}

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
|| properties | **object** (map<**string**, **string**>)

Properties set for all hosts in `*-site.xml` configurations. The key should indicate
the service and the property.

For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property
in the file `/etc/hadoop/conf/hdfs-site.xml`. ||
|| ssh_public_keys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initialization_actions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction2)**

Set of init-actions ||
|#

## InitializationAction {#yandex.cloud.dataproc.v1.InitializationAction2}

#|
||Field | Description ||
|| uri | **string**

URI of the executable file ||
|| args[] | **string**

Arguments to the initialization action ||
|| timeout | **int64**

Execution timeout ||
|#