---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3/cp.md
---

# yc beta storage s3 cp

Copies a local file or S3 object to another location locally or in S3

#### Command Usage

Syntax: 

`yc beta storage s3 cp <LocalPath> <S3Uri> or <S3Uri> <LocalPath> or <S3Uri> <S3Uri> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--no-follow-symlinks`|Symbolic links are followed only when uploading to S3 from the local filesystem. Note that S3 does not support symbolic links, so the contents of the link target are uploaded under the name of the link.|
|`--recursive`|Command is performed on all files or objects under the specified directory or prefix.|
|`--acl`|<b>`string`</b><br/>Sets a predefined ACL for an object.|
|`--exclude`|<b>`strings`</b><br/>Exclude all files or objects from the command that matches the specified pattern.|
|`--include`|<b>`strings`</b><br/>Do not exclude files or objects in the command that match the specified pattern.|
|`--sse`|<b>`string`</b><br/>The encryption algorithm of an uploaded object. Possible values: aws:kms.|
|`--storage-class`|<b>`string`</b><br/>Object storage class.|
|`--metadata`|<b>`stringToString`</b><br/>User-defined metadata.|
|`--page-size`|<b>`int32`</b><br/>The number of items to return per page.|
|`--dry-run`|Displays the operations that would be performed using the specified command without actually running them.|
|`--quiet`|Does not display the operations performed from the specified command.|
|`--no-paginate`|Disable automatic pagination. If automatic pagination is disabled, the CLI will only make one call, for the first page of results.|
|`--only-show-errors`|Only errors and warnings are displayed. All other output is suppressed.|
|`--cache-control`|<b>`string`</b><br/>Directives for caching data according to RFC 2616.|
|`--content-disposition`|<b>`string`</b><br/>Name Object Storage will suggest for the object to save it as a file when downloaded. Compliant with RFC 2616.|
|`--content-encoding`|<b>`string`</b><br/>Defines the content encoding according to RFC 2616.|
|`--content-type`|<b>`string`</b><br/>Data type in a request.|
|`--expires`|<b>`time`</b><br/>The date and time at which the object is no longer cacheable. (RFC3339)|
|`--sse-kms-key-id`|<b>`string`</b><br/>The ID of the KMS key for encrypting an uploaded object.|
|`--request-payer`|<b>`string`</b><br/>Confirms that the requester knows that she or he will be charged for the request.|
|`--content-language`|<b>`string`</b><br/>The language the content is in.|
|`--grants`|<b>`strings`</b><br/>Grant specific permissions to individual users or groups.|
|`--checksum-algorithm`|<b>`string`</b><br/>Indicates the algorithm used to create the checksum for the object.|
|`--copy-props`|<b>`string`</b><br/>Determines which properties are copied from the source S3 object. This parameter only applies for S3 to S3 copies. Valid values are: none, metadata-directive, default.|
|`--no-guess-mime-type`|Do not try to guess the mime type for uploaded files. By default the mime type of a file is guessed when it is uploaded.|
|`--max-concurrent-requests`|<b>`int`</b><br/>The maximum number of concurrent requests.|
|`--max-queue-size`|<b>`int`</b><br/>The maximum number of tasks in the task queue.|
|`--multipart-chunksize`|<b>`string`</b><br/>When using multipart transfers, this is the chunk size that the CLI uses for multipart transfers of individual files.|
|`--multipart-threshold`|<b>`string`</b><br/>The size threshold the CLI uses for multipart transfers of individual files.|

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
