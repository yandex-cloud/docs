[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Desktop](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > [group](index.md) > remove-access-bindings

# yc desktops v0 group remove-access-bindings

Remove access binding for the specified desktop group

#### Command Usage

Syntax:

`yc desktops v0 group remove-access-bindings <DESKTOP-GROUP-NAME>|<DESKTOP-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Desktop group id. ||
|| `--name` | `string`

Desktop group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--role` | `string`

Binding role ID. ||
|| `--service-account-id` | `string`

Service account, whose access will be updated. ||
|| `--service-account-name` | `string`

Service account, whose access will be updated. ||
|| `--user-account-id` | `string`

User account, whose access will be updated. ||
|| `--user-yandex-login` | `string`

User account, whose access will be updated. ||
|| `--agent` | `string`

Agent service account in SERVICE_ID:MICROSERVICE_ID format. ||
|| `--all-authenticated-users` | Access will be updated for all authenticated users ||
|| `--group-members` | `string`

Update access for members of the group with specified ID ||
|| `--organization-users` | `string`

Update access for users of organization with specified ID ||
|| `--federation-users` | `string`

Update access for users of federation with specified ID ||
|| `--subject` | `string`

Subject whose access will be updated; in TYPE:ID format. ||
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