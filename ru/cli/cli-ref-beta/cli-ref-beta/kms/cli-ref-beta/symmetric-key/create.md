---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/kms/cli-ref-beta/symmetric-key/create.md
---

# yc beta kms symmetric-key create

Creates a symmetric KMS key in the specified folder.

#### Command Usage

Syntax: 

`yc beta kms symmetric-key create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--default-algorithm`|<b>`enum`</b><br/>Encryption algorithm to be used with a new key version, generated with the next rotation. Possible Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm', 'gost-r-3412-2015-k'|
|`--deletion-protection`|Flag that inhibits deletion of the symmetric KMS key|
|`--description`|<b>`string`</b><br/>Description of the key.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a symmetric KMS key in.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the symmetric KMS key as 'key:value' pairs. Maximum 64 per key.<br/>For example, '"project": "mvp"' or '"source": "dictionary"'.|
|`--name`|<b>`string`</b><br/>Name of the key.|
|`--rotation-period`|<b>`duration`</b><br/>Interval between automatic rotations. To disable automatic rotation, don't include<br/>this field in the creation request. (duration, e.g. 30s, 5m10s)|
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
