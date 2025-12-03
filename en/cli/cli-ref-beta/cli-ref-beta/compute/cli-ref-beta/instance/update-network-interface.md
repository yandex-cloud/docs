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
|`--primary-v4-address-spec`|<b>`shorthand/json`</b><br/>Primary IPv4 address that will be assigned to the instance for this network interface.<br/><br/>Example:|
|`--primary-v4-address-spec`|<b>`address=value,`</b><br/>dns-record-specs=[{dns-zone-id=value, fqdn=value, ptr=true, ttl=1}], one-to-one-nat-spec={address=value, dns-record-specs=[{dns-zone-id=value, fqdn=value, ptr=true, ttl=1}], ip-version=IPV4}<br/><br/>Shorthand Syntax:<br/>{address=str, dns-record-specs=[{dns-zone-id=str, fqdn=str, ptr=bool, ttl=int},...], one-to-one-nat-spec={address=str, dns-record-specs=[{dns-zone-id=str, fqdn=str, ptr=bool, ttl=int},...], ip-version=IPV4\|IPV6}}<br/>Fields:<br/>address              string    — An IPv4 internal network address that is assigned to the instance for this network interface.<br/>If not specified by the user, an unused internal IP is assigned by the system.<br/>dns-record-specs     []struct  — Internal DNS configuration<br/>dns-zone-id  string            — DNS zone id (optional, if not set, private zone used)<br/>fqdn         string  required  — FQDN (required)<br/>ptr          bool              — When set to true, also create PTR DNS record (optional)<br/>ttl          int               — DNS record ttl, values in 0-86400 (optional)<br/>one-to-one-nat-spec  struct    — An external IP address configuration.<br/>If not specified, then this instance will have no external internet access.<br/>address           string           —<br/>dns-record-specs  []struct         — External DNS configuration<br/>dns-zone-id  string            — DNS zone id (optional, if not set, private zone used)<br/>fqdn         string  required  — FQDN (required)<br/>ptr          bool              — When set to true, also create PTR DNS record (optional)<br/>ttl          int               — DNS record ttl, values in 0-86400 (optional)<br/>ip-version        enum<IPV4\|IPV6>  — External IP address version.<br/>|
|`--primary-v6-address-spec`|<b>`shorthand/json`</b><br/>Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.<br/><br/>Example:|
|`--primary-v6-address-spec`|<b>`address=value,`</b><br/>dns-record-specs=[{dns-zone-id=value, fqdn=value, ptr=true, ttl=1}], one-to-one-nat-spec={address=value, dns-record-specs=[{dns-zone-id=value, fqdn=value, ptr=true, ttl=1}], ip-version=IPV4}<br/><br/>Shorthand Syntax:<br/>{address=str, dns-record-specs=[{dns-zone-id=str, fqdn=str, ptr=bool, ttl=int},...], one-to-one-nat-spec={address=str, dns-record-specs=[{dns-zone-id=str, fqdn=str, ptr=bool, ttl=int},...], ip-version=IPV4\|IPV6}}<br/>Fields:<br/>address              string    — An IPv4 internal network address that is assigned to the instance for this network interface.<br/>If not specified by the user, an unused internal IP is assigned by the system.<br/>dns-record-specs     []struct  — Internal DNS configuration<br/>dns-zone-id  string            — DNS zone id (optional, if not set, private zone used)<br/>fqdn         string  required  — FQDN (required)<br/>ptr          bool              — When set to true, also create PTR DNS record (optional)<br/>ttl          int               — DNS record ttl, values in 0-86400 (optional)<br/>one-to-one-nat-spec  struct    — An external IP address configuration.<br/>If not specified, then this instance will have no external internet access.<br/>address           string           —<br/>dns-record-specs  []struct         — External DNS configuration<br/>dns-zone-id  string            — DNS zone id (optional, if not set, private zone used)<br/>fqdn         string  required  — FQDN (required)<br/>ptr          bool              — When set to true, also create PTR DNS record (optional)<br/>ttl          int               — DNS record ttl, values in 0-86400 (optional)<br/>ip-version        enum<IPV4\|IPV6>  — External IP address version.<br/>|
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
