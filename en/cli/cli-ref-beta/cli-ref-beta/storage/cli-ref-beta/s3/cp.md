---
editable: false
noIndex: true
---

# yc beta storage s3 cp

Copies a local file or S3 object to another location locally or in S3

#### Command Usage

Syntax:

`yc beta storage s3 cp <LocalPath> <S3Uri> or <S3Uri> <LocalPath> or <S3Uri> <S3Uri> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--no-follow-symlinks` | Symbolic links are followed only when uploading to S3 from the local filesystem. Note that S3 does not support symbolic links, so the contents of the link target are uploaded under the name of the link. ||
|| `--recursive` | Command is performed on all files or objects under the specified directory or prefix. ||
|| `--acl` | `string`

Sets a predefined ACL for an object. ||
|| `--exclude` | `[]string`

Exclude all files or objects from the command that matches the specified pattern. ||
|| `--include` | `[]string`

Do not exclude files or objects in the command that match the specified pattern. ||
|| `--sse` | `string`

The encryption algorithm of an uploaded object. Possible values: aws:kms. ||
|| `--storage-class` | `string`

Object storage class. ||
|| `--metadata` | `map<string><string>`

User-defined metadata. ||
|| `--page-size` | `int32`

The number of items to return per page. ||
|| `--dry-run` | Displays the operations that would be performed using the specified command without actually running them. ||
|| `--quiet` | Does not display the operations performed from the specified command. ||
|| `--no-paginate` | Disable automatic pagination. If automatic pagination is disabled, the CLI will only make one call, for the first page of results. ||
|| `--only-show-errors` | Only errors and warnings are displayed. All other output is suppressed. ||
|| `--cache-control` | `string`

Directives for caching data according to RFC 2616. ||
|| `--content-disposition` | `string`

Name Object Storage will suggest for the object to save it as a file when downloaded. Compliant with RFC 2616. ||
|| `--content-encoding` | `string`

Defines the content encoding according to RFC 2616. ||
|| `--content-type` | `string`

Data type in a request. ||
|| `--expires` | `time`

The date and time at which the object is no longer cacheable. (RFC3339) ||
|| `--sse-kms-key-id` | `string`

The ID of the KMS key for encrypting an uploaded object. ||
|| `--request-payer` | `string`

Confirms that the requester knows that she or he will be charged for the request. ||
|| `--content-language` | `string`

The language the content is in. ||
|| `--grants` | `[]string`

Grant specific permissions to individual users or groups. ||
|| `--checksum-algorithm` | `string`

Indicates the algorithm used to create the checksum for the object. ||
|| `--copy-props` | `string`

Determines which properties are copied from the source S3 object. This parameter only applies for S3 to S3 copies. Valid values are: none, metadata-directive, default. ||
|| `--no-guess-mime-type` | Do not try to guess the mime type for uploaded files. By default the mime type of a file is guessed when it is uploaded. ||
|| `--max-concurrent-requests` | `int`

The maximum number of concurrent requests. ||
|| `--max-queue-size` | `int`

The maximum number of tasks in the task queue. ||
|| `--multipart-chunksize` | `bytes`

When using multipart transfers, this is the chunk size that the CLI uses for multipart transfers of individual files. ||
|| `--multipart-threshold` | `bytes`

The size threshold the CLI uses for multipart transfers of individual files. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#