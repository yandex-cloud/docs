---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mongodb/cli-ref-beta/cluster/enable-sharding.md
---

# yc beta managed-mongodb cluster enable-sharding

Enables sharding for the cluster:  creates 3 mongoinfra (or 3 mongocfg and 2 mongos) hosts  that would support adding and using shards in the cluster.

#### Command Usage

Syntax: 

`yc beta managed-mongodb cluster enable-sharding <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the MongoDB cluster to enable sharding for.|
|`--host-specs`|<b>`shorthand/json`</b><br/>Configurations for mongos and mongocfg hosts.<br/>Shorthand Syntax:<br/>[<br/>{<br/>assign-public-ip = bool,<br/>hidden = bool,<br/>priority = double,<br/>secondary-delay-secs = int,<br/>shard-name = str,<br/>subnet-id = str,<br/>tags = {key=str, key=...},<br/>type = MONGOD\|MONGOS\|MONGOCFG\|MONGOINFRA,<br/>zone-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"assign-public-ip": "bool",<br/>"hidden": "bool",<br/>"priority": "double",<br/>"secondary-delay-secs": "int",<br/>"shard-name": "str",<br/>"subnet-id": "str",<br/>"tags": {<br/>"\<key\>": "str", ...<br/>},<br/>"type": "MONGOD\|MONGOS\|MONGOCFG\|MONGOINFRA",<br/>"zone-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>assign-public-ip -> (bool)<br/>Whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.<br/>hidden -> (bool)<br/>Is host hidden in replSet<br/>priority -> (double)<br/>Priority of host for the election in replSet<br/>secondary-delay-secs -> (int)<br/>The number of seconds "behind" the primary that this replica set member should "lag"<br/>shard-name -> (string)<br/>Name of the shard that the host belongs to.<br/>subnet-id -> (string)<br/>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id] field.<br/>tags -> (map[string,string])<br/>Host tags<br/>type -> (enum<MONGOCFG\|MONGOD\|MONGOINFRA\|MONGOS>)<br/>Type of the host to be deployed.<br/>zone-id -> (string)<br/>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.|
|`--mongocfg`|<b>`shorthand/json`</b><br/>mongocfg specification for sharding.<br/>Shorthand Syntax:<br/>{<br/>resources = {<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"resources": {<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}<br/>}"<br/>Fields:<br/>resources -> (struct)<br/>Resources for mongocfg hosts.<br/>disk-size -> (int)<br/>Volume of the storage available to a host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.|
|`--mongoinfra`|<b>`shorthand/json`</b><br/>mongos specification for sharding.<br/>Shorthand Syntax:<br/>{<br/>resources = {<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"resources": {<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}<br/>}"<br/>Fields:<br/>resources -> (struct)<br/>Resources for mongoinfra (mongos+mongocfg) hosts.<br/>disk-size -> (int)<br/>Volume of the storage available to a host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.|
|`--mongos`|<b>`shorthand/json`</b><br/>mongos specification for sharding.<br/>Shorthand Syntax:<br/>{<br/>resources = {<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"resources": {<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}<br/>}"<br/>Fields:<br/>resources -> (struct)<br/>Resources for mongos hosts.<br/>disk-size -> (int)<br/>Volume of the storage available to a host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.|
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
