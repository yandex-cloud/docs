---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/federation/group-mapping/update-items.md
---

# yc beta organization-manager federation group-mapping update-items

Updates group mapping items for a specified federation  Errors:  - if federation is not found  - if internal group in the mapping added does not exist  In case of any error, no changes are applied to existing group mapping

#### Command Usage

Syntax: 

`yc beta organization-manager federation group-mapping update-items <FEDERATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--federation-id`|<b>`string`</b><br/>Federation the group mapping update is requested|
|`--group-mapping-item-deltas`|<b>`shorthand/json`</b><br/>A collection of mapping items to add or remove (ignores update_fields).<br/><br/>Example:|
|`--group-mapping-item-deltas`|<b>`[{action=ADD,`</b><br/>item={external-group-id=value, internal-group-id=value}}]<br/><br/>Shorthand Syntax:<br/>[{action=ADD\|REMOVE, item={external-group-id=str, internal-group-id=str}},...]<br/>Fields:<br/>action  enum<ADD\|REMOVE>  —<br/>item    struct            —<br/>external-group-id  string  required  — External group id (received from identity provider)<br/>internal-group-id  string  required  — Internal cloud group id<br/>|
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
