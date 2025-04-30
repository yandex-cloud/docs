---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kafka/cli-ref/user/revoke-permission.md
---

# yc managed-kafka user revoke-permission

Revoke permission from the specified Kafka user.

#### Command Usage

Syntax: 

`yc managed-kafka user revoke-permission <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Kafka cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Kafka cluster name.|
|`--permission`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Permission to revoke from the user.<br/><br/>Possible property names:<br/><ul> <li><code>topic</code>:     Name of the topic that the permission grants access to. (required)</li> <li><code>role</code>:     Role in the topic. Possible values are: producer, consumer, admin, topic_admin. To grant multiple roles specify this property multiple times. (required)</li> <li><code>allow_host</code>:     Host allowed to access from. Only ip-addresses allowed as value of single host. To grant access for multiple hosts specify this property multiple times.</li> </ul>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
