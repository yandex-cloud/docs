---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.List {#List}

Retrieves the list of OpenSearch clusters that belong to the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.mdb.opensearch.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.mdb.opensearch.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.mdb.opensearch.v1.ListClustersRequest}

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

Required field. ID of the folder to list OpenSearch clusters in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns
a [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListClustersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListClustersResponse)
returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.mdb.opensearch.v1.Cluster) field.

2. An `=` operator.

3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## ListClustersResponse {#yandex.cloud.mdb.opensearch.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
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
      "config": {
        "version": "string",
        "opensearch": {
          "plugins": [
            "string"
          ],
          "nodeGroups": [
            {
              "name": "string",
              "resources": {
                "resourcePresetId": "string",
                "diskSize": "int64",
                "diskTypeId": "string"
              },
              "hostsCount": "int64",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": "bool",
              "roles": [
                "GroupRole"
              ],
              "diskSizeAutoscaling": {
                "plannedUsageThreshold": "int64",
                "emergencyUsageThreshold": "int64",
                "diskSizeLimit": "int64"
              }
            }
          ],
          // Includes only one of the fields `opensearchConfigSet_2`
          "opensearchConfigSet_2": {
            "effectiveConfig": {
              "maxClauseCount": "google.protobuf.Int64Value",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            },
            "userConfig": {
              "maxClauseCount": "google.protobuf.Int64Value",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            },
            "defaultConfig": {
              "maxClauseCount": "google.protobuf.Int64Value",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            }
          },
          // end of the list of possible fields
          "keystoreSettings": [
            "string"
          ]
        },
        "dashboards": {
          "nodeGroups": [
            {
              "name": "string",
              "resources": {
                "resourcePresetId": "string",
                "diskSize": "int64",
                "diskTypeId": "string"
              },
              "hostsCount": "int64",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": "bool",
              "diskSizeAutoscaling": {
                "plannedUsageThreshold": "int64",
                "emergencyUsageThreshold": "int64",
                "diskSizeLimit": "int64"
              }
            }
          ]
        },
        "access": {
          "dataTransfer": "bool",
          "serverless": "bool"
        }
      },
      "networkId": "string",
      "health": "Health",
      "status": "Status",
      "securityGroupIds": [
        "string"
      ],
      "serviceAccountId": "string",
      "deletionProtection": "bool",
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
        "delayedUntil": "google.protobuf.Timestamp",
        "latestMaintenanceTime": "google.protobuf.Timestamp",
        "nextMaintenanceWindowTime": "google.protobuf.Timestamp"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.opensearch.v1.Cluster)**

List of OpenSearch clusters. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClustersRequest.pageSize](#yandex.cloud.mdb.opensearch.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.mdb.opensearch.v1.ListClustersRequest) parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.mdb.opensearch.v1.Cluster}

An OpenSearch cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the OpenSearch cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folderId | **string**

ID of the folder that the OpenSearch cluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was created. ||
|| name | **string**

Name of the OpenSearch cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the OpenSearch cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the OpenSearch cluster as `key:value` pairs.
Maximum 64 labels per resource. ||
|| environment | enum **Environment**

Deployment environment of the OpenSearch cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.opensearch.v1.Monitoring)**

Description of monitoring systems relevant to the OpenSearch cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.opensearch.v1.ClusterConfig)**

Configuration of the OpenSearch cluster. ||
|| networkId | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for at least one host in the cluster is not ALIVE). ||
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
|| securityGroupIds[] | **string**

User security groups. ||
|| serviceAccountId | **string**

ID of the service account used to access Object Storage. ||
|| deletionProtection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenanceWindow`. ||
|#

## Monitoring {#yandex.cloud.mdb.opensearch.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the OpenSearch cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.opensearch.v1.ClusterConfig}

The OpenSearch cluster configuration.

#|
||Field | Description ||
|| version | **string**

Version of the OpenSearch server software. ||
|| opensearch | **[OpenSearch](#yandex.cloud.mdb.opensearch.v1.OpenSearch)**

OpenSearch configuration. ||
|| dashboards | **[Dashboards](#yandex.cloud.mdb.opensearch.v1.Dashboards)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|#

## OpenSearch {#yandex.cloud.mdb.opensearch.v1.OpenSearch}

The OpenSearch host group type configuration.

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup)**

Host groups of the OpenSearch type. ||
|| opensearchConfigSet_2 | **[OpenSearchConfigSet2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2)**

Includes only one of the fields `opensearchConfigSet_2`. ||
|| keystoreSettings[] | **string**

Keystore entries names. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup}

Configuration of the host group.

#|
||Field | Description ||
|| name | **string**

Name of the group. Must be 1-63 characters long. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **int64**

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **bool**

Determines whether a public IP is assigned to the hosts in the group. ||
|| roles[] | enum **GroupRole**

Roles of the host group.

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host. ||
|| diskSize | **int64**

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **int64**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **int64**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **int64**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## OpenSearchConfigSet2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2}

#|
||Field | Description ||
|| effectiveConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

Required field.  ||
|| userConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|| defaultConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

#|
||Field | Description ||
|| maxClauseCount | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

the maximum number of allowed boolean clauses in a query ||
|| fielddataCacheSize | **string**

the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata ||
|| reindexRemoteWhitelist | **string** ||
|#

## Dashboards {#yandex.cloud.mdb.opensearch.v1.Dashboards}

The Dashboards host group type configuration.

#|
||Field | Description ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup)**

Host groups of the Dashboards type. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Name of the group. 1-63 characters long. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **int64**

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **bool**

Determines whether a public IP is assigned to the hosts in the group. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| dataTransfer | **bool**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **bool**

Determines whether the access to Serverless is allowed. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayedUntil | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Delay time for the maintenance operation. ||
|| latestMaintenanceTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the last maintenance window. ||
|| nextMaintenanceWindowTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the next maintenance window. ||
|#