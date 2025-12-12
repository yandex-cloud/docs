---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/subnet/create.md
---

# yc beta vpc subnet create

Creates a subnet in the specified folder and network.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta vpc subnet create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the subnet.|
|`--dhcp-options`|<b>`shorthand/json`</b><br/>Shorthand Syntax:<br/>{<br/>domain-name = str,<br/>domain-name-servers = str,...,<br/>ntp-servers = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"domain-name": "str",<br/>"domain-name-servers": [<br/>"str", ...<br/>],<br/>"ntp-servers": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>domain-name -> (string)<br/>A domain name to us as a suffix when resolving host names in this subnet.<br/>domain-name-servers -> ([]string)<br/>A list of DHCP servers for this subnet.<br/>ntp-servers -> ([]string)<br/>List of NTP servers for this subnet.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a subnet in. To get folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels, '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>Name of the subnet. The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the network to create subnet in.|
|`--route-table-id`|<b>`string`</b><br/>ID of route table the subnet is linked to.|
|`--v4-cidr-blocks`|<b>`strings`</b><br/>CIDR block. The range of internal addresses that are defined for this subnet. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16.|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the subnet resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.|
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
