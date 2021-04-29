---
editable: false
---

# Cluster
A set of methods for managing MySQL clusters.
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
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "mysqlConfig_5_7": {
      "effectiveConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number"
      },
      "userConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number"
      },
      "defaultConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number"
      }
    }
  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the MySQL cluster. This ID is assigned by Managed Service for MySQL at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the MySQL cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the MySQL cluster. The name must be unique within the folder, comply with RFC 1035 and be 1-63 characters long.</p> 
description | **string**<br><p>Description of the MySQL cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the MySQL cluster as `key:value` pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the MySQL cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the MySQL cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the MySQL cluster.</p> 
config | **object**<br><p>Configuration of the MySQL cluster.</p> 
config.<br>version | **string**<br><p>Version of MySQL server software.</p> 
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mysql/concepts/instance-types">documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>backupWindowStart | **object**<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>mysqlConfig_5_7 | **object**<br>
config.<br>mysqlConfig_5_7.<br>effectiveConfig | **object**<br><p>Effective settings for a MySQL 5.7 cluster (a combination of settings defined in `userConfig` and `defaultConfig`).</p> <p>Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig | **object**<br><p>User-defined settings for a MySQL 5.7 cluster.</p> <p>Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig | **object**<br><p>Default configuration for a MySQL 5.7 cluster.</p> <p>Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (`health` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (`health` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (`health` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (`health` for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[addHosts](addHosts.md) | Creates new hosts for a cluster.
[backup](backup.md) | Creates a backup for the specified MySQL cluster.
[create](create.md) | Creates a MySQL cluster in the specified folder.
[delete](delete.md) | Deletes the specified MySQL cluster.
[deleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster.
[get](get.md) | Returns the specified MySQL cluster.
[list](list.md) | Retrieves the list of MySQL clusters that belong to the specified folder.
[listBackups](listBackups.md) | Retrieves the list of available backups for the specified MySQL cluster.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified MySQL cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified MySQL cluster.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified MySQL cluster.
[restore](restore.md) | Creates a new MySQL cluster using the specified backup.
[start](start.md) | Starts the specified MySQL cluster.
[stop](stop.md) | Stops the specified MySQL cluster.
[update](update.md) | Modifies the specified MySQL cluster.