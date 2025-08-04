---
editable: false
apiPlayground:
  - '{"url":"https://{{ api-host-mdb }}/managed-opensearch/v1/clusters","method":"get","path":null,"query":{"type":"object","properties":{"folderId":{"description":"**string**\n\nRequired field. ID of the folder to list OpenSearch clusters in.\n\nTo get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.","type":"string"},"pageSize":{"description":"**string** (int64)\n\nThe maximum number of results per page to return.\n\nIf the number of available results is larger than `pageSize`, the service returns\na [ListClustersResponse.nextPageToken](/docs/managed-opensearch/api-ref/Cluster/list#yandex.cloud.mdb.opensearch.v1.ListClustersResponse) that can be used to get the next page of results in subsequent list requests.","type":"string","format":"int64"},"pageToken":{"description":"**string**\n\nPage token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](/docs/managed-opensearch/api-ref/Cluster/list#yandex.cloud.mdb.opensearch.v1.ListClustersResponse)\nreturned by the previous list request.","type":"string"},"filter":{"description":"**string**\n\nA filter expression that filters resources listed in the response.\n\nThe expression must specify:\n\n1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-opensearch/api-ref/Cluster/get#yandex.cloud.mdb.opensearch.v1.Cluster) field.\n\n2. An `=` operator.\n\n3. The value in double quotes (`\"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.","type":"string"}},"required":["folderId"],"additionalProperties":false},"body":null,"definitions":null}'
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/list.md
---

# Managed Service for OpenSearch API, REST: Cluster.List

Retrieves the list of OpenSearch clusters that belong to the specified folder.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters
```

## Query parameters {#yandex.cloud.mdb.opensearch.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list OpenSearch clusters in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

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

## Response {#yandex.cloud.mdb.opensearch.v1.ListClustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "environment": "string",
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
                "diskSize": "string",
                "diskTypeId": "string"
              },
              "hostsCount": "string",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": "boolean",
              "roles": [
                "string"
              ],
              "diskSizeAutoscaling": {
                "plannedUsageThreshold": "string",
                "emergencyUsageThreshold": "string",
                "diskSizeLimit": "string"
              }
            }
          ],
          // Includes only one of the fields `opensearchConfigSet_2`
          "opensearchConfigSet_2": {
            "effectiveConfig": {
              "maxClauseCount": "string",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            },
            "userConfig": {
              "maxClauseCount": "string",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            },
            "defaultConfig": {
              "maxClauseCount": "string",
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
                "diskSize": "string",
                "diskTypeId": "string"
              },
              "hostsCount": "string",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": "boolean",
              "diskSizeAutoscaling": {
                "plannedUsageThreshold": "string",
                "emergencyUsageThreshold": "string",
                "diskSizeLimit": "string"
              }
            }
          ]
        },
        "access": {
          "dataTransfer": "boolean",
          "serverless": "boolean"
        },
        "snapshotManagement": {
          "snapshotSchedule": {
            // Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`
            "hourlySnapshotSchedule": {
              "minute": "string"
            },
            "dailySnapshotSchedule": {
              "hour": "string",
              "minute": "string"
            },
            "weeklySnapshotSchedule": {
              "day": "string",
              "hour": "string",
              "minute": "string"
            }
            // end of the list of possible fields
          },
          "snapshotMaxAgeDays": "string"
        }
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "securityGroupIds": [
        "string"
      ],
      "serviceAccountId": "string",
      "deletionProtection": "boolean",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": "object",
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        }
        // end of the list of possible fields
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string",
        "latestMaintenanceTime": "string",
        "nextMaintenanceWindowTime": "string"
      },
      "diskEncryptionKeyId": "string"
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
|| createdAt | **string** (date-time)

Time when the cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the OpenSearch cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the OpenSearch cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
Maximum 64 labels per resource. ||
|| environment | **enum** (Environment)

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
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-opensearch/api-ref/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | **enum** (Status)

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
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenanceWindow`. ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
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
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration ||
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
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| roles[] | **enum** (GroupRole)

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
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

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
|| maxClauseCount | **string** (int64)

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
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| dataTransfer | **boolean**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **boolean**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

Snapshot management configuration

#|
||Field | Description ||
|| snapshotSchedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**

Snapshot creation schedule ||
|| snapshotMaxAgeDays | **string** (int64)

Snapshot max age in days ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

Snapshot creation schedule

#|
||Field | Description ||
|| hourlySnapshotSchedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Hourly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| dailySnapshotSchedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Daily based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| weeklySnapshotSchedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Weekly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `WEEK_DAY_UNSPECIFIED`
- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayedUntil | **string** (date-time)

Delay time for the maintenance operation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

Time of the last maintenance window.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

Time of the next maintenance window.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#