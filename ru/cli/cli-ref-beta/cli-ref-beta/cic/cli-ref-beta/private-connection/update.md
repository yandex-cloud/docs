---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/private-connection/update.md
---

# yc beta cic private-connection update

Updates a PrivateConnection resource using the data specified in the request.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cic private-connection update <PRIVATE-CONNECTION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Optional description of the privateConnection. 0-256 characters long.|
|`--ipv4-peering`|<b>`shorthand/json`</b><br/>IPv4 peering config of connection<br/><br/>Example:|
|`--ipv4-peering`|<b>`cloud-bgp-asn=1,`</b><br/>cloud-ip=value, peer-bgp-asn=1, peer-bgp-md5-key=value, peer-ip=value, peering-subnet=value<br/><br/>Shorthand Syntax:<br/>{cloud-bgp-asn=int, cloud-ip=str, peer-bgp-asn=int, peer-bgp-md5-key=str, peer-ip=str, peering-subnet=str}<br/>Fields:<br/>cloud-bgp-asn     int     — CloudBgpAsn.<br/>cloud-ip          string  — CloudIp.<br/>It's an ip with just an ipAddress format without mask.<br/>peer-bgp-asn      int     — PeerBgpAsn.<br/>PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).<br/>peer-bgp-md5-key  string  — PeerBgpMd5Key.<br/>Optional.<br/>peer-ip           string  — PeerIp.<br/>It's an ip with just an ipAddress format without mask.<br/>peering-subnet    string  — PeeringSubnet.<br/>It's an ip with format ipPrefix/length where address part of ipPrefix is 0.<br/>|
|`--ipv4-static-routes`|<b>`shorthand/json`</b><br/>IPv4 StaticRoute config of connection<br/><br/>Example:<br/>--ipv4-static-routes [{prefix=value}]<br/><br/>Shorthand Syntax:<br/>[{prefix=str},...]<br/>Fields:<br/>prefix  string  — Prefix.<br/>It's an ip with format ipPrefix/length where address part of ipPrefix is 0.<br/>|
|`--labels`|<b>`stringToString`</b><br/>Resource labels, 'key:value' pairs.<br/>No more than 64 per resource.<br/>The maximum string length in characters for each value is 63.<br/>Each value must match the regular expression '[-_0-9a-z]*'.<br/>The string length in characters for each key must be 1-63.<br/>Each key must match the regular expression '[a-z][-_0-9a-z]*'.|
|`--name`|<b>`string`</b><br/>Name of the privateConnection.<br/>The name must be unique within the folder.<br/>Value must match the regular expression ''\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?''.|
|`--private-connection-id`|<b>`string`</b><br/>ID of the PrivateConnection resource.|
|`--region-id`|<b>`string`</b><br/>ID of the region that the privateConnection belongs to.|
|`--trunk-connection-id`|<b>`string`</b><br/>ID of the trunk_connection that the privateConnection belongs to.|
|`--vlan-id`|<b>`int`</b><br/>VLAN_ID that the privateConnection uses in multiplexing.<br/>Not used in connections over partners-II<br/>Value range: [1, 4095]|
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
