[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Valkey™](../../index.md) > [Справочник CLI (англ.)](../index.md) > [user](index.md) > update

# yc managed-redis user update

Update the specified Redis user

#### Command Usage

Syntax:

`yc managed-redis user update <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Redis cluster id. ||
|| `--cluster-name` | `string`

Redis cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--password` | `string`

Password of Redis user ||
|| `--password-file` | `string`

File containing the password of the Redis user. ||
|| `--password-from-stdin` | Read password from stdin. ||
|| `--disabled` | Disabled flag of Redis user. False by default. ||
|| `--enabled` | Enabled flag of Redis user. True by default ||
|| `--raw` | `string`

Raw ACL permissions string format ||
|| `--categories` | `string`

Set of categories permissions grant access to ||
|| `--commands` | `string`

Set of commands permissions grant access to ||
|| `--sanitize-payload` | `string`

[DEPRECATED] Sanitize payload setting. Possible values: sanitize-payload, skip-sanitize-payload. This parameter is ignored. ||
|| `--patterns` | `string`

Set of patterns permissions grant access to ||
|| `--pub-sub-channels` | `string`

Set of pub/sub channels permissions grant access to ||
|| `--databases` | `string`

Databases permissions grant access to. Possible values: alldbs, resetdbs, db=&lt;id&gt;[,&lt;id&gt;...] ||
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