---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-redis/cli-ref-beta/cluster/add-shard.md
---

# yc beta managed-redis cluster add-shard

Creates a new shard.

#### Command Usage

Syntax: 

`yc beta managed-redis cluster add-shard <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the Redis cluster to create a shard in. To get the cluster ID use a [ClusterService.List] request.|
|`--host-specs`|<b>`shorthand/json`</b><br/>Configurations for Redis hosts that should be created with the shard. Must contain at least one element.<br/>Shorthand Syntax:<br/>[<br/>{<br/>assign-public-ip = bool,<br/>replica-priority = int,<br/>shard-name = str,<br/>subnet-id = str,<br/>zone-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"assign-public-ip": "bool",<br/>"replica-priority": "int",<br/>"shard-name": "str",<br/>"subnet-id": "str",<br/>"zone-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>assign-public-ip -> (bool)<br/>Whether the host should get a public IP address on creation. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.<br/>replica-priority -> (int)<br/>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100.<br/>shard-name -> (string)<br/>ID of the Redis shard the host belongs to. To get the shard ID use a [ClusterService.ListShards] request.<br/>subnet-id -> (string)<br/>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].<br/>zone-id -> (string)<br/>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.|
|`--shard-name`|<b>`string`</b><br/>Name of the shard. The name must be unique within the cluster.|
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
