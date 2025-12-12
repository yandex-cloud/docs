---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/private-subnet/update.md
---

# yc beta baremetal private-subnet update

Updates the specified private subnet.

#### Command Usage

Syntax: 

`yc beta baremetal private-subnet update <PRIVATE-SUBNET-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the private subnet.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set.|
|`--name`|<b>`string`</b><br/>Name of the private subnet. The name must be unique within the folder.|
|`--private-subnet-id`|<b>`string`</b><br/>ID of the PrivateSubnet resource to update. To get the private subnet ID, use a [PrivateSubnetService.List] request.|
|`--vrf-options-spec`|<b>`shorthand/json`</b><br/>VRF options. Optional.<br/>Shorthand Syntax:<br/>{<br/>cidr = str,<br/>dhcp-options = {<br/>end-ip = str,<br/>start-ip = str<br/>},<br/>gateway-ip = str,<br/>vrf-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"cidr": "str",<br/>"dhcp-options": {<br/>"end-ip": "str",<br/>"start-ip": "str"<br/>},<br/>"gateway-ip": "str",<br/>"vrf-id": "str"<br/>}"<br/>Fields:<br/>cidr -> (string)<br/>CIDR block. The range of internal addresses that are defined for this private subnet, as specified in RFC1918. For example, 10.0.0.0/22 or 192.168.0.0/24.<br/>dhcp-options -> (struct)<br/>DHCP options for the subnet. The absence or null value indicates that DHCP is disabled.<br/>end-ip -> (string)<br/>End IP address of the DHCP range (inclusive). The absence or null value indicates that calculation will be performed based on CIDR.<br/>start-ip -> (string)<br/>Start IP address of the DHCP range (inclusive). The absence or null value indicates that calculation will be performed based on CIDR.<br/>gateway-ip -> (string)<br/>Gateway IP address for the subnet.<br/>vrf-id -> (string)<br/>ID of the VRF to create private subnet in. To get the VRF ID, use a [VrfService.List] request.|
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
