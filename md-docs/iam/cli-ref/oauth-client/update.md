[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Справочник CLI (англ.)](../index.md) > [oauth-client](index.md) > update

# yc iam oauth-client update

Update the specified oauth-client

#### Command Usage

Syntax:

`yc iam oauth-client update [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

OAuth-client id. ||
|| `--name` | `string`

OAuth-client name. ||
|| `--new-name` | `string`

A new name for the oauth client ||
|| `--redirect-uris` | `[]string`

A list of URIs where a user of the oauth-client can be redirected to. ||
|| `--post-logout-redirect-uris` | `[]string`

A list of URIs where users can be redirected after signing out of the OAuth client. ||
|| `--scopes` | `[]string`

List of scopes that the oauth-client will request access to. ||
|| `--auth-methods` | `[]string`

The Authentication methods that are allowed to be set on the oauth client. ||
|| `--pkce-required` | Whether PKCE (Proof Key for Code Exchange) is required for the oauth client during the authorization code flow. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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