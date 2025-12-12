---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/update-network-interface.md
---

# yc beta compute instance update-network-interface

Updates the specified instance network interface.

#### Command Usage

Syntax: 

`yc beta compute instance update-network-interface <INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--instance-id`|<b>`string`</b><br/>ID of the instance that is being updated.|
|`--network-interface-index`|<b>`string`</b><br/>The index of the network interface to be updated.|
|`--primary-v4-address-spec`|<b>`shorthand/json`</b><br/>Primary IPv4 address that will be assigned to the instance for this network interface.<br/>Shorthand Syntax:<br/>{<br/>address = str,<br/>dns-record-specs = [<br/>{<br/>dns-zone-id = str,<br/>fqdn = str,<br/>ptr = bool,<br/>ttl = int<br/>}, ...<br/>],<br/>one-to-one-nat-spec = {<br/>address = str,<br/>dns-record-specs = [<br/>{<br/>dns-zone-id = str,<br/>fqdn = str,<br/>ptr = bool,<br/>ttl = int<br/>}, ...<br/>],<br/>ip-version = IPV4\|IPV6<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"address": "str",<br/>"dns-record-specs": [<br/>{<br/>"dns-zone-id": "str",<br/>"fqdn": "str",<br/>"ptr": "bool",<br/>"ttl": "int"<br/>}, ...<br/>],<br/>"one-to-one-nat-spec": {<br/>"address": "str",<br/>"dns-record-specs": [<br/>{<br/>"dns-zone-id": "str",<br/>"fqdn": "str",<br/>"ptr": "bool",<br/>"ttl": "int"<br/>}, ...<br/>],<br/>"ip-version": "IPV4\|IPV6"<br/>}<br/>}"<br/>Fields:<br/>address -> (string)<br/>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.<br/>dns-record-specs -> ([]struct)<br/>Internal DNS configuration<br/>dns-zone-id -> (string)<br/>DNS zone id (optional, if not set, private zone used)<br/>fqdn -> (string)<br/>FQDN (required)<br/>ptr -> (bool)<br/>When set to true, also create PTR DNS record (optional)<br/>ttl -> (int)<br/>DNS record ttl, values in 0-86400 (optional)<br/>one-to-one-nat-spec -> (struct)<br/>An external IP address configuration. If not specified, then this instance will have no external internet access.<br/>address -> (string)<br/>dns-record-specs -> ([]struct)<br/>External DNS configuration<br/>dns-zone-id -> (string)<br/>DNS zone id (optional, if not set, private zone used)<br/>fqdn -> (string)<br/>FQDN (required)<br/>ptr -> (bool)<br/>When set to true, also create PTR DNS record (optional)<br/>ttl -> (int)<br/>DNS record ttl, values in 0-86400 (optional)<br/>ip-version -> (enum<IPV4\|IPV6>)<br/>External IP address version.|
|`--primary-v6-address-spec`|<b>`shorthand/json`</b><br/>Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.<br/>Shorthand Syntax:<br/>{<br/>address = str,<br/>dns-record-specs = [<br/>{<br/>dns-zone-id = str,<br/>fqdn = str,<br/>ptr = bool,<br/>ttl = int<br/>}, ...<br/>],<br/>one-to-one-nat-spec = {<br/>address = str,<br/>dns-record-specs = [<br/>{<br/>dns-zone-id = str,<br/>fqdn = str,<br/>ptr = bool,<br/>ttl = int<br/>}, ...<br/>],<br/>ip-version = IPV4\|IPV6<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"address": "str",<br/>"dns-record-specs": [<br/>{<br/>"dns-zone-id": "str",<br/>"fqdn": "str",<br/>"ptr": "bool",<br/>"ttl": "int"<br/>}, ...<br/>],<br/>"one-to-one-nat-spec": {<br/>"address": "str",<br/>"dns-record-specs": [<br/>{<br/>"dns-zone-id": "str",<br/>"fqdn": "str",<br/>"ptr": "bool",<br/>"ttl": "int"<br/>}, ...<br/>],<br/>"ip-version": "IPV4\|IPV6"<br/>}<br/>}"<br/>Fields:<br/>address -> (string)<br/>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.<br/>dns-record-specs -> ([]struct)<br/>Internal DNS configuration<br/>dns-zone-id -> (string)<br/>DNS zone id (optional, if not set, private zone used)<br/>fqdn -> (string)<br/>FQDN (required)<br/>ptr -> (bool)<br/>When set to true, also create PTR DNS record (optional)<br/>ttl -> (int)<br/>DNS record ttl, values in 0-86400 (optional)<br/>one-to-one-nat-spec -> (struct)<br/>An external IP address configuration. If not specified, then this instance will have no external internet access.<br/>address -> (string)<br/>dns-record-specs -> ([]struct)<br/>External DNS configuration<br/>dns-zone-id -> (string)<br/>DNS zone id (optional, if not set, private zone used)<br/>fqdn -> (string)<br/>FQDN (required)<br/>ptr -> (bool)<br/>When set to true, also create PTR DNS record (optional)<br/>ttl -> (int)<br/>DNS record ttl, values in 0-86400 (optional)<br/>ip-version -> (enum<IPV4\|IPV6>)<br/>External IP address version.|
|`--security-group-ids`|<b>`strings`</b><br/>ID's of security groups attached to the interface.|
|`--subnet-id`|<b>`string`</b><br/>ID of the subnet.|
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
