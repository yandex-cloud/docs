---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/datatransfer/endpoint/update/yds-source.md
---

# yc datatransfer endpoint update yds-source

Update YDS source

#### Command Usage

Syntax: 

`yc datatransfer endpoint update yds-source [<ENDPOINT-ID>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--file`|<b>`string`</b><br/>Path to a file with grpc request, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/datatransfer/v1|
|`--name`|<b>`string`</b><br/>Endpoint name|
|`--description`|<b>`string`</b><br/>Endpoint description|
|`--endpoint`|<b>`string`</b><br/>YDS endpoint|
|`--database`|<b>`string`</b><br/>YDS database|
|`--stream`|<b>`string`</b><br/>Stream|
|`--consumer`|<b>`string`</b><br/>Consumer|
|`--service-account-id`|<b>`string`</b><br/>Service account ID for interaction with database.|
|`--allow-ttl-rewind`|Should continue working, if consumer read lag exceed TTL of topic.|
|`--subnet-id`|<b>`string`</b><br/>Yandex Virtual Private Cloud subnet ID to access the YDS through|
|`--security-group`|<b>`value[,value]`</b><br/>Yandex Virtual Private Cloud security group ID to associate with the endpoint|

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
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
