---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/add-one-to-one-nat.md
---

# yc beta compute instance add-one-to-one-nat

Enables One-to-one NAT on the network interface.

#### Command Usage

Syntax: 

`yc beta compute instance add-one-to-one-nat <INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--instance-id`|<b>`string`</b><br/>ID of the instance to enable One-to-One NAT on.|
|`--internal-address`|<b>`string`</b><br/>The network address that is assigned to the instance for this network interface.|
|`--network-interface-index`|<b>`string`</b><br/>The index of the network interface to enable One-to-One NAT on.|
|`--one-to-one-nat-spec`|<b>`shorthand/json`</b><br/>An external IP address configuration. If not specified, then this instance will have no external internet access.<br/>Shorthand Syntax:<br/>{<br/>address = str,<br/>dns-record-specs = [<br/>{<br/>dns-zone-id = str,<br/>fqdn = str,<br/>ptr = bool,<br/>ttl = int<br/>}, ...<br/>],<br/>ip-version = IPV4\|IPV6<br/>}<br/>JSON Syntax:<br/>"{<br/>"address": "str",<br/>"dns-record-specs": [<br/>{<br/>"dns-zone-id": "str",<br/>"fqdn": "str",<br/>"ptr": "bool",<br/>"ttl": "int"<br/>}, ...<br/>],<br/>"ip-version": "IPV4\|IPV6"<br/>}"<br/>Fields:<br/>address -> (string)<br/>dns-record-specs -> ([]struct)<br/>External DNS configuration<br/>dns-zone-id -> (string)<br/>DNS zone id (optional, if not set, private zone used)<br/>fqdn -> (string)<br/>FQDN (required)<br/>ptr -> (bool)<br/>When set to true, also create PTR DNS record (optional)<br/>ttl -> (int)<br/>DNS record ttl, values in 0-86400 (optional)<br/>ip-version -> (enum<IPV4\|IPV6>)<br/>External IP address version.|
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
