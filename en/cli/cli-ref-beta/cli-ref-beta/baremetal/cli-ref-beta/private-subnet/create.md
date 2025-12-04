---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/private-subnet/create.md
---

# yc beta baremetal private-subnet create

Creates a private subnet in the specified folder.

#### Command Usage

Syntax: 

`yc beta baremetal private-subnet create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the private subnet.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a private subnet in.<br/><br/>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--hardware-pool-id`|<b>`string`</b><br/>ID of the hardware pool where the private subnet resides.<br/><br/>To get a list of available hardware pools, use the [HardwarePoolService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the private subnet.<br/>The name must be unique within the folder.|
|`--vrf-options-spec`|<b>`shorthand/json`</b><br/>VRF options. Optional.<br/><br/>Example:|
|`--vrf-options-spec`|<b>`cidr=value,`</b><br/>dhcp-options={end-ip=value, start-ip=value}, gateway-ip=value, vrf-id=value<br/><br/>Shorthand Syntax:<br/>{cidr=str, dhcp-options={end-ip=str, start-ip=str}, gateway-ip=str, vrf-id=str}<br/>Fields:<br/>cidr          string  — CIDR block.<br/>The range of internal addresses that are defined for this private subnet, as<br/>specified in [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3).<br/>For example, 10.0.0.0/22 or 192.168.0.0/24.<br/>dhcp-options  struct  — DHCP options for the subnet.<br/>The absence or null value indicates that DHCP is disabled.<br/>end-ip    string  — End IP address of the DHCP range (inclusive).<br/>The absence or null value indicates that calculation will be performed based on CIDR.<br/>start-ip  string  — Start IP address of the DHCP range (inclusive).<br/>The absence or null value indicates that calculation will be performed based on CIDR.<br/>gateway-ip    string  — Gateway IP address for the subnet.<br/>vrf-id        string  — ID of the VRF to create private subnet in.<br/><br/>To get the VRF ID, use a [VrfService.List] request.<br/>|
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
