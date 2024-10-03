---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-clickhouse/shards/add.md
---

# yc managed-clickhouse shards add

Create new shard for the cluster in the specified availability zones.

#### Command Usage

Syntax: 

`yc managed-clickhouse shards add <SHARD-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the ClickHouse cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the ClickHouse cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--name`|<b>`string`</b><br/>Shard name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Configurations for ClickHouse hosts that should be added to the shard.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the new host should reside.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Assign a public IP address to the host being added.</li> </ul>|
|`--clickhouse-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.).|
|`--clickhouse-disk-size`|<b>`byteSize`</b><br/>Storage volume available to a ClickHouse host|
|`--clickhouse-disk-type`|<b>`string`</b><br/>Storage type for a ClickHouse host.|
|`--weight`|<b>`int`</b><br/>Weight of the host in the shard.|
|`--copy-schema`|Copy schema from another shard|

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
