---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/iam/cli-ref/v0/index
editable: false
---

# yc iam v0

Manage Yandex Identity and Access Manager resources

#### Command Usage

Syntax:

`yc iam v0 <group|command>`

#### Command Tree

- [yc iam v0 create-id-token](create-id-token.md) — Create ID token and print to STDOUT

- [yc iam v0 create-token](create-token.md) — Create IAM token and print to STDOUT

- [yc iam v0 revoke-token](revoke-token.md) — Revoke IAM token

- [yc iam v0 whoami](whoami.md) — Print currently authenticated subject to STDOUT

- [yc iam v0 access-analyzer](access-analyzer/index.md) — Manage access analyzer

  - [yc iam v0 access-analyzer list-subject-access-bindings](access-analyzer/list-subject-access-bindings.md) — List access bindings for the specified subject

- [yc iam v0 access-key](access-key/index.md) — Manage service account access keys

  - [yc iam v0 access-key create](access-key/create.md) — Create an access key for the specified service account

  - [yc iam v0 access-key delete](access-key/delete.md) — Delete the specified access key

  - [yc iam v0 access-key get](access-key/get.md) — Show information about the specified access key

  - [yc iam v0 access-key issue-ephemeral](access-key/issue-ephemeral.md) — Issue ephemeral access key

  - [yc iam v0 access-key list](access-key/list.md) — List access keys for the specified service account

- [yc iam v0 access-policy-template](access-policy-template/index.md) — Manage access policy templates

  - [yc iam v0 access-policy-template list](access-policy-template/list.md) — List available access policy templates

- [yc iam v0 api-key](api-key/index.md) — Manage service account API keys

  - [yc iam v0 api-key create](api-key/create.md) — Create an API key for the specified service account

  - [yc iam v0 api-key delete](api-key/delete.md) — Delete the specified API key

  - [yc iam v0 api-key get](api-key/get.md) — Show information about the specified API key

  - [yc iam v0 api-key list](api-key/list.md) — List API keys for the specified service account

  - [yc iam v0 api-key list-scopes](api-key/list-scopes.md) — List of scopes

  - [yc iam v0 api-key update](api-key/update.md) — Update an API key for the specified service account

- [yc iam v0 key](key/index.md) — Manage IAM keys

  - [yc iam v0 key create](key/create.md) — Create an IAM key for for authenticated account or the specified service account

  - [yc iam v0 key delete](key/delete.md) — Delete the specified IAM key

  - [yc iam v0 key get](key/get.md) — Show information about the specified IAM key

  - [yc iam v0 key list](key/list.md) — List IAM keys for authenticated account or the specified service account

- [yc iam v0 oauth-client](oauth-client/index.md) — Manage oauth-clients

  - [yc iam v0 oauth-client create](oauth-client/create.md) — Create an oauth-client in the specified folder

  - [yc iam v0 oauth-client delete](oauth-client/delete.md) — Delete the specified oauth-client

  - [yc iam v0 oauth-client get](oauth-client/get.md) — Show information about state of a specified oauth-client

  - [yc iam v0 oauth-client list](oauth-client/list.md) — List oauth-clients in the specified folder

  - [yc iam v0 oauth-client update](oauth-client/update.md) — Update the specified oauth-client

- [yc iam v0 oauth-client-secret](oauth-client-secret/index.md) — Manage oauth-client secrets

  - [yc iam v0 oauth-client-secret create](oauth-client-secret/create.md) — Create a secret for the specified oauth-client

  - [yc iam v0 oauth-client-secret delete](oauth-client-secret/delete.md) — Delete the specified oauth-client secret

  - [yc iam v0 oauth-client-secret get](oauth-client-secret/get.md) — Show information about state of a specified oauth-client secret

  - [yc iam v0 oauth-client-secret list](oauth-client-secret/list.md) — List secrets of the specified oauth-client

- [yc iam v0 refresh-token](refresh-token/index.md) — Manage refresh tokens

  - [yc iam v0 refresh-token list](refresh-token/list.md) — List subjects Refresh Tokens

  - [yc iam v0 refresh-token revoke](refresh-token/revoke.md) — Revoke subjects Refresh Tokens. Refresh Tokens can be revoked by refresh token, refresh token id, or a group of subject id, client id and client instance info. If none of the flags are set, all Refresh Tokens for the authenticated user will be revoked.

- [yc iam v0 role](role/index.md) — Manage roles

  - [yc iam v0 role get](role/get.md) — Show information about the specified role

  - [yc iam v0 role list](role/list.md) — List roles

- [yc iam v0 service-account](service-account/index.md) — Manage service accounts

  - [yc iam v0 service-account add-access-binding](service-account/add-access-binding.md) — Add access binding to ACCESS the specified service account as a resource. To configure service account access to a resource use add-access-binding command for the corresponding resource

  - [yc iam v0 service-account add-labels](service-account/add-labels.md) — Add labels to specified service account

  - [yc iam v0 service-account create](service-account/create.md) — Create a service account

  - [yc iam v0 service-account delete](service-account/delete.md) — Delete the specified service account

  - [yc iam v0 service-account get](service-account/get.md) — Show information about the specified service account

  - [yc iam v0 service-account list](service-account/list.md) — List service accounts

  - [yc iam v0 service-account list-access-bindings](service-account/list-access-bindings.md) — List access bindings for ACCESSING the specified service account. To determine if a service account has an access to a resource, use list-access-bindings command for the corresponding resource

  - [yc iam v0 service-account list-operations](service-account/list-operations.md) — List operations for the specified service account

  - [yc iam v0 service-account remove-access-binding](service-account/remove-access-binding.md) — Remove access binding for ACCESSING the specified service account as a resource. To configure service account access to a resource use remove-access-binding command for the corresponding resource

  - [yc iam v0 service-account remove-labels](service-account/remove-labels.md) — Remove labels from specified service account

  - [yc iam v0 service-account set-access-bindings](service-account/set-access-bindings.md) — Set access bindings for ACCESSING the specified service account and DELETE all existing access bindings for all accounts if there were any. To configure service account access to a resource use set-access-bindings command for the corresponding resource

  - [yc iam v0 service-account update](service-account/update.md) — Update the specified service account

- [yc iam v0 service-control](service-control/index.md) — Manage service access to cloud

  - [yc iam v0 service-control disable](service-control/disable.md) — Disable service access to cloud

  - [yc iam v0 service-control enable](service-control/enable.md) — Enable service access to cloud

  - [yc iam v0 service-control get](service-control/get.md) — Show information about state of specified service

  - [yc iam v0 service-control list](service-control/list.md) — List service states

- [yc iam v0 user-account](user-account/index.md) — Manage user accounts

  - [yc iam v0 user-account get](user-account/get.md) — Show information about the specified user account

- [yc iam v0 workload-identity](workload-identity/index.md) — Manage workload identity



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
