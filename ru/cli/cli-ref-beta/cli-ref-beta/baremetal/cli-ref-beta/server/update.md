---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/server/update.md
---

# yc beta baremetal server update

Updates the specified server.

#### Command Usage

Syntax: 

`yc beta baremetal server update <SERVER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the server.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the server.<br/>The name must be unique within the folder.|
|`--network-interfaces`|<b>`shorthand/json`</b><br/>Network configuration for the server. Specifies how the network interface is configured<br/>to interact with other servers on the internal network and on the internet.<br/>Currently up to 2 network interfaces are supported: required private network interface and<br/>optional public network interface.<br/><br/>Example:|
|`--network-interfaces`|<b>`[{id=value,`</b><br/>subnet={private-subnet={private-subnet-id=value}}}]<br/><br/>Shorthand Syntax:<br/>[{id=str, subnet={private-subnet={private-subnet-id=str} \| public-subnet={public-subnet-id=str}}},...]<br/>Fields:<br/>id      string                               — ID of the network interface. Should not be specified when creating a server.<br/>subnet  oneof<private-subnet\|public-subnet>  — Oneof subnet field<br/>private-subnet  struct  — Private subnet.<br/>private-subnet-id  string  — ID of the private subnet.<br/>public-subnet   struct  — Public subnet.<br/>public-subnet-id  string  — ID of the public subnet.<br/><br/>A new ephemeral public subnet will be created if not specified.<br/>|
|`--server-id`|<b>`string`</b><br/>ID of the server to update.<br/><br/>To get the server ID, use a [ServerService.List] request.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
