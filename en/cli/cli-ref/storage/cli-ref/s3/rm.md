---
editable: false
---

# yc storage s3 rm

Deletes an S3 object

#### Command Usage

Syntax:

`yc storage s3 rm <S3Uri> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--recursive` | Command is performed on all files or objects under the specified directory or prefix. ||
|| `--exclude` | `value[,value]`

Exclude all files or objects from the command that matches the specified pattern. ||
|| `--include` | `value[,value]`

Do not exclude files or objects in the command that match the specified pattern. ||
|| `--page-size` | `int32`

The number of items to return per page. ||
|| `--dryrun` | Displays the operations that would be performed using the specified command without actually running them. ||
|| `--quiet` | Does not display the operations performed from the specified command. ||
|| `--no-paginate` | Disable automatic pagination. If automatic pagination is disabled, the CLI will only make one call, for the first page of results. ||
|| `--only-show-errors` | Only errors and warnings are displayed. All other output is suppressed. ||
|| `--request-payer` | `string`

Confirms that the requester knows that she or he will be charged for the request. ||
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