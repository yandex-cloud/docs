---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/refresh-token/revoke.md
---

# yc iam refresh-token revoke

Revoke subjects Refresh Tokens. Refresh Tokens can be revoked by refresh token, refresh token id, or a group of subject id, client id and client instance info. If none of the flags are set, all Refresh Tokens for the authenticated user will be revoked.

#### Command Usage

Syntax:

`yc iam refresh-token revoke [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--refresh-token-id` | `string`

Refresh Token Id to be revoked. ||
|| `--refresh-token` | Use this flag if it is necessary to revoke a specific Refresh Token using the Refresh Token itself. The Refresh Token should be passed through the standard stdin. ||
|| `--subject-id` | `string`

Subject ID whose Refresh Tokens should be revoked. If the field is not specified, the current subject will be used. ||
|| `--client-id` | `string`

Client ID whose Refresh Tokens will be revoked. ||
|| `--client-instance-info` | `string`

Client Instance Info whose Refresh Tokens will be revoked. ||
|| `-y`, `--yes` | Automatic yes to prompts. Use in case of executing command without any flags. ||
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