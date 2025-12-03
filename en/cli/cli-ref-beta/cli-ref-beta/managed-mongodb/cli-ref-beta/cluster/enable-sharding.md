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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the MongoDB cluster to enable sharding for.|
|`--host-specs`|<b>`shorthand/json`</b><br/>Configurations for mongos and mongocfg hosts.<br/><br/>Example:|
|`--host-specs`|<b>`[{assign-public-ip=true,`</b><br/>hidden=true, priority=0.01, secondary-delay-secs=42, shard-name=value, subnet-id=value, tags={key=value}, type=MONGOD, zone-id=value}]<br/><br/>Shorthand Syntax:<br/>[{assign-public-ip=bool, hidden=bool, priority=double, secondary-delay-secs=int, shard-name=str, subnet-id=str, tags={key=str, key=...}, type=MONGOD\|MONGOS\|MONGOCFG\|MONGOINFRA, zone-id=str},...]<br/>Fields:<br/>assign-public-ip      bool                                     — Whether the host should get a public IP address on creation.<br/><br/>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign<br/>a public IP to a host without one, recreate the host with [assign_public_ip] set as needed.<br/><br/>Possible values:<br/>* false - don't assign a public IP to the host.<br/>* true - the host should have a public IP address.<br/>hidden                bool                                     — Is host hidden in replSet<br/>priority              double                                   — Priority of host for the election in replSet<br/>secondary-delay-secs  int                                      — The number of seconds "behind" the primary that this replica set member should "lag"<br/>shard-name            string                                   — Name of the shard that the host belongs to.<br/>subnet-id             string                                   — ID of the subnet that the host should belong to. This subnet should be a part<br/>of the network that the cluster belongs to.<br/>The network ID is set in the [Cluster.network_id] field.<br/>tags                  map[string,string]                       — Host tags<br/>type                  enum<MONGOCFG\|MONGOD\|MONGOINFRA\|MONGOS>  — Type of the host to be deployed.<br/>zone-id               string                                   — ID of the availability zone where the host resides.<br/>To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.<br/>|
|`--mongocfg`|<b>`shorthand/json`</b><br/>mongocfg specification for sharding.<br/><br/>Example:|
|`--mongocfg`|<b>`resources={disk-size=1,`</b><br/>disk-type-id=value, resource-preset-id=value}<br/><br/>Shorthand Syntax:<br/>{resources={disk-size=int, disk-type-id=str, resource-preset-id=str}}<br/>Fields:<br/>resources  struct  required  — Resources for mongocfg hosts.<br/>disk-size           int     — Volume of the storage available to a host, in bytes.<br/>disk-type-id        string  — Type of the storage environment for the host.<br/>Possible values:<br/>* network-hdd - network HDD drive,<br/>* network-ssd - network SSD drive,<br/>* local-ssd - local SSD storage.<br/>resource-preset-id  string  — ID of the preset for computational resources available to a host (CPU, memory etc.).<br/>All available presets are listed in the [documentation](https://yandex.cloud/ru/docs/managed-mongodb/concepts/instance-types).<br/>|
|`--mongoinfra`|<b>`shorthand/json`</b><br/>mongos specification for sharding.<br/><br/>Example:|
|`--mongoinfra`|<b>`resources={disk-size=1,`</b><br/>disk-type-id=value, resource-preset-id=value}<br/><br/>Shorthand Syntax:<br/>{resources={disk-size=int, disk-type-id=str, resource-preset-id=str}}<br/>Fields:<br/>resources  struct  required  — Resources for mongoinfra (mongos+mongocfg) hosts.<br/>disk-size           int     — Volume of the storage available to a host, in bytes.<br/>disk-type-id        string  — Type of the storage environment for the host.<br/>Possible values:<br/>* network-hdd - network HDD drive,<br/>* network-ssd - network SSD drive,<br/>* local-ssd - local SSD storage.<br/>resource-preset-id  string  — ID of the preset for computational resources available to a host (CPU, memory etc.).<br/>All available presets are listed in the [documentation](https://yandex.cloud/ru/docs/managed-mongodb/concepts/instance-types).<br/>|
|`--mongos`|<b>`shorthand/json`</b><br/>mongos specification for sharding.<br/><br/>Example:|
|`--mongos`|<b>`resources={disk-size=1,`</b><br/>disk-type-id=value, resource-preset-id=value}<br/><br/>Shorthand Syntax:<br/>{resources={disk-size=int, disk-type-id=str, resource-preset-id=str}}<br/>Fields:<br/>resources  struct  required  — Resources for mongos hosts.<br/>disk-size           int     — Volume of the storage available to a host, in bytes.<br/>disk-type-id        string  — Type of the storage environment for the host.<br/>Possible values:<br/>* network-hdd - network HDD drive,<br/>* network-ssd - network SSD drive,<br/>* local-ssd - local SSD storage.<br/>resource-preset-id  string  — ID of the preset for computational resources available to a host (CPU, memory etc.).<br/>All available presets are listed in the [documentation](https://yandex.cloud/ru/docs/managed-mongodb/concepts/instance-types).<br/>|
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
