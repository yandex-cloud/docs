---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/iot/broker/create.md
---

# yc iot broker create

Create new broker

#### Command Usage

Syntax: 

`yc iot broker create <BROKER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of broker.|
|`--description`|<b>`string`</b><br/>Description of broker/|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>List of KEY=VALUES pairs to add.|
|`--certificate-file`|<b>`string`</b><br/>Path to X.509 certificate file to associate with selected broker.|
|`--password`|<b>`string`</b><br/>Password for entity. Usage of --read-password is more secure|
|`--read-password`|Read password for entity from input|
|`--generate-password`|Generate random password|
|`--no-logging`|Disable logging for broker.|
|`--log-group-id`|<b>`string`</b><br/>Send logs to custom log group by id.|
|`--log-group-name`|<b>`string`</b><br/>Send logs to custom log group by name.|
|`--log-folder-id`|<b>`string`</b><br/>Send logs to default log group of custom folder by id.|
|`--log-folder-name`|<b>`string`</b><br/>Send logs to default log group of custom folder by name.|
|`--min-log-level`|<b>`string`</b><br/>Min log level. Values: 'trace', 'debug', 'info', 'warn', 'error', 'fatal'|
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
