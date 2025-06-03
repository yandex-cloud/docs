---
editable: false
---

# yc baremetal server update

Update the specified server

#### Command Usage

Syntax: 

`yc baremetal server update <SERVER-NAME>|<SERVER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Server id.|
|`--name`|<b>`string`</b><br/>Server name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>A new name of the server.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the server.|
|`--network-interfaces`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Adds a network interface spec to the server.<br/><br/>Possible property names:<br/><ul> <li><code>private-subnet-id</code>:     Specifies the ID of the private subnet that the interface will be part of.</li> <li><code>public-subnet-id</code>:     Specifies the ID of the public subnet that the interface will be part of.</li> <li><code>private-subnet-name</code>:     Specifies the name of the  private subnet that the interface will be part of.</li> <li><code>public-subnet-name</code>:     Specifies the name of the  public subnet that the interface will be part of.</li> </ul>|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|

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
