---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/scan-policy/create.md
---

# yc beta container scan-policy create

Creates a scan policy for the specified registry.

#### Command Usage

Syntax: 

`yc beta container scan-policy create <REGISTRY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the scan policy.|
|`--name`|<b>`string`</b><br/>Name of the scan policy.|
|`--registry-id`|<b>`string`</b><br/>ID of the scan policy registry.|
|`--rules`|<b>`shorthand/json`</b><br/>Rules of the scan policy.<br/><br/>Example:|
|`--rules`|<b>`push-rule={disabled=true,`</b><br/>repository-prefixes=value}, schedule-rules=[{disabled=true, repository-prefixes=value, rescan-period=1h30m}]<br/><br/>Shorthand Syntax:<br/>{push-rule={disabled=bool, repository-prefixes=str,...}, schedule-rules=[{disabled=bool, repository-prefixes=str,..., rescan-period=duration},...]}<br/>Fields:<br/>push-rule       struct    — Description of on-push scan rule.<br/>disabled             bool      — Turns off scan rule.<br/>repository-prefixes  []string  — List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry<br/>schedule-rules  []struct  — Description of time based rescan rule.<br/>disabled             bool                — Turns off scan rule.<br/>repository-prefixes  []string            — List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry<br/>rescan-period        duration  required  — Period of time since last scan to trigger automatic rescan.<br/>|
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
