---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/private-connection/create.md
---

# yc beta cic private-connection create

Creates a PrivateConnection resource in the specified folder using the data specified in the request.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cic private-connection create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Optional description of the privateConnection. 0-256 characters long.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder that the privateConnection belongs to.|
|`--ipv4-peering`|<b>`shorthand/json`</b><br/>IPv4 peering config of connection<br/>Shorthand Syntax:<br/>{<br/>cloud-bgp-asn = int,<br/>cloud-ip = str,<br/>peer-bgp-asn = int,<br/>peer-bgp-md5-key = str,<br/>peer-ip = str,<br/>peering-subnet = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"cloud-bgp-asn": "int",<br/>"cloud-ip": "str",<br/>"peer-bgp-asn": "int",<br/>"peer-bgp-md5-key": "str",<br/>"peer-ip": "str",<br/>"peering-subnet": "str"<br/>}"<br/>Fields:<br/>cloud-bgp-asn -> (int)<br/>CloudBgpAsn.<br/>cloud-ip -> (string)<br/>CloudIp. It's an ip with just an ipAddress format without mask.<br/>peer-bgp-asn -> (int)<br/>PeerBgpAsn. PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).<br/>peer-bgp-md5-key -> (string)<br/>PeerBgpMd5Key. Optional.<br/>peer-ip -> (string)<br/>PeerIp. It's an ip with just an ipAddress format without mask.<br/>peering-subnet -> (string)<br/>PeeringSubnet. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.|
|`--ipv4-static-routes`|<b>`shorthand/json`</b><br/>IPv4 StaticRoute config of connection<br/>Shorthand Syntax:<br/>[<br/>{<br/>prefix = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"prefix": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>prefix -> (string)<br/>Prefix. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'.|
|`--name`|<b>`string`</b><br/>Name of the privateConnection. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''.|
|`--region-id`|<b>`string`</b><br/>ID of the region that the privateConnection belongs to.|
|`--trunk-connection-id`|<b>`string`</b><br/>ID of the trunk_connection that the privateConnection belongs to.|
|`--vlan-id`|<b>`int`</b><br/>VLAN_ID that the privateConnection uses in multiplexing. Not used in connections over partners-II Value range: [1, 4095]|
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
