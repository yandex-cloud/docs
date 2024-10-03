---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/iot/registry/yds-export/add.md
---

# yc iot registry yds-export add

Add new data stream export to specified registry

#### Command Usage

Syntax: 

`yc iot registry yds-export add [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--registry-id`|<b>`string`</b><br/>Registry id.|
|`--registry-name`|<b>`string`</b><br/>Registry name.|
|`--name`|<b>`string`</b><br/>Name of data stream export.|
|`--database`|<b>`string`</b><br/>Data stream database.|
|`--stream`|<b>`string`</b><br/>Data stream name.|
|`--mqtt-topic-filter`|<b>`string`</b><br/>MQTT topic filter.|
|`--stream-service-account-id`|<b>`string`</b><br/>Service account to be used to write to data stream.|
|`--stream-service-account-name`|<b>`string`</b><br/>Service account to be used to write to data stream.|
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
