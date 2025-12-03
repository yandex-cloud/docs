---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/lockbox/cli-ref-beta/secret/add-version.md
---

# yc beta lockbox secret add-version

Adds new version based on a previous one.

#### Command Usage

Syntax: 

`yc beta lockbox secret add-version <SECRET-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--base-version-id`|<b>`string`</b><br/>Optional base version id. Defaults to the current version if not specified|
|`--description`|<b>`string`</b><br/>Description of the version.|
|`--payload-entries`|<b>`shorthand/json`</b><br/>Describe how payload entries of the base version change in the added version.<br/><br/>Example:|
|`--payload-entries`|<b>`[{key=value,`</b><br/>value={binary-value=1}}]<br/><br/>Shorthand Syntax:<br/>[{key=str, value={binary-value=uint,... \| text-value=str}},...]<br/>Fields:<br/>key    string                          required  — Non-confidential key of the entry.<br/>value  oneof<binary-value\|text-value>            — Oneof value field<br/>text-value    string  — Use the field to set a text value.<br/>binary-value  bytes   — Use the field to set a binary value.<br/>|
|`--secret-id`|<b>`string`</b><br/>ID of the secret.|
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
