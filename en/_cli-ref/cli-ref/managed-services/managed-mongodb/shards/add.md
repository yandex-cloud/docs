---
editable: false
---

# yc managed-mongodb shards add

Create new shard for the cluster in the specified availability zones.

#### Command Usage

Syntax: 

`yc managed-mongodb shards add <SHARD-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Shard name.|
|`--cluster-id`|<b>`string`</b><br/>ID of the MongoDB cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the MongoDB cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Configurations for MongoDB hosts that should be added to the shard.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the new host should reside.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Assign a public IP address to the host being added.</li> </ul>|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
