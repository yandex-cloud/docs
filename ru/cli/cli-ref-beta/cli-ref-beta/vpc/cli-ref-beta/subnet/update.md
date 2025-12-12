---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/subnet/update.md
---

# yc beta vpc subnet update

Updates the specified subnet.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta vpc subnet update <SUBNET-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the subnet.|
|`--dhcp-options`|<b>`shorthand/json`</b><br/>Shorthand Syntax:<br/>{<br/>domain-name = str,<br/>domain-name-servers = str,...,<br/>ntp-servers = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"domain-name": "str",<br/>"domain-name-servers": [<br/>"str", ...<br/>],<br/>"ntp-servers": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>domain-name -> (string)<br/>A domain name to us as a suffix when resolving host names in this subnet.<br/>domain-name-servers -> ([]string)<br/>A list of DHCP servers for this subnet.<br/>ntp-servers -> ([]string)<br/>List of NTP servers for this subnet.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>Name of the subnet. The name must be unique within the folder.|
|`--route-table-id`|<b>`string`</b><br/>ID of route table the subnet is linked to.|
|`--subnet-id`|<b>`string`</b><br/>ID of the Subnet resource to update.|
|`--v4-cidr-blocks`|<b>`strings`</b><br/>New CIDR blocks which will overwrite the existing ones.|
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
