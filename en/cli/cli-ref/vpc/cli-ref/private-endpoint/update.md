---
editable: false
sourcePath: en/_cli-ref/cli-ref/vpc/cli-ref/private-endpoint/update.md
---

# yc vpc private-endpoint update

Modify configuration or attributes of a private endpoint.

#### Command Usage

Syntax: 

`yc vpc private-endpoint update <PRIVATE-ENDPOINT-NAME>|<PRIVATE-ENDPOINT-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Private endpoint id.|
|`--name`|<b>`string`</b><br/>Private endpoint name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the private endpoint.|
|`--description`|<b>`string`</b><br/>New description for the private endpoint.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the private endpoint as key-value pairs. Existing set of labels will be completely overwritten.|
|`--address-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Internal ipv4 address specification.<br/><br/>Possible property names:<br/><ul> <li><code>address-id</code>:     Specifies address-id for private endpoint.</li> <li><code>address</code>:     Specifies address for private endpoint.</li> <li><code>subnet-id</code>:     Specifies subnet-id of address for private endpoint.</li> </ul>|
|`--private-dns-records-enabled`|Enable private dns records.|

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
