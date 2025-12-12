---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-greenplum/cli-ref-beta/cluster/restore.md
---

# yc beta managed-greenplum cluster restore

Creates a new Greenplum® cluster using the specified backup.

#### Command Usage

Syntax: 

`yc beta managed-greenplum cluster restore <BACKUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--backup-id`|<b>`string`</b><br/>ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups] request.|
|`--config`|<b>`shorthand/json`</b><br/>Greenplum® cluster config.<br/>Shorthand Syntax:<br/>{<br/>access = {<br/>data-lens = bool,<br/>data-transfer = bool,<br/>web-sql = bool,<br/>yandex-query = bool<br/>},<br/>assign-public-ip = bool,<br/>backup-window-start = timeofday,<br/>subnet-id = str,<br/>zone-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"access": {<br/>"data-lens": "bool",<br/>"data-transfer": "bool",<br/>"web-sql": "bool",<br/>"yandex-query": "bool"<br/>},<br/>"assign-public-ip": "bool",<br/>"backup-window-start": "timeofday",<br/>"subnet-id": "str",<br/>"zone-id": "str"<br/>}"<br/>Fields:<br/>access -> (struct)<br/>Access policy for external services.<br/>data-lens -> (bool)<br/>Allows data export from the cluster to DataLens.<br/>data-transfer -> (bool)<br/>Allows access for DataTransfer.<br/>web-sql -> (bool)<br/>Allows SQL queries to the cluster databases from the management console.<br/>yandex-query -> (bool)<br/>Allow access for YandexQuery.<br/>assign-public-ip -> (bool)<br/>Determines whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * 'false' - do not assign a public IP to the master host. * 'true' - assign a public IP to the master host.<br/>backup-window-start -> (timeofday)<br/>Time to start the daily backup, in the UTC timezone.<br/>subnet-id -> (string)<br/>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].<br/>zone-id -> (string)<br/>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.|
|`--deletion-protection`|Determines whether the cluster is protected from being deleted.|
|`--description`|<b>`string`</b><br/>Description of the Greenplum® cluster.|
|`--environment`|<b>`enum`</b><br/>Deployment environment of the Greenplum® cluster. Possible Values: 'production', 'prestable'|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the Greenplum® cluster in.|
|`--host-group-ids`|<b>`strings`</b><br/>Host groups to place VMs of cluster on.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the Greenplum® cluster as 'key:value' pairs. For example, "project":"mvp" or "source":"dictionary".|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>A Greenplum® cluster maintenance window. Should be defined by either one of the two options.<br/>Shorthand Syntax:<br/>{<br/>policy = anytime={} \| weekly-maintenance-window={<br/>day = MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN,<br/>hour = int<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"policy": {<br/>"anytime": {},<br/>"weekly-maintenance-window": {<br/>"day": "MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN",<br/>"hour": "int"<br/>}<br/>}<br/>}"<br/>Fields:<br/>policy -> (oneof<anytime\|weekly-maintenance-window>)<br/>Oneof policy field<br/>anytime -> (struct)<br/>An any-time maintenance window.<br/>weekly-maintenance-window -> (struct)<br/>A weekly maintenance window.<br/>day -> (enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>)<br/>Day of the week.<br/>hour -> (int)<br/>Hour of the day in the UTC timezone.|
|`--master-host-group-ids`|<b>`strings`</b><br/>Host groups hosting VMs of the master subcluster.|
|`--master-resources`|<b>`shorthand/json`</b><br/>Resources of the Greenplum® master subcluster.<br/>Shorthand Syntax:<br/>{<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}"<br/>Fields:<br/>disk-size -> (int)<br/>Volume of the storage used by the host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources allocated to a host. Available presets are listed in the documentation.|
|`--name`|<b>`string`</b><br/>Name of the Greenplum® cluster. The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the network to create the cluster in.|
|`--placement-group-id`|<b>`string`</b><br/>ID of the placement group.|
|`--restore-only`|<b>`strings`</b><br/>List of databases and tables to restore|
|`--security-group-ids`|<b>`strings`</b><br/>User security groups.|
|`--segment-host-count`|<b>`int`</b><br/>Number of segment hosts|
|`--segment-host-group-ids`|<b>`strings`</b><br/>Host groups hosting VMs of the segment subcluster.|
|`--segment-in-host`|<b>`int`</b><br/>Number of segments on each host|
|`--segment-resources`|<b>`shorthand/json`</b><br/>Resources of the Greenplum® segment subcluster.<br/>Shorthand Syntax:<br/>{<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}"<br/>Fields:<br/>disk-size -> (int)<br/>Volume of the storage used by the host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources allocated to a host. Available presets are listed in the documentation.|
|`--service-account-id`|<b>`string`</b><br/>Service account that will be used to access a Yandex Cloud resources|
|`--time`|<b>`time`</b><br/>Timestamp of the moment to which the Greenplum cluster should be restored. (RFC3339)|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
