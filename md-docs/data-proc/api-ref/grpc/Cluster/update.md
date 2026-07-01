# Yandex Data Processing API, gRPC: ClusterService.Update

Updates the configuration of the specified cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.dataproc.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.dataproc.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "description": "string",
  "labels": "map<string, string>",
  "config_spec": {
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
      ],
      "oslogin_enabled": "bool"
    },
    "subclusters_spec": [
      {
        "id": "string",
        "name": "string",
        "resources": {
          "resource_preset_id": "string",
          "disk_type_id": "string",
          "disk_size": "int64"
        },
        "hosts_count": "int64",
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
  "name": "string",
  "service_account_id": "string",
  "bucket": "string",
  "decommission_timeout": "int64",
  "ui_proxy": "bool",
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "log_group_id": "string",
  "autoscaling_service_account_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to update.
To get the cluster ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the cluster should be updated. ||
|| description | **string**

New description for the cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

A new set of cluster labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| config_spec | **[UpdateClusterConfigSpec](#yandex.cloud.dataproc.v1.UpdateClusterConfigSpec)**

Configuration and resources for hosts that should be created with the Yandex Data Processing cluster. ||
|| name | **string**

New name for the Yandex Data Processing cluster. The name must be unique within the folder.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| service_account_id | **string**

ID of the new service account to be used by the Yandex Data Processing manager agent. ||
|| bucket | **string**

Name of the new Object Storage bucket to use for Yandex Data Processing jobs. ||
|| decommission_timeout | **int64**

Timeout to gracefully decommission nodes. In seconds. Default value: 0

Acceptable values are 0 to 86400, inclusive. ||
|| ui_proxy | **bool**

Enable UI Proxy feature. ||
|| security_group_ids[] | **string**

User security groups. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| log_group_id | **string**

ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service ||
|| autoscaling_service_account_id | **string**

ID of the new service account to be used by the Instance Groups service. ||
|#

## UpdateClusterConfigSpec {#yandex.cloud.dataproc.v1.UpdateClusterConfigSpec}

#|
||Field | Description ||
|| hadoop | **[HadoopConfig](#yandex.cloud.dataproc.v1.HadoopConfig)**

Hadoop specific options ||
|| subclusters_spec[] | **[UpdateSubclusterConfigSpec](#yandex.cloud.dataproc.v1.UpdateSubclusterConfigSpec)**

New configuration for subclusters in a cluster. ||
|#

## HadoopConfig {#yandex.cloud.dataproc.v1.HadoopConfig}

Hadoop configuration that describes services installed in a cluster,
their properties and settings.

#|
||Field | Description ||
|| services[] | enum **Service**

Set of services used in the cluster (if empty, the default set is used).

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
|| oslogin_enabled | **bool**

Oslogin enable on cluster nodes ||
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

## UpdateSubclusterConfigSpec {#yandex.cloud.dataproc.v1.UpdateSubclusterConfigSpec}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subcluster to update.
To get the subcluster ID make a [SubclusterService.List](../Subcluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the subcluster.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

Resource configuration for each host in the subcluster. ||
|| hosts_count | **int64**

Number of hosts in the subcluster.

The minimum value is 1. ||
|| autoscaling_config | **[AutoscalingConfig](#yandex.cloud.dataproc.v1.AutoscalingConfig)**

Configuration for instance group based subclusters ||
|#

## Resources {#yandex.cloud.dataproc.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the resource preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](../../../concepts/instance-types.md).

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
For more information, see [Preemptible Virtual Machines](../../../../compute/concepts/preemptible-vm.md). ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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