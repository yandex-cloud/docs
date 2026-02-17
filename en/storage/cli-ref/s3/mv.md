---
editable: false
---

# yc storage s3 mv

Moves a local file or S3 object to another location locally or in S3

#### Command Usage

Syntax:

`yc storage s3 mv <LocalPath> <S3Uri> or <S3Uri> <LocalPath> or <S3Uri> <S3Uri> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--no-follow-symlinks` | Symbolic links are followed only when uploading to S3 from the local filesystem. Note that S3 does not support symbolic links, so the contents of the link target are uploaded under the name of the link. ||
|| `--recursive` | Command is performed on all files or objects under the specified directory or prefix. ||
|| `--acl` | `string`

Sets a predefined ACL for an object. ||
|| `--exclude` | `value[,value]`

Exclude all files or objects from the command that matches the specified pattern. ||
|| `--include` | `value[,value]`

Do not exclude files or objects in the command that match the specified pattern. ||
|| `--sse` | `string`

The encryption algorithm of an uploaded object. Possible values: aws:kms. ||
|| `--storage-class` | `string`

Object storage class. ||
|| `--metadata` | `stringToString`

User-defined metadata. ||
|| `--page-size` | `int32`

The number of items to return per page. ||
|| `--dryrun` | Displays the operations that would be performed using the specified command without actually running them. ||
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
|| `--expires` | `timestamp`

The date and time at which the object is no longer cacheable. ||
|| `--ssekms-key-id` | `string`

The ID of the KMS key for encrypting an uploaded object. ||
|| `--request-payer` | `string`

Confirms that the requester knows that she or he will be charged for the request. ||
|| `--content-language` | `string`

The language the content is in. ||
|| `--grants` | `value[,value]`

Grant specific permissions to individual users or groups. ||
|| `--checksum-algorithm` | `string`

Indicates the algorithm used to create the checksum for the object. ||
|| `--copy-props` | `string`

Determines which properties are copied from the source S3 object. This parameter only applies for S3 to S3 copies. Valid values are: none, metadata-directive, default. ||
|| `--no-guess-mime-type` | Do not try to guess the mime type for uploaded files. By default the mime type of a file is guessed when it is uploaded. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#