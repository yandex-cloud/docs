---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-opensearch/cli-ref-beta/cluster/update-open-search-node-group.md
---

# yc beta managed-opensearch cluster update-open-search-node-group

Updates an OpenSearch type host group.

#### Command Usage

Syntax: 

`yc beta managed-opensearch cluster update-open-search-node-group <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the OpenSearch cluster to update the OpenSearch type host group in.<br/><br/>To get the ID, use a [ClusterService.List] request.|
|`--name`|<b>`string`</b><br/>Name of the OpenSearch type host group to be updated.|
|`--node-group-spec`|<b>`shorthand/json`</b><br/>New configuration for the host group.<br/><br/>Example:|
|`--node-group-spec`|<b>`assign-public-ip=true,`</b><br/>disk-size-autoscaling={disk-size-limit=1, emergency-usage-threshold=1, planned-usage-threshold=1}, hosts-count=1, resources={disk-size=1, disk-type-id=value, resource-preset-id=value}, roles=DATA, subnet-ids=value, zone-ids=value<br/><br/>Shorthand Syntax:<br/>{assign-public-ip=bool, disk-size-autoscaling={disk-size-limit=int, emergency-usage-threshold=int, planned-usage-threshold=int}, hosts-count=int, resources={disk-size=int, disk-type-id=str, resource-preset-id=str}, roles=DATA\|MANAGER,..., subnet-ids=str,..., zone-ids=str,...}<br/>Fields:<br/>assign-public-ip       bool      — Whether the hosts should get a public IP address.<br/>disk-size-autoscaling  struct    — Disk size autoscaling settings<br/>disk-size-limit            int  — Limit on how large the storage for database instances can automatically grow, in bytes.<br/>emergency-usage-threshold  int  — Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.<br/>planned-usage-threshold    int  — Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.<br/>hosts-count            int       — Number of hosts in the group.<br/>resources              struct    — Resources allocated to the hosts.<br/>disk-size           int     — Volume of the storage used by the host, in bytes.<br/>disk-type-id        string  — Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.<br/>resource-preset-id  string  — ID of the preset for computational resources allocated to a host.<br/>roles                  []int     — Opensearch roles applicable to the node group.<br/>subnet-ids             []string  — IDs of the subnets for hosts<br/>zone-ids               []string  — IDs of the availability zones for hosts<br/>|
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
