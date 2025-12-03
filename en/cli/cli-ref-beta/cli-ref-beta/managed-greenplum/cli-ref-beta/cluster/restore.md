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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--backup-id`|<b>`string`</b><br/>ID of the backup to create a cluster from.<br/><br/>To get the backup ID, use a [ClusterService.ListBackups] request.|
|`--config`|<b>`shorthand/json`</b><br/>Greenplum® cluster config.<br/><br/>Example:|
|`--config`|<b>`access={data-lens=true,`</b><br/>data-transfer=true, web-sql=true, yandex-query=true}, assign-public-ip=true, backup-window-start=05:20:00, subnet-id=value, zone-id=value<br/><br/>Shorthand Syntax:<br/>{access={data-lens=bool, data-transfer=bool, web-sql=bool, yandex-query=bool}, assign-public-ip=bool, backup-window-start=timeofday, subnet-id=str, zone-id=str}<br/>Fields:<br/>access               struct     — Access policy for external services.<br/>data-lens      bool  — Allows data export from the cluster to DataLens.<br/>data-transfer  bool  — Allows access for DataTransfer.<br/>web-sql        bool  — Allows SQL queries to the cluster databases from the management console.<br/>yandex-query   bool  — Allow access for YandexQuery.<br/>assign-public-ip     bool       — Determines whether the host should get a public IP address on creation.<br/><br/>After a host has been created, this setting cannot be changed.<br/><br/>To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed.<br/><br/>Possible values:<br/>* 'false' - do not assign a public IP to the master host.<br/>* 'true' - assign a public IP to the master host.<br/>backup-window-start  timeofday  — Time to start the daily backup, in the UTC timezone.<br/>subnet-id            string     — ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to.<br/>The ID of the network is set in the field [Cluster.network_id].<br/>zone-id              string     — ID of the availability zone where the host resides.<br/><br/>To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.<br/>|
|`--deletion-protection`|Determines whether the cluster is protected from being deleted.|
|`--description`|<b>`string`</b><br/>Description of the Greenplum® cluster.|
|`--environment`|<b>`enum`</b><br/>Deployment environment of the Greenplum® cluster. Possible Values: 'production', 'prestable'|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the Greenplum® cluster in.|
|`--host-group-ids`|<b>`strings`</b><br/>Host groups to place VMs of cluster on.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the Greenplum® cluster as 'key:value' pairs.<br/>For example, "project":"mvp" or "source":"dictionary".|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>A Greenplum® cluster maintenance window. Should be defined by either one of the two options.<br/><br/>Example:<br/>--maintenance-window policy={anytime={}}<br/><br/>Shorthand Syntax:<br/>{policy={anytime={} \| weekly-maintenance-window={day=MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN, hour=int}}}<br/>Fields:<br/>policy  oneof<anytime\|weekly-maintenance-window>  — Oneof policy field<br/>anytime                    struct  — An any-time maintenance window.<br/>weekly-maintenance-window  struct  — A weekly maintenance window.<br/>day   enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>  — Day of the week.<br/>hour  int                                — Hour of the day in the UTC timezone.<br/>|
|`--master-host-group-ids`|<b>`strings`</b><br/>Host groups hosting VMs of the master subcluster.|
|`--master-resources`|<b>`shorthand/json`</b><br/>Resources of the Greenplum® master subcluster.<br/><br/>Example:|
|`--master-resources`|<b>`disk-size=1,`</b><br/>disk-type-id=value, resource-preset-id=value<br/><br/>Shorthand Syntax:<br/>{disk-size=int, disk-type-id=str, resource-preset-id=str}<br/>Fields:<br/>disk-size           int     — Volume of the storage used by the host, in bytes.<br/>disk-type-id        string  — Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.<br/>resource-preset-id  string  — ID of the preset for computational resources allocated to a host.<br/><br/>Available presets are listed in the [documentation](https://yandex.cloud/ru/docs/managed-greenplum/concepts/instance-types).<br/>|
|`--name`|<b>`string`</b><br/>Name of the Greenplum® cluster. The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the network to create the cluster in.|
|`--placement-group-id`|<b>`string`</b><br/>ID of the placement group.|
|`--restore-only`|<b>`strings`</b><br/>List of databases and tables to restore|
|`--security-group-ids`|<b>`strings`</b><br/>User security groups.|
|`--segment-host-count`|<b>`int`</b><br/>Number of segment hosts|
|`--segment-host-group-ids`|<b>`strings`</b><br/>Host groups hosting VMs of the segment subcluster.|
|`--segment-in-host`|<b>`int`</b><br/>Number of segments on each host|
|`--segment-resources`|<b>`shorthand/json`</b><br/>Resources of the Greenplum® segment subcluster.<br/><br/>Example:|
|`--segment-resources`|<b>`disk-size=1,`</b><br/>disk-type-id=value, resource-preset-id=value<br/><br/>Shorthand Syntax:<br/>{disk-size=int, disk-type-id=str, resource-preset-id=str}<br/>Fields:<br/>disk-size           int     — Volume of the storage used by the host, in bytes.<br/>disk-type-id        string  — Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.<br/>resource-preset-id  string  — ID of the preset for computational resources allocated to a host.<br/><br/>Available presets are listed in the [documentation](https://yandex.cloud/ru/docs/managed-greenplum/concepts/instance-types).<br/>|
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
