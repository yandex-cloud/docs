---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/private-endpoint/create.md
---

# yc vpc private-endpoint create

Create a private endpoint.

#### Command Usage

Syntax: 

`yc vpc private-endpoint create <PRIVATE-ENDPOINT-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--name`|<b>`string`</b><br/>Name of the private endpoint.|
|`--network-id`|<b>`string`</b><br/>ID of the network to which the private endpoint belongs.|
|`--network-name`|<b>`string`</b><br/>Name of the network to which the private endpoint belongs.|
|`--object-storage`|Object storage|
|`--description`|<b>`string`</b><br/>Description of the private endpoint.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of private endpoint labels as key-value pairs.|
|`--address-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Internal ipv4 address specification.<br/><br/>Possible property names:<br/><ul> <li><code>address-id</code>:     Specifies address-id for private endpoint.</li> <li><code>address</code>:     Specifies address for private endpoint.</li> <li><code>subnet-id</code>:     Specifies subnet-id of address for private endpoint.</li> </ul>|
|`--private-dns-records-enabled`|Enable private dns records|

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
