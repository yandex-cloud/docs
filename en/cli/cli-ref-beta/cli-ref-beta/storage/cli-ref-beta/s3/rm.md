---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3/rm.md
---

# yc beta storage s3 rm

Deletes an S3 object

#### Command Usage

Syntax: 

`yc beta storage s3 rm <S3Uri> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--no-follow-symlinks`|Symbolic links are followed only when working with the local filesystem.|
|`--recursive`|Command is performed on all files or objects under the specified directory or prefix.|
|`--exclude`|<b>`strings`</b><br/>Exclude all files or objects from the command that match the specified pattern.|
|`--include`|<b>`strings`</b><br/>Do not exclude files or objects in the command that match the specified pattern.|
|`--page-size`|<b>`int32`</b><br/>The number of items to return per page.|
|`--dry-run`|Displays the operations that would be performed using the specified command without actually running them.|
|`--quiet`|Does not display the operations performed from the specified command.|
|`--no-paginate`|Disable automatic pagination. If automatic pagination is disabled, the CLI will only make one call, for the first page of results.|
|`--only-show-errors`|Only errors and warnings are displayed. All other output is suppressed.|
|`--request-payer`|<b>`string`</b><br/>Confirms that the requester knows that she or he will be charged for the request.|
|`--max-queue-size`|<b>`int`</b><br/>The maximum number of tasks in the task queue.|

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
