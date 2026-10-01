[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [storage](../../index.md) > [v0](../index.md) > [s3](index.md) > rm

# yc storage v0 s3 rm

Deletes an S3 object

#### Command Usage

Syntax:

`yc storage v0 s3 rm <S3URI> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--recursive` | Command is performed on all files or objects under the specified directory or prefix. ||
|| `--exclude` | `[]string`

Exclude all files or objects from the command that match the specified pattern. ||
|| `--include` | `[]string`

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

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#