---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/index.md
---

# Managed Service for OpenSearch API, REST: Cluster methods
A set of methods for managing OpenSearch clusters.
## JSON Representation {#representation}
```json 
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
          "assignPublicIp": true,
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
      "keystoreSettings": [
        "string"
      ],
      "opensearchConfigSet_2": {
        "effectiveConfig": {
          "maxClauseCount": "integer",
          "fielddataCacheSize": "string",
          "reindexRemoteWhitelist": "string"
        },
        "userConfig": {
          "maxClauseCount": "integer",
          "fielddataCacheSize": "string",
          "reindexRemoteWhitelist": "string"
        },
        "defaultConfig": {
          "maxClauseCount": "integer",
          "fielddataCacheSize": "string",
          "reindexRemoteWhitelist": "string"
        }
      }
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
          "assignPublicIp": true,
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      ]
    },
    "access": {
      "dataTransfer": true,
      "serverless": true
    }
  },
  "networkId": "string",
  "health": "string",
  "status": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "string",
    "latestMaintenanceTime": "string",
    "nextMaintenanceWindowTime": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation.</p> 
folderId | **string**<br><p>ID of the folder that the OpenSearch cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Time when the cluster was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long.</p> 
description | **string**<br><p>Description of the OpenSearch cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the OpenSearch cluster as ``key:value`` pairs. Maximum 64 labels per resource.</p> 
environment | **string**<br><p>Deployment environment of the OpenSearch cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the OpenSearch cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the OpenSearch cluster.</p> 
config | **object**<br><p>Configuration of the OpenSearch cluster.</p> <p>The OpenSearch cluster configuration.</p> 
config.<br>version | **string**<br><p>Version of the OpenSearch server software.</p> 
config.<br>opensearch | **object**<br><p>OpenSearch configuration.</p> <p>The OpenSearch host group type configuration.</p> 
config.<br>opensearch.<br>plugins[] | **string**<br><p>Names of the cluster plugins.</p> 
config.<br>opensearch.<br>nodeGroups[] | **object**<br><p>Host groups of the OpenSearch type.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>name | **string**<br><p>Name of the group. Must be 1-63 characters long.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to the hosts.</p> <p>A list of computational resources allocated to a host.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of hosts in the group.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zones the hosts belong to.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnets that the hosts belong to.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether a public IP is assigned to the hosts in the group.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>roles[] | **string**<br><p>Roles of the host group.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>diskSizeAutoscaling | **object**<br><p>Disk size autoscaling settings</p> 
config.<br>opensearch.<br>nodeGroups[].<br>diskSizeAutoscaling.<br>plannedUsageThreshold | **string** (int64)<br><p>Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>diskSizeAutoscaling.<br>emergencyUsageThreshold | **string** (int64)<br><p>Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>opensearch.<br>nodeGroups[].<br>diskSizeAutoscaling.<br>diskSizeLimit | **string** (int64)<br><p>Limit on how large the storage for database instances can automatically grow, in bytes.</p> 
config.<br>opensearch.<br>keystoreSettings[] | **string**<br><p>Keystore entries names.</p> 
config.<br>opensearch.<br>opensearchConfigSet_2 | **object**
config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig | **object**<br><p>Required.</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig.<br>fielddataCacheSize | **string**<br><p>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig.<br>reindexRemoteWhitelist | **string**
config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig | **object**
config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig.<br>fielddataCacheSize | **string**<br><p>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig.<br>reindexRemoteWhitelist | **string**
config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig | **object**
config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig.<br>fielddataCacheSize | **string**<br><p>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata</p> 
config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig.<br>reindexRemoteWhitelist | **string**
config.<br>dashboards | **object**<br><p>Dashboards configuration.</p> <p>The Dashboards host group type configuration.</p> 
config.<br>dashboards.<br>nodeGroups[] | **object**<br><p>Host groups of the Dashboards type.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>name | **string**<br><p>Name of the group. 1-63 characters long.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to the hosts.</p> <p>A list of computational resources allocated to a host.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of hosts in the group.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zones the hosts belong to.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnets that the hosts belong to.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether a public IP is assigned to the hosts in the group.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>diskSizeAutoscaling | **object**<br><p>Disk size autoscaling settings</p> 
config.<br>dashboards.<br>nodeGroups[].<br>diskSizeAutoscaling.<br>plannedUsageThreshold | **string** (int64)<br><p>Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>diskSizeAutoscaling.<br>emergencyUsageThreshold | **string** (int64)<br><p>Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>dashboards.<br>nodeGroups[].<br>diskSizeAutoscaling.<br>diskSizeLimit | **string** (int64)<br><p>Limit on how large the storage for database instances can automatically grow, in bytes.</p> 
config.<br>access | **object**<br><p>Access policy for external services.</p> <p>Access policy for external services.</p> 
config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Determines whether the access to Data Transfer is allowed.</p> 
config.<br>access.<br>serverless | **boolean** (boolean)<br><p>Determines whether the access to Serverless is allowed.</p> 
networkId | **string**<br><p>ID of the cloud network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Health of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is working normally (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster has encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster has stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
serviceAccountId | **string**<br><p>ID of the service account used to access Object Storage.</p> 
deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
maintenanceWindow | **object**<br><p>Cluster maintenance window. Should be defined by either one of the two options.</p> <p>An OpenSearch cluster maintenance window. Should be defined by either one of the two options.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br><p>An any-time maintenance window.</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br><p>A weekly maintenance window.</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> <ul> <li>MON: Monday</li> <li>TUE: Tuesday</li> <li>WED: Wednesday</li> <li>THU: Thursday</li> <li>FRI: Friday</li> <li>SAT: Saturday</li> <li>SUN: Sunday</li> </ul> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
plannedOperation | **object**<br><p>Maintenance operation planned at nearest <a href="/docs/managed-opensearch/api-ref/Cluster#representation">maintenanceWindow</a>.</p> 
plannedOperation.<br>info | **string**<br><p>The description of the operation.</p> <p>The maximum string length in characters is 256.</p> 
plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Delay time for the maintenance operation.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
plannedOperation.<br>latestMaintenanceTime | **string** (date-time)<br><p>Time of the last maintenance window.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
plannedOperation.<br>nextMaintenanceWindowTime | **string** (date-time)<br><p>Time of the next maintenance window.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 

## Methods {#methods}
Method | Description
--- | ---
[addDashboardsNodeGroup](addDashboardsNodeGroup.md) | Creates a Dashboards type host group.
[addOpenSearchNodeGroup](addOpenSearchNodeGroup.md) | Creates an OpenSearch type host group.
[backup](backup.md) | Creates a backup for the specified OpenSearch cluster.
[create](create.md) | Creates an OpenSearch cluster in the specified folder.
[delete](delete.md) | Deletes the specified OpenSearch cluster.
[deleteDashboardsNodeGroup](deleteDashboardsNodeGroup.md) | Deletes a Dashboards type host group.
[deleteOpenSearchNodeGroup](deleteOpenSearchNodeGroup.md) | Deletes an OpenSearch type host group.
[get](get.md) | Returns the specified OpenSearch cluster.
[getAuthSettings](getAuthSettings.md) | Retrieves auth settings for specified cluster.
[list](list.md) | Retrieves the list of OpenSearch clusters that belong to the specified folder.
[listBackups](listBackups.md) | Returns a list of available backups for the specified OpenSearch cluster.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified OpenSearch cluster. For detailed description, see the [Logs](/yandex-mdb-guide/concepts/logs.html) section in the developer's guide.
[listOperations](listOperations.md) | Retrieves the list of Operation resources for the specified cluster.
[move](move.md) | Moves the specified OpenSearch cluster to the specified folder.
[rescheduleMaintenance](rescheduleMaintenance.md) | Reschedules a planned maintenance operation.
[restore](restore.md) | Creates a new OpenSearch cluster using the specified backup.
[start](start.md) | Starts the specified OpenSearch cluster.
[stop](stop.md) | Stops the specified OpenSearch cluster.
[streamLogs](streamLogs.md) | Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.
[update](update.md) | Updates the specified OpenSearch cluster.
[updateAuthSettings](updateAuthSettings.md) | Updates auth settings for specified cluster.
[updateDashboardsNodeGroup](updateDashboardsNodeGroup.md) | Updates a Dashboards type host group.
[updateOpenSearchNodeGroup](updateOpenSearchNodeGroup.md) | Updates an OpenSearch type host group.