---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/audit-trails/trail/create.md
---

# yc audit-trails trail create

Create the specified trail

#### Command Usage

Syntax: 

`yc audit-trails trail create <TRAIL-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--file`|<b>`string`</b><br/>Path to a file with a gRPC request to be executed, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/audittrails/v1/trail_service.proto|
|`--name`|<b>`string`</b><br/>A name of the trail.|
|`--description`|<b>`string`</b><br/>Specifies the textual description of the trail.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>Specifies the list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--service-account-id`|<b>`string`</b><br/>Specifies the trail service account ID.|
|`--destination-bucket`|<b>`string`</b><br/>Specifies the name of the destination bucket.|
|`--destination-bucket-object-prefix`|<b>`string`</b><br/>Specifies the prefix for uploaded results of the trail. Requires specifying 'destination-bucket'.|
|`--destination-log-group-id`|<b>`string`</b><br/>Specifies the ID of the destination log group.|
|`--destination-yds-database-id`|<b>`string`</b><br/>Specifies the ID of the YDB hosting a destination YDS stream. Requires specifying 'destination-yds-stream'.|
|`--destination-yds-stream`|<b>`string`</b><br/>Specifies the name of the destination YDS stream. Requires specifying 'destination-yds-database-id'.|
|`--filter-all-folder-id`|<b>`string`</b><br/>Specifies the ID of the folder from which all default events will be collected.|
|`--filter-all-cloud-id`|<b>`string`</b><br/>Specifies the ID of the cloud from which all default events will be collected.|
|`--filter-all-organisation-id`|<b>`string`</b><br/>Specifies the ID of the organisation from which all default events will be collected.|
|`--filter-from-cloud-id`|<b>`string`</b><br/>Specifies the ID of the cloud which contain all folders specified at 'filter-some-folder-ids'.|
|`--filter-some-folder-ids`|<b>`value[,value]`</b><br/>Specifies the list of folder IDs from which all default events will be collected. Requires specifying 'filter-from-cloud-id'|
|`--filter-from-organisation-id`|<b>`string`</b><br/>Specifies the ID of the organisation which contain all clouds specified at 'filter-some-cloud-ids'.|
|`--filter-some-cloud-ids`|<b>`value[,value]`</b><br/>Specifies a list of cloud IDs from which all default events will be collected. Requires specifying 'filter-from-organisation-id'|
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
|`-h`,`--help`|Display help for the command.|
