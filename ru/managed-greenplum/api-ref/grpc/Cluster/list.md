---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.List {#List}

Retrieves a list of Greenplum® clusters that belong to the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.mdb.greenplum.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.mdb.greenplum.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.mdb.greenplum.v1.ListClustersRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list Greenplum® clusters in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClustersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClustersResponse) returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.mdb.greenplum.v1.Cluster) field.

2. An `=` operator.

3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## ListClustersResponse {#yandex.cloud.mdb.greenplum.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "config": {
        "version": "string",
        "backupWindowStart": "google.type.TimeOfDay",
        "backupRetainPeriodDays": "google.protobuf.Int64Value",
        "access": {
          "dataLens": "bool",
          "webSql": "bool",
          "dataTransfer": "bool",
          "yandexQuery": "bool"
        },
        "zoneId": "string",
        "subnetId": "string",
        "assignPublicIp": "bool"
      },
      "description": "string",
      "labels": "string",
      "environment": "Environment",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "masterConfig": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "int64",
          "diskTypeId": "string"
        }
      },
      "segmentConfig": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "int64",
          "diskTypeId": "string"
        }
      },
      "masterHostCount": "int64",
      "segmentHostCount": "int64",
      "segmentInHost": "int64",
      "networkId": "string",
      "health": "Health",
      "status": "Status",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": "AnytimeMaintenanceWindow",
        "weeklyMaintenanceWindow": {
          "day": "WeekDay",
          "hour": "int64"
        }
        // end of the list of possible fields
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "google.protobuf.Timestamp"
      },
      "securityGroupIds": [
        "string"
      ],
      "userName": "string",
      "deletionProtection": "bool",
      "hostGroupIds": [
        "string"
      ],
      "clusterConfig": {
        // Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`
        "greenplumConfigSet_6_17": {
          "effectiveConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue"
          },
          "userConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue"
          },
          "defaultConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue"
          }
        },
        "greenplumConfigSet_6_19": {
          "effectiveConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement"
          },
          "userConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement"
          },
          "defaultConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement"
          }
        },
        "greenplumConfigSet_6_21": {
          "effectiveConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          },
          "userConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          },
          "defaultConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          }
        },
        "greenplumConfigSet_6_22": {
          "effectiveConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          },
          "userConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          },
          "defaultConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          }
        },
        "greenplumConfigSet_6": {
          "effectiveConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          },
          "userConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          },
          "defaultConfig": {
            "maxConnections": "google.protobuf.Int64Value",
            "maxSlotWalKeepSize": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerSegment": "google.protobuf.Int64Value",
            "gpWorkfileLimitPerQuery": "google.protobuf.Int64Value",
            "gpWorkfileLimitFilesPerQuery": "google.protobuf.Int64Value",
            "maxPreparedTransactions": "google.protobuf.Int64Value",
            "gpWorkfileCompression": "google.protobuf.BoolValue",
            "maxStatementMem": "google.protobuf.Int64Value",
            "logStatement": "LogStatement",
            "gpAddColumnInheritsTableSetting": "google.protobuf.BoolValue"
          }
        },
        // end of the list of possible fields
        "pool": {
          "effectiveConfig": {
            "mode": "PoolMode",
            "size": "google.protobuf.Int64Value",
            "clientIdleTimeout": "google.protobuf.Int64Value"
          },
          "userConfig": {
            "mode": "PoolMode",
            "size": "google.protobuf.Int64Value",
            "clientIdleTimeout": "google.protobuf.Int64Value"
          },
          "defaultConfig": {
            "mode": "PoolMode",
            "size": "google.protobuf.Int64Value",
            "clientIdleTimeout": "google.protobuf.Int64Value"
          }
        },
        "backgroundActivities": {
          "tableSizes": {
            "starts": [
              {
                "hours": "int64",
                "minutes": "int64"
              }
            ]
          },
          "analyzeAndVacuum": {
            "start": {
              "hours": "int64",
              "minutes": "int64"
            },
            "analyzeTimeout": "google.protobuf.Int64Value",
            "vacuumTimeout": "google.protobuf.Int64Value"
          },
          "queryKillerScripts": {
            "idle": {
              "enable": "google.protobuf.BoolValue",
              "maxAge": "google.protobuf.Int64Value",
              "ignoreUsers": [
                "string"
              ]
            },
            "idleInTransaction": {
              "enable": "google.protobuf.BoolValue",
              "maxAge": "google.protobuf.Int64Value",
              "ignoreUsers": [
                "string"
              ]
            },
            "longRunning": {
              "enable": "google.protobuf.BoolValue",
              "maxAge": "google.protobuf.Int64Value",
              "ignoreUsers": [
                "string"
              ]
            }
          }
        },
        "pxfConfig": {
          "effectiveConfig": {
            "connectionTimeout": "google.protobuf.Int64Value",
            "uploadTimeout": "google.protobuf.Int64Value",
            "maxThreads": "google.protobuf.Int64Value",
            "poolAllowCoreThreadTimeout": "google.protobuf.BoolValue",
            "poolCoreSize": "google.protobuf.Int64Value",
            "poolQueueCapacity": "google.protobuf.Int64Value",
            "poolMaxSize": "google.protobuf.Int64Value",
            "xmx": "google.protobuf.Int64Value",
            "xms": "google.protobuf.Int64Value"
          },
          "userConfig": {
            "connectionTimeout": "google.protobuf.Int64Value",
            "uploadTimeout": "google.protobuf.Int64Value",
            "maxThreads": "google.protobuf.Int64Value",
            "poolAllowCoreThreadTimeout": "google.protobuf.BoolValue",
            "poolCoreSize": "google.protobuf.Int64Value",
            "poolQueueCapacity": "google.protobuf.Int64Value",
            "poolMaxSize": "google.protobuf.Int64Value",
            "xmx": "google.protobuf.Int64Value",
            "xms": "google.protobuf.Int64Value"
          },
          "defaultConfig": {
            "connectionTimeout": "google.protobuf.Int64Value",
            "uploadTimeout": "google.protobuf.Int64Value",
            "maxThreads": "google.protobuf.Int64Value",
            "poolAllowCoreThreadTimeout": "google.protobuf.BoolValue",
            "poolCoreSize": "google.protobuf.Int64Value",
            "poolQueueCapacity": "google.protobuf.Int64Value",
            "poolMaxSize": "google.protobuf.Int64Value",
            "xmx": "google.protobuf.Int64Value",
            "xms": "google.protobuf.Int64Value"
          }
        }
      },
      "cloudStorage": {
        "enable": "bool"
      },
      "masterHostGroupIds": [
        "string"
      ],
      "segmentHostGroupIds": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.greenplum.v1.Cluster)**

List of Greenplum® cluster resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClustersRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListClustersRequest), use the `nextPageToken` as the value for the [ListClustersRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListClustersRequest) parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.mdb.greenplum.v1.Cluster}

A Greenplum® cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the Greenplum® cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folderId | **string**

ID of the folder that the Greenplum® cluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was created. ||
|| name | **string**

Required field. Name of the Greenplum® cluster.
The name is unique within the folder. ||
|| config | **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig)**

Greenplum® cluster configuration. ||
|| description | **string**

Description of the Greenplum® cluster. ||
|| labels | **string**

Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. ||
|| environment | enum **Environment**

Deployment environment of the Greenplum® cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.greenplum.v1.Monitoring)**

Description of monitoring systems relevant to the Greenplum® cluster. ||
|| masterConfig | **[MasterSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig)**

Configuration of the Greenplum® master subcluster. ||
|| segmentConfig | **[SegmentSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig)**

Configuration of the Greenplum® segment subcluster. ||
|| masterHostCount | **int64**

Number of hosts in the master subcluster. ||
|| segmentHostCount | **int64**

Number of hosts in the segment subcluster. ||
|| segmentInHost | **int64**

Number of segments per host. ||
|| networkId | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is not ALIVE).
- `UNBALANCED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is UNBALANCED). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster has encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster has stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| userName | **string**

Owner user name. ||
|| deletionProtection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| clusterConfig | **[ClusterConfigSet](#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet)**

Greenplum® and Odyssey® configuration. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage)**

Cloud storage settings ||
|| masterHostGroupIds[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segmentHostGroupIds[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|#

## GreenplumConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig}

#|
||Field | Description ||
|| version | **string**

Version of the Greenplum® server software. ||
|| backupWindowStart | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**

Access policy for external services. ||
|| zoneId | **string**

ID of the availability zone the cluster belongs to.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.networkId](#yandex.cloud.mdb.greenplum.v1.Cluster)). ||
|| assignPublicIp | **bool**

Determines whether the cluster has a public IP address.

After the cluster has been created, this setting cannot be changed. ||
|#

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| dataLens | **bool**

Allows data export from the cluster to DataLens. ||
|| webSql | **bool**

Allows SQL queries to the cluster databases from the management console. ||
|| dataTransfer | **bool**

Allows access for DataTransfer. ||
|| yandexQuery | **bool**

Allow access for YandexQuery. ||
|#

## Monitoring {#yandex.cloud.mdb.greenplum.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Greenplum® cluster. ||
|#

## MasterSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Computational resources allocated to Greenplum® master subcluster hosts. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| diskSize | **int64**

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## SegmentSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Computational resources allocated to Greenplum® segment subcluster hosts. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.AnytimeMaintenanceWindow)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.AnytimeMaintenanceWindow}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week.

- `WEEK_DAY_UNSPECIFIED`
- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **int64**

Hour of the day in the UTC timezone. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayedUntil | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Delay time for the maintenance operation. ||
|#

## ClusterConfigSet {#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet}

#|
||Field | Description ||
|| greenplumConfigSet_6_17 | **[GreenplumConfigSet6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_17)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6_19 | **[GreenplumConfigSet6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_19)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6_21 | **[GreenplumConfigSet6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_21)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6_22 | **[GreenplumConfigSet6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_22)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| greenplumConfigSet_6 | **[GreenplumConfigSet6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6)**

Includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`. ||
|| pool | **[ConnectionPoolerConfigSet](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet)**

Odyssey® pool settings. ||
|| backgroundActivities | **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig)**

Managed Greenplum® background tasks configuration. ||
|| pxfConfig | **[PXFConfigSet](#yandex.cloud.mdb.greenplum.v1.PXFConfigSet)** ||
|#

## GreenplumConfigSet6_17 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_17}

Configuration settings version 6.17

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

Required field. Effective settings for a Greenplum® cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_17 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17}

#|
||Field | Description ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment. ||
|| maxSlotWalKeepSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| gpWorkfileLimitPerSegment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment). ||
|| gpWorkfileLimitPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query). ||
|| gpWorkfileLimitFilesPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of temporary spill files allowed per query at each segment.

Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.

The current query is terminated if the limit is exceeded.

Set to zero to disable the limit.

Master session reloads if the parameter changes.

Default value is 10000.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query). ||
|| maxPreparedTransactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of transactions that can be in the `prepared` state simultaneously.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). ||
|| gpWorkfileCompression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the spill files are compressed or not.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression). ||
|#

## GreenplumConfigSet6_19 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_19}

Configuration settings version 6.19

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

Required field. Effective settings for a Greenplum® cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_19 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19}

#|
||Field | Description ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment. ||
|| maxSlotWalKeepSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| gpWorkfileLimitPerSegment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment). ||
|| gpWorkfileLimitPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query). ||
|| gpWorkfileLimitFilesPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of temporary spill files allowed per query at each segment.

Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.

The current query is terminated if the limit is exceeded.

Set to zero to disable the limit.

Master session reloads if the parameter changes.

Default value is 10000.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query). ||
|| maxPreparedTransactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of transactions that can be in the `prepared` state simultaneously.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). ||
|| gpWorkfileCompression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the spill files are compressed or not.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression). ||
|| maxStatementMem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum memory limit for a query, in bytes.

Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high.

Taking into account the configuration of a single segment host, calculate `maxStatementMem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`.

When changing both `maxStatementMem` and `statement_mem`, `maxStatementMem` must be changed first, or listed first in the `postgresql.conf` file.

Default value is 2097152000 (2000 MB).

More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). ||
|| logStatement | enum **LogStatement**

Logged SQL statements.

`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|#

## GreenplumConfigSet6_21 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_21}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

Required field. Effective settings for a Greenplum®  cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_21 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21}

#|
||Field | Description ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment ||
|| maxSlotWalKeepSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gpWorkfileLimitPerSegment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment ||
|| gpWorkfileLimitPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query ||
|| gpWorkfileLimitFilesPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| maxPreparedTransactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gpWorkfileCompression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| logStatement | enum **LogStatement**

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## GreenplumConfigSet6_22 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_22}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

Required field. Effective settings for a Greenplum®  cluster (a combination of settings defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

User-defined settings for a Greenplum® cluster. ||
|| defaultConfig | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_22 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22}

#|
||Field | Description ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment ||
|| maxSlotWalKeepSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gpWorkfileLimitPerSegment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment ||
|| gpWorkfileLimitPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query ||
|| gpWorkfileLimitFilesPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| maxPreparedTransactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gpWorkfileCompression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| logStatement | enum **LogStatement**

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## GreenplumConfigSet6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Required field. Effective settings for a Greenplum (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

User-defined settings for a Greenplum. ||
|| defaultConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Default configuration for a Greenplum. ||
|#

## GreenplumConfig6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6}

#|
||Field | Description ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment ||
|| maxSlotWalKeepSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gpWorkfileLimitPerSegment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment ||
|| gpWorkfileLimitPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query ||
|| gpWorkfileLimitFilesPerQuery | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| maxPreparedTransactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gpWorkfileCompression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| logStatement | enum **LogStatement**

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## ConnectionPoolerConfigSet {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Required field. Effective settings for an Odyssey® pooler (a combination of settings defined in `ConnectionPoolerConfigSet.userConfig` and `ConnectionPoolerConfigSet.defaultConfig`). ||
|| userConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

User-defined settings for an Odyssey® pooler. ||
|| defaultConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Default configuration for an Odyssey® pooler. ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| mode | enum **PoolMode**

Route server pool mode.

- `POOL_MODE_UNSPECIFIED`
- `SESSION`: Assign server connection to a client until it disconnects. Default value.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.

Set to zero to disable the limit. ||
|| clientIdleTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Server pool idle timeout, in seconds.

A server connection closes after being idle for the specified time.

Set to zero to disable the limit. ||
|#

## BackgroundActivitiesConfig {#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig}

#|
||Field | Description ||
|| tableSizes | **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes)**

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema. ||
|| analyzeAndVacuum | **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum)**

Configuration for `ANALYZE` and `VACUUM` operations. ||
|| queryKillerScripts | **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts)**

Configuration for long running queries killer. ||
|#

## TableSizes {#yandex.cloud.mdb.greenplum.v1.TableSizes}

#|
||Field | Description ||
|| starts[] | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|#

## BackgroundActivityStartAt {#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt}

#|
||Field | Description ||
|| hours | **int64** ||
|| minutes | **int64** ||
|#

## AnalyzeAndVacuum {#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum}

#|
||Field | Description ||
|| start | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|| analyzeTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate. ||
|| vacuumTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate. ||
|#

## QueryKillerScripts {#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts}

#|
||Field | Description ||
|| idle | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle` state. ||
|| idleInTransaction | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle in transaction` state. ||
|| longRunning | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries (in any state). ||
|#

## QueryKiller {#yandex.cloud.mdb.greenplum.v1.QueryKiller}

#|
||Field | Description ||
|| enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| maxAge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum duration for this type of queries (in seconds). ||
|| ignoreUsers[] | **string**

Ignore these users when considering queries to terminate ||
|#

## PXFConfigSet {#yandex.cloud.mdb.greenplum.v1.PXFConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

Required field.  ||
|| userConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

User-defined settings. ||
|| defaultConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

Default configuration. ||
|#

## PXFConfig {#yandex.cloud.mdb.greenplum.v1.PXFConfig}

#|
||Field | Description ||
|| connectionTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for connection to the Apache Tomcat® server when making read requests.

Specify values in seconds. ||
|| uploadTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for connection to the Apache Tomcat® server when making write requests.

Specify the values in seconds. ||
|| maxThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of the Apache Tomcat® threads.

To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation. ||
|| poolAllowCoreThreadTimeout | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the timeout for core streaming threads is permitted. ||
|| poolCoreSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of core streaming threads per pool. ||
|| poolQueueCapacity | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of requests you can add to a pool queue for core streaming threads.

If `0`, no pool queue is generated. ||
|| poolMaxSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum allowed number of core streaming threads. ||
|| xmx | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Initial size, in megabytes, of the JVM heap for the PXF daemon. ||
|| xms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size, in megabytes, of the JVM heap for the PXF daemon. ||
|#

## CloudStorage {#yandex.cloud.mdb.greenplum.v1.CloudStorage}

Cloud Storage Settings

#|
||Field | Description ||
|| enable | **bool**

enable Cloud Storage for cluster ||
|#