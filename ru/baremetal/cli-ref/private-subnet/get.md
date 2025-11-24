---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/private-subnet/get.md
---

# yc baremetal private-subnet get

Show information about the specified private subnet

#### Command Usage

Syntax: 

`yc baremetal private-subnet get <PRIVATE-SUBNET-NAME>|<PRIVATE-SUBNET-ID> [<PRIVATE-SUBNET-NAME>|<PRIVATE-SUBNET-ID>...] [Global Flags...]`

Aliases: 

- `describe`
- `show`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Private Subnet id.|
|`--name`|<b>`string`</b><br/>Private Subnet name.|

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
