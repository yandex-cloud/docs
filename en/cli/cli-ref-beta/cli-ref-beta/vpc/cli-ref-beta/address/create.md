---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/address/create.md
---

# yc beta vpc address create

Creates an address in the specified folder and network.

#### Command Usage

Syntax: 

`yc beta vpc address create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--deletion-protection`|Specifies if address protected from deletion.|
|`--description`|<b>`string`</b><br/>Description of the address.|
|`--dns-record-specs`|<b>`shorthand/json`</b><br/>Optional DNS record specifications<br/><br/>Example:|
|`--dns-record-specs`|<b>`[{dns-zone-id=value,`</b><br/>fqdn=value, ptr=true, ttl=1}]<br/><br/>Shorthand Syntax:<br/>[{dns-zone-id=str, fqdn=str, ptr=bool, ttl=int},...]<br/>Fields:<br/>dns-zone-id  string  required  — Required. ID of the public DNS zone. The maximum string length in characters is 20.<br/>fqdn         string  required  — Required. DNS record name (absolute or relative to the DNS zone in use).<br/>ptr          bool              — Optional. If the PTR record is required, this parameter must be set to "true".<br/>ttl          int               — TTL of record. Acceptable values are 0 to 86400, inclusive.<br/>|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a address in.<br/><br/>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Address labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the address.<br/>The name must be unique within the folder.|
|`--external-ipv4-address-spec`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--external-ipv4-address-spec`|<b>`address=value,`</b><br/>requirements={ddos-protection-provider=value, outgoing-smtp-capability=value}, zone-id=value<br/><br/>Shorthand Syntax:<br/>{address=str, requirements={ddos-protection-provider=str, outgoing-smtp-capability=str}, zone-id=str}<br/>Fields:<br/>address       string  — Value of address.<br/>requirements  struct  — Parameters of the allocated address, for example DDoS Protection.<br/>ddos-protection-provider  string  — DDoS protection provider ID.<br/>outgoing-smtp-capability  string  — Capability to send SMTP traffic.<br/>zone-id       string  — Availability zone from which the address will be allocated.<br/>|
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
