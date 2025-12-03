---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cdn/cli-ref-beta/raw-logs/update.md
---

# yc beta cdn raw-logs update



#### Command Usage

Syntax: 

`yc beta cdn raw-logs update <RESOURCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--resource-id`|<b>`string`</b><br/>ID of CDN resource.|
|`--settings`|<b>`shorthand/json`</b><br/>Raw logs settings.<br/><br/>Example:|
|`--settings`|<b>`bucket-name=value,`</b><br/>bucket-region=value, file-prefix=value<br/><br/>Shorthand Syntax:<br/>{bucket-name=str, bucket-region=str, file-prefix=str}<br/>Fields:<br/>bucket-name    string  required  — Destination S3 bucket name, note that the suer should be owner of the bucket.<br/>bucket-region  string            — Bucket region, unused for now, could be blank.<br/>file-prefix    string            — file_prefix: prefix each log object name with specified prefix.<br/><br/>The prefix makes it simpler for you to locate the log objects.<br/>For example, if you specify the prefix value logs/, each log object that<br/>S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders<br/>could be setup.<br/>|
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
