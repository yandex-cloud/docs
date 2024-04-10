---
editable: false
---

# yc vpc address create

Create an address.

#### Command Usage

Syntax: 

`yc vpc address create <ADDRESS-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the address.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--description`|<b>`string`</b><br/>Description of the address.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of address labels as key-value pairs.|
|`--external-ipv4`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>External ipv4 address specification.<br/><br/>Possible property names:<br/><ul> <li><code>zone</code>:     Specifies the zone.</li> </ul>|
|`--deletion-protection`|Specifies if address protected from deletion.|
|`--dns-record`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>DNS record specifications<br/><br/>Possible property names:<br/><ul> <li><code>dns-zone</code>:     Specifies id of DNS zone.</li> <li><code>fqdn</code>:     Specifies fqdn for DNS record.</li> <li><code>ptr</code>:     Set if PTR record is required</li> <li><code>ttl</code>:     DNS record TTL in seconds</li> </ul>|

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
