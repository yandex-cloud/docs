---
editable: false
apiPlayground:
  - url: https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            ID of the cluster to update.
            To get the cluster ID, make a [ClusterService.List](/docs/data-proc/api-ref/Cluster/list#List) request.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        description:
          description: |-
            **string**
            New description for the cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            A new set of cluster labels as `key:value` pairs.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        configSpec:
          description: |-
            **[UpdateClusterConfigSpec](/docs/data-proc/api-ref/Cluster/update#yandex.cloud.dataproc.v1.UpdateClusterConfigSpec)**
            Configuration and resources for hosts that should be created with the Yandex Data Processing cluster.
          $ref: '#/definitions/UpdateClusterConfigSpec'
        name:
          description: |-
            **string**
            New name for the Yandex Data Processing cluster. The name must be unique within the folder.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        serviceAccountId:
          description: |-
            **string**
            ID of the new service account to be used by the Yandex Data Processing manager agent.
          type: string
        bucket:
          description: |-
            **string**
            Name of the new Object Storage bucket to use for Yandex Data Processing jobs.
          type: string
        decommissionTimeout:
          description: |-
            **string** (int64)
            Timeout to gracefully decommission nodes. In seconds. Default value: 0
          type: string
          format: int64
        uiProxy:
          description: |-
            **boolean**
            Enable UI Proxy feature.
          type: boolean
        securityGroupIds:
          description: |-
            **string**
            User security groups.
          type: array
          items:
            type: string
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster
          type: boolean
        logGroupId:
          description: |-
            **string**
            ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service
          type: string
        autoscalingServiceAccountId:
          description: |-
            **string**
            ID of the new service account to be used by the Instance Groups service.
          type: string
      additionalProperties: false
    definitions:
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the resource preset for computational resources available to a host (CPU, memory etc.).
              All available presets are listed in the [documentation](/docs/data-proc/concepts/instance-types).
            type: string
          diskTypeId:
            description: |-
              **string**
              Type of the storage environment for the host.
              Possible values:
              * network-hdd - network HDD drive,
              * network-ssd - network SSD drive.
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage available to a host, in bytes.
            type: string
            format: int64
      AutoscalingConfig:
        type: object
        properties:
          maxHostsCount:
            description: |-
              **string** (int64)
              Upper limit for total instance subcluster count.
            type: string
            format: int64
          preemptible:
            description: |-
              **boolean**
              Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
              if their resources are needed by Compute.
              For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm).
            type: boolean
          measurementDuration:
            description: |-
              **string** (duration)
              Required field. Time in seconds allotted for averaging metrics.
            type: string
            format: duration
          warmupDuration:
            description: |-
              **string** (duration)
              The warmup time of the instance in seconds. During this time,
              traffic is sent to the instance, but instance metrics are not collected.
            type: string
            format: duration
          stabilizationDuration:
            description: |-
              **string** (duration)
              Minimum amount of time in seconds allotted for monitoring before
              Instance Groups can reduce the number of instances in the group.
              During this time, the group size doesn't decrease, even if the new metric values
              indicate that it should.
            type: string
            format: duration
          cpuUtilizationTarget:
            description: |-
              **string**
              Defines an autoscaling rule based on the average CPU utilization of the instance group.
            type: string
          decommissionTimeout:
            description: |-
              **string** (int64)
              Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120
            type: string
            format: int64
        required:
          - measurementDuration
      UpdateSubclusterConfigSpec:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the subcluster to update.
              To get the subcluster ID make a [SubclusterService.List](/docs/data-proc/api-ref/Subcluster/list#List) request.
            type: string
          name:
            description: |-
              **string**
              Name of the subcluster.
            pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
            type: string
          resources:
            description: |-
              **[Resources](/docs/data-proc/api-ref/Cluster/create#yandex.cloud.dataproc.v1.Resources)**
              Resource configuration for each host in the subcluster.
            $ref: '#/definitions/Resources'
          hostsCount:
            description: |-
              **string** (int64)
              Number of hosts in the subcluster.
            type: string
            format: int64
          autoscalingConfig:
            description: |-
              **[AutoscalingConfig](/docs/data-proc/api-ref/Cluster/create#yandex.cloud.dataproc.v1.AutoscalingConfig)**
              Configuration for instance group based subclusters
            $ref: '#/definitions/AutoscalingConfig'
      InitializationAction:
        type: object
        properties:
          uri:
            description: |-
              **string**
              URI of the executable file
            type: string
          args:
            description: |-
              **string**
              Arguments to the initialization action
            type: array
            items:
              type: string
          timeout:
            description: |-
              **string** (int64)
              Execution timeout
            type: string
            format: int64
      HadoopConfig:
        type: object
        properties:
          services:
            description: |-
              **enum** (Service)
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
              - `LIVY`
            type: array
            items:
              type: string
              enum:
                - SERVICE_UNSPECIFIED
                - HDFS
                - YARN
                - MAPREDUCE
                - HIVE
                - TEZ
                - ZOOKEEPER
                - HBASE
                - SQOOP
                - FLUME
                - SPARK
                - ZEPPELIN
                - OOZIE
                - LIVY
          properties:
            description: |-
              **object** (map<**string**, **string**>)
              Properties set for all hosts in `*-site.xml` configurations. The key should indicate
              the service and the property.
              For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property
              in the file `/etc/hadoop/conf/hdfs-site.xml`.
            type: string
          sshPublicKeys:
            description: |-
              **string**
              List of public SSH keys to access to cluster hosts.
            type: array
            items:
              type: string
          initializationActions:
            description: |-
              **[InitializationAction](/docs/data-proc/api-ref/Cluster/get#yandex.cloud.dataproc.v1.InitializationAction)**
              Set of init-actions
            type: array
            items:
              $ref: '#/definitions/InitializationAction'
          osloginEnabled:
            description: |-
              **boolean**
              Oslogin enable on cluster nodes
            type: boolean
      UpdateClusterConfigSpec:
        type: object
        properties:
          subclustersSpec:
            description: |-
              **[UpdateSubclusterConfigSpec](/docs/data-proc/api-ref/Cluster/update#yandex.cloud.dataproc.v1.UpdateSubclusterConfigSpec)**
              New configuration for subclusters in a cluster.
            type: array
            items:
              $ref: '#/definitions/UpdateSubclusterConfigSpec'
          hadoop:
            description: |-
              **[HadoopConfig](/docs/data-proc/api-ref/Cluster/get#yandex.cloud.dataproc.v1.HadoopConfig)**
              Hadoop specific options
            $ref: '#/definitions/HadoopConfig'
sourcePath: en/_api-ref/dataproc/v1/api-ref/Cluster/update.md
---

# Yandex Data Processing API, REST: Cluster.Update

Updates the configuration of the specified cluster.

## HTTP request

```
PATCH https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to update.

To get the cluster ID, make a [ClusterService.List](/docs/data-proc/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.dataproc.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "subclustersSpec": [
      {
        "id": "string",
        "name": "string",
        "resources": {
          "resourcePresetId": "string",
          "diskTypeId": "string",
          "diskSize": "string"
        },
        "hostsCount": "string",
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
    ],
    "hadoop": {
      "services": [
        "string"
      ],
      "properties": "object",
      "sshPublicKeys": [
        "string"
      ],
      "initializationActions": [
        {
          "uri": "string",
          "args": [
            "string"
          ],
          "timeout": "string"
        }
      ],
      "osloginEnabled": "boolean"
    }
  },
  "name": "string",
  "serviceAccountId": "string",
  "bucket": "string",
  "decommissionTimeout": "string",
  "uiProxy": "boolean",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "logGroupId": "string",
  "autoscalingServiceAccountId": "string"
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
|| description | **string**

New description for the cluster. ||
|| labels | **object** (map<**string**, **string**>)

A new set of cluster labels as `key:value` pairs. ||
|| configSpec | **[UpdateClusterConfigSpec](#yandex.cloud.dataproc.v1.UpdateClusterConfigSpec)**

Configuration and resources for hosts that should be created with the Yandex Data Processing cluster. ||
|| name | **string**

New name for the Yandex Data Processing cluster. The name must be unique within the folder. ||
|| serviceAccountId | **string**

ID of the new service account to be used by the Yandex Data Processing manager agent. ||
|| bucket | **string**

Name of the new Object Storage bucket to use for Yandex Data Processing jobs. ||
|| decommissionTimeout | **string** (int64)

Timeout to gracefully decommission nodes. In seconds. Default value: 0 ||
|| uiProxy | **boolean**

Enable UI Proxy feature. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| logGroupId | **string**

ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service ||
|| autoscalingServiceAccountId | **string**

ID of the new service account to be used by the Instance Groups service. ||
|#

## UpdateClusterConfigSpec {#yandex.cloud.dataproc.v1.UpdateClusterConfigSpec}

#|
||Field | Description ||
|| subclustersSpec[] | **[UpdateSubclusterConfigSpec](#yandex.cloud.dataproc.v1.UpdateSubclusterConfigSpec)**

New configuration for subclusters in a cluster. ||
|| hadoop | **[HadoopConfig](#yandex.cloud.dataproc.v1.HadoopConfig)**

Hadoop specific options ||
|#

## UpdateSubclusterConfigSpec {#yandex.cloud.dataproc.v1.UpdateSubclusterConfigSpec}

#|
||Field | Description ||
|| id | **string**

ID of the subcluster to update.

To get the subcluster ID make a [SubclusterService.List](/docs/data-proc/api-ref/Subcluster/list#List) request. ||
|| name | **string**

Name of the subcluster. ||
|| resources | **[Resources](#yandex.cloud.dataproc.v1.Resources)**

Resource configuration for each host in the subcluster. ||
|| hostsCount | **string** (int64)

Number of hosts in the subcluster. ||
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

## HadoopConfig {#yandex.cloud.dataproc.v1.HadoopConfig}

Hadoop configuration that describes services installed in a cluster,
their properties and settings.

#|
||Field | Description ||
|| services[] | **enum** (Service)

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
|| sshPublicKeys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initializationActions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction)**

Set of init-actions ||
|| osloginEnabled | **boolean**

Oslogin enable on cluster nodes ||
|#

## InitializationAction {#yandex.cloud.dataproc.v1.InitializationAction}

#|
||Field | Description ||
|| uri | **string**

URI of the executable file ||
|| args[] | **string**

Arguments to the initialization action ||
|| timeout | **string** (int64)

Execution timeout ||
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
    "clusterId": "string"
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
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
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
          "string"
        ],
        "properties": "object",
        "sshPublicKeys": [
          "string"
        ],
        "initializationActions": [
          {
            "uri": "string",
            "args": [
              "string"
            ],
            "timeout": "string"
          }
        ],
        "osloginEnabled": "boolean"
      }
    },
    "health": "string",
    "status": "string",
    "zoneId": "string",
    "serviceAccountId": "string",
    "bucket": "string",
    "uiProxy": "boolean",
    "securityGroupIds": [
      "string"
    ],
    "hostGroupIds": [
      "string"
    ],
    "deletionProtection": "boolean",
    "logGroupId": "string",
    "environment": "string",
    "autoscalingServiceAccountId": "string"
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
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.dataproc.v1.UpdateClusterMetadata)**

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

## UpdateClusterMetadata {#yandex.cloud.dataproc.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that is being updated. ||
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

## Cluster {#yandex.cloud.dataproc.v1.Cluster}

A Yandex Data Processing cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data).
- `ALIVE`: Object is alive and well (for example, all hosts of the cluster are alive).
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions). ||
|| status | **enum** (Status)

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

ID of service account for the Yandex Data Processing manager agent. ||
|| bucket | **string**

Object Storage bucket to be used for Yandex Data Processing jobs that are run in the cluster. ||
|| uiProxy | **boolean**

Whether UI Proxy feature is enabled. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| logGroupId | **string**

ID of the cloud logging log group to write logs. If not set, default log group for the folder will be used.
To prevent logs from being sent to the cloud set cluster property dataproc:disable_cloud_logging = true ||
|| environment | **enum** (Environment)

Environment of the cluster

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`
- `PRESTABLE` ||
|| autoscalingServiceAccountId | **string**

ID of service account for working with the Instance Groups service. ||
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
|| versionId | **string**

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
|| services[] | **enum** (Service)

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
|| sshPublicKeys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initializationActions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction2)**

Set of init-actions ||
|| osloginEnabled | **boolean**

Oslogin enable on cluster nodes ||
|#

## InitializationAction {#yandex.cloud.dataproc.v1.InitializationAction2}

#|
||Field | Description ||
|| uri | **string**

URI of the executable file ||
|| args[] | **string**

Arguments to the initialization action ||
|| timeout | **string** (int64)

Execution timeout ||
|#