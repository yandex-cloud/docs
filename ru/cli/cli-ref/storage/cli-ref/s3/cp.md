---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3/cp.md
---

# yc storage s3 cp

Copies a local file or S3 object to another location locally or in S3

#### Command Usage

Syntax: 

`yc storage s3 cp <LocalPath> <S3Uri> or <S3Uri> <LocalPath> or <S3Uri> <S3Uri> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--no-follow-symlinks`|Symbolic links are followed only when uploading to S3 from the local filesystem. Note that S3 does not support symbolic links, so the contents of the link target are uploaded under the name of the link.|
|`--recursive`|Command is performed on all files or objects under the specified directory or prefix.|
|`--acl`|<b>`string`</b><br/>Sets a predefined ACL for an object.|
|`--exclude`|<b>`value[,value]`</b><br/>Exclude all files or objects from the command that matches the specified pattern.|
|`--include`|<b>`value[,value]`</b><br/>Do not exclude files or objects in the command that match the specified pattern.|
|`--sse`|<b>`string`</b><br/>The encryption algorithm of an uploaded object. Possible values: aws:kms.|
|`--storage-class`|<b>`string`</b><br/>Object storage class.|
|`--metadata`|<b>`stringToString`</b><br/>User-defined metadata.|
|`--page-size`|<b>`int32`</b><br/>The number of items to return per page.|
|`--dryrun`|Displays the operations that would be performed using the specified command without actually running them.|
|`--quiet`|Does not display the operations performed from the specified command.|
|`--no-paginate`|Disable automatic pagination. If automatic pagination is disabled, the CLI will only make one call, for the first page of results.|
|`--only-show-errors`|Only errors and warnings are displayed. All other output is suppressed.|
|`--cache-control`|<b>`string`</b><br/>Directives for caching data according to RFC 2616.|
|`--content-disposition`|<b>`string`</b><br/>Name Object Storage will suggest for the object to save it as a file when downloaded. Compliant with RFC 2616.|
|`--content-encoding`|<b>`string`</b><br/>Defines the content encoding according to RFC 2616.|
|`--content-type`|<b>`string`</b><br/>Data type in a request.|
|`--expires`|<b>`timestamp`</b><br/>The date and time at which the object is no longer cacheable.|
|`--ssekms-key-id`|<b>`string`</b><br/>The ID of the KMS key for encrypting an uploaded object.|
|`--request-payer`|<b>`string`</b><br/>Confirms that the requester knows that she or he will be charged for the request.|
|`--sse-c`|<b>`string`</b><br/>Specifies server-side encryption using customer provided keys of the the object in S3. AES256 is the only valid value.|
|`--sse-c-key`|<b>`string`</b><br/>The customer-provided encryption key to use to server-side encrypt the object in S3.|
|`--sse-c-copy-source`|<b>`string`</b><br/>This parameter should only be specified when copying an S3 object that was encrypted server-side with a customer-provided key. It specifies the algorithm to use when decrypting the source object.|
|`--sse-c-copy-source-keys`|<b>`string`</b><br/>This parameter should only be specified when copying an S3 object that was encrypted server-side with a customer-provided key. Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object.|
|`--content-language`|<b>`string`</b><br/>The language the content is in.|
|`--grants`|<b>`value[,value]`</b><br/>Grant specific permissions to individual users or groups.|
|`--checksum-algorithm`|<b>`string`</b><br/>Indicates the algorithm used to create the checksum for the object.|
|`--copy-props`|<b>`string`</b><br/>Determines which properties are copied from the source S3 object. This parameter only applies for S3 to S3 copies. Valid values are: none, metadata-directive, default.|
|`--no-guess-mime-type`|Do not try to guess the mime type for uploaded files. By default the mime type of a file is guessed when it is uploaded.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
