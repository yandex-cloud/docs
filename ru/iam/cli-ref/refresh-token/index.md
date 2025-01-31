---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/refresh-token/index.md
---

# yc iam refresh-token

Manage refresh tokens. Refresh token allows to get new IAM token in OAuth flow.

#### Command Usage

Syntax: 

`yc iam refresh-token <command>`

#### Command Tree

- [yc iam refresh-token list](list.md) — List subjects Refresh Tokens
- [yc iam refresh-token revoke](revoke.md) — Revoke subjects Refresh Tokens. Refresh Tokens can be revoked by refresh token, refresh token id, or a group of subject id, client id and client instance info. If none of the flags are set, all Refresh Tokens for the authenticated user will be revoked.

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
