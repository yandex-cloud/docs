---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/private-subnet/update.md
---

# yc baremetal private-subnet update

Update the specified private subnet

#### Command Usage

Syntax: 

`yc baremetal private-subnet update <PRIVATE-SUBNET-NAME>|<PRIVATE-SUBNET-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Private Subnet id.|
|`--name`|<b>`string`</b><br/>Private Subnet name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>A new name of the private subnet.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the private subnet.|
|`--vrf-options`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies a vrf options spec to the private subnet.<br/><br/>Possible property names:<br/><ul> <li><code>vrf-id</code>:     Specifies the vrf id of the vrf options spec.</li> <li><code>vrf-name</code>:     Specifies the vrf name of the vrf options spec.</li> <li><code>dhcp</code>:     Specifies the dhcp of the private-subnet. Default value is disabled.</li> <li><code>cidr</code>:     Specifies the cidr of the vrf options spec.</li> <li><code>gateway-ip</code>:     Specifies the gateway ip of the vrf options spec.</li> </ul>|
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
