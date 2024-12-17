---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/cluster/update.md
---

# yc managed-greenplum cluster update

Update the specified Greenplum cluster

#### Command Usage

Syntax: 

`yc managed-greenplum cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Greenplum cluster id.|
|`--name`|<b>`string`</b><br/>Greenplum cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add.|
|`--new-name`|<b>`string`</b><br/>New name for the Greenplum cluster|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--user-password`|<b>`string`</b><br/>Owner user password. Must be 8-128 characters long.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Greenplum cluster.|
|`--master-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of master config resources for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>resource-id</code>:     ID of the preset for computational resources available on the host.</li> <li><code>disk-size</code>:     Volume of the storage available on the host in GB.</li> </ul>|
|`--segment-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of segment config resources for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>resource-id</code>:     ID of the preset for computational resources available on the host.</li> <li><code>disk-size</code>:     Volume of the storage available on the host in GB.</li> </ul>|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--cloud-storage`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of cloud storage for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>enabled</code>:     Enables cloud storage.</li> </ul>|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|
|`--datalens-access`|Allow access for DataLens.|
|`--websql-access`|Allow access for Web SQL.|
|`--datatransfer-access`|Allow access for DataTransfer.|
|`--yandexquery-access`|Allow access for Yandex Query.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retention time in days of automated backups|
|`--assign-public-ip`|Whether the host should get a public IP address.|
|`--connection-pooling-mode`|<b>`string`</b><br/>Connection pooler pooling mode Values: 'session', 'transaction'|
|`--connection-pooling-size`|<b>`int`</b><br/>Connection pooler size|
|`--connection-pooling-client-idle-timeout`|<b>`int`</b><br/>Connection pooler client idle timeout|
|`--pxf-connection-timeout`|<b>`int`</b><br/>Timeout for pxf connections|
|`--pxf-upload-timeout`|<b>`int`</b><br/>Timeout for uploading pxf connections|
|`--pxf-max-threads`|<b>`int`</b><br/>The maximum number of PXF tomcat threads.|
|`--pxf-pool-allow-core-thread-timeout`|Identifies whether or not core streaming threads are allowed to time out.|
|`--pxf-poll-core-size`|<b>`int`</b><br/>The number of core streaming threads.|
|`--pxf-pool-queue-capacity`|<b>`int`</b><br/>The capacity of the core streaming thread pool queue.|
|`--pxf-pool-max-size`|<b>`int`</b><br/>The maximum allowed number of core streaming threads.|
|`--pxf-xmx`|<b>`byteSize`</b><br/>Max jvm memory|
|`--pxf-xms`|<b>`byteSize`</b><br/>Starting jvm memory|
|`--analyze-and-vacuum`|<b>`ANALYZE`</b><br/>Configuration for ANALYZE and `VACUUM` background operations.<br/><br/>Possible property names:<br/><ul> <li><code>start_time</code>:     Time (HH:MM) in UTC time zone to start <code>ANALYZE</code> and <code>VACUUM</code> operations.</li> <li><code>analyze_timeout</code>:     Maximum duration of the <code>ANALYZE</code> operation, in seconds. The default value is <code>36000</code>. As soon as this period expires, the <code>ANALYZE</code> operation will be forced to terminate.</li> <li><code>vacuum_timeout</code>:     Maximum duration of the <code>VACUUM</code> operation, in seconds. The default value is <code>36000</code>. As soon as this period expires, the <code>VACUUM</code> operation will be forced to terminate.</li> </ul>|
|`--query-killer-idle`|<b>`idle`</b><br/>Configuration of script that kills long running queries that are in idle state.<br/><br/>Possible property names:<br/><ul> <li><code>enable</code>:     Enables query killer for this type of queries.</li> <li><code>max_age</code>:     Maximum duration for this type of queries (in seconds).</li> <li><code>ignore_users</code>:     Ignore these users when considering queries to terminate</li> </ul>|
|`--query-killer-idle-in-transaction`|<b>`idle`</b><br/>in transaction<br/>Configuration of script that kills long running queries that are in idle in transaction state.<br/><br/>Possible property names:<br/><ul> <li><code>enable</code>:     Enables query killer for this type of queries.</li> <li><code>max_age</code>:     Maximum duration for this type of queries (in seconds).</li> <li><code>ignore_users</code>:     Ignore these users when considering queries to terminate</li> </ul>|
|`--query-killer-long-running`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Configuration of script that kills long running queries (in any state).<br/><br/>Possible property names:<br/><ul> <li><code>enable</code>:     Enables query killer for this type of queries.</li> <li><code>max_age</code>:     Maximum duration for this type of queries (in seconds).</li> <li><code>ignore_users</code>:     Ignore these users when considering queries to terminate</li> </ul>|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
