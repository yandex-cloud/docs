---
editable: false
noIndex: true
---

# yc beta iam

Manage Yandex Identity and Access Manager resources

#### Command Usage

Syntax:

`yc beta iam <group>`

#### Command Tree

- [yc beta iam access-analyzer](access-analyzer/index.md) — A set of methods for access analysis.

  - [yc beta iam access-analyzer list-subject-access-bindings](access-analyzer/list-subject-access-bindings.md) — Returns the list of access bindings for the specified subject in chosen organization.

- [yc beta iam access-key](access-key/index.md) — A set of methods for managing access keys.

  - [yc beta iam access-key create](access-key/create.md) — Creates an access key for the specified service account.

  - [yc beta iam access-key delete](access-key/delete.md) — Deletes the specified access key.

  - [yc beta iam access-key get](access-key/get.md) — Returns the specified access key.

  - [yc beta iam access-key list](access-key/list.md) — Retrieves the list of access keys for the specified service account.

  - [yc beta iam access-key list-operations](access-key/list-operations.md) — Retrieves the list of operations for the specified access key.

  - [yc beta iam access-key update](access-key/update.md) — Updates the specified access key.

- [yc beta iam access-policy-template](access-policy-template/index.md) — 

  - [yc beta iam access-policy-template list](access-policy-template/list.md) — Returns list of available access policy templates.

- [yc beta iam api-key](api-key/index.md) — A set of methods for managing API keys.

  - [yc beta iam api-key create](api-key/create.md) — Creates an API key for the specified service account.

  - [yc beta iam api-key delete](api-key/delete.md) — Deletes the specified API key.

  - [yc beta iam api-key get](api-key/get.md) — Returns the specified API key.

  - [yc beta iam api-key list](api-key/list.md) — Retrieves the list of API keys for the specified service account.

  - [yc beta iam api-key list-operations](api-key/list-operations.md) — Retrieves the list of operations for the specified API key.

  - [yc beta iam api-key list-scopes](api-key/list-scopes.md) — Retrieves the list of scopes.

  - [yc beta iam api-key update](api-key/update.md) — Updates the specified API key.

- [yc beta iam iam-token](iam-token/index.md) — A set of methods for managing IAM tokens.

  - [yc beta iam iam-token create](iam-token/create.md) — Create an IAM token for the specified identity.

  - [yc beta iam iam-token create-for-service-account](iam-token/create-for-service-account.md) — Create an IAM token for service account.

  - [yc beta iam iam-token revoke](iam-token/revoke.md) — Revoke the IAM token.

- [yc beta iam key](key/index.md) — A set of methods for managing Key resources.

  - [yc beta iam key create](key/create.md) — Creates a key pair for the specified service account.

  - [yc beta iam key delete](key/delete.md) — Deletes the specified key pair.

  - [yc beta iam key get](key/get.md) — Returns the specified Key resource.

  - [yc beta iam key list](key/list.md) — Retrieves the list of Key resources for the specified service account.

  - [yc beta iam key list-operations](key/list-operations.md) — Lists operations for the specified key.

  - [yc beta iam key update](key/update.md) — Updates the specified key pair.

- [yc beta iam oauth-client](oauth-client/index.md) — A set of methods for managing OAuthClient resources.

  - [yc beta iam oauth-client create](oauth-client/create.md) — Creates an oauth client in the specified folder.

  - [yc beta iam oauth-client delete](oauth-client/delete.md) — Deletes the specified oauth client with all its secrets.

  - [yc beta iam oauth-client get](oauth-client/get.md) — Returns the sepcified OAuthClient resource.

  - [yc beta iam oauth-client list](oauth-client/list.md) — Retrieves the list of OAuthClient resources views in the specified folder

  - [yc beta iam oauth-client update](oauth-client/update.md) — Updates the specified oauth client.

- [yc beta iam oauth-client-secret](oauth-client-secret/index.md) — A set of methods for managing OAuthClientSecret resources.

  - [yc beta iam oauth-client-secret create](oauth-client-secret/create.md) — Creates an OAuthClientSecret resource for the specified OAuthClient.

  - [yc beta iam oauth-client-secret delete](oauth-client-secret/delete.md) — Deletes the specified OAuthClientSecret resource.

  - [yc beta iam oauth-client-secret get](oauth-client-secret/get.md) — Returns the sepcified OAuthClientSecret resource.

  - [yc beta iam oauth-client-secret list](oauth-client-secret/list.md) — Retrieves the list of OAuthClientSecret resources of the specified OAuthClient.

- [yc beta iam refresh-token](refresh-token/index.md) — A set of methods for managing Refresh Tokens.

  - [yc beta iam refresh-token list](refresh-token/list.md) — List subjects Refresh Tokens.

  - [yc beta iam refresh-token revoke](refresh-token/revoke.md) — Revoke Refresh Tokens. Several Refresh Tokens can be revoked by one request.

- [yc beta iam role](role/index.md) — A set of methods for managing Role resources.

  - [yc beta iam role get](role/get.md) — Returns the specified Role resource.

  - [yc beta iam role list](role/list.md) — Retrieves the list of Role resources.

- [yc beta iam service-account](service-account/index.md) — A set of methods for managing ServiceAccount resources.

  - [yc beta iam service-account create](service-account/create.md) — Creates a service account in the specified folder.

  - [yc beta iam service-account delete](service-account/delete.md) — Deletes the specified service account.

  - [yc beta iam service-account get](service-account/get.md) — Returns the specified ServiceAccount resource.

  - [yc beta iam service-account list](service-account/list.md) — Retrieves the list of ServiceAccount resources in the specified folder.

  - [yc beta iam service-account list-access-bindings](service-account/list-access-bindings.md) — Lists access bindings for the specified service account.

  - [yc beta iam service-account list-operations](service-account/list-operations.md) — Lists operations for the specified service account.

  - [yc beta iam service-account set-access-bindings](service-account/set-access-bindings.md) — Sets access bindings for the service account.

  - [yc beta iam service-account update](service-account/update.md) — Updates the specified service account.

  - [yc beta iam service-account update-access-bindings](service-account/update-access-bindings.md) — Updates access bindings for the specified service account.

- [yc beta iam service-control](service-control/index.md) — A set of methods for managing Service resources.

  - [yc beta iam service-control disable](service-control/disable.md) — Disable a service in the specified resource container.

  - [yc beta iam service-control enable](service-control/enable.md) — Enable a service in the specified resource container.

  - [yc beta iam service-control get](service-control/get.md) — Returns the Service information in the specified resource container.

  - [yc beta iam service-control list](service-control/list.md) — Retrieves the list of Service in the specified resource container.

  - [yc beta iam service-control resolve-agent](service-control/resolve-agent.md) — Resolve agent service account for the service in the specified resource container.

- [yc beta iam temporary-access-key](temporary-access-key/index.md) — A set of methods for managing temporary and ephemeral access keys.

  - [yc beta iam temporary-access-key create-ephemeral](temporary-access-key/create-ephemeral.md) — Creates an ephemeral access key for the specified subject.

- [yc beta iam user-account](user-account/index.md) — A set of methods for managing user accounts. Currently applicable only for [Yandex accounts](/docs/iam/concepts/users/accounts#passport).

  - [yc beta iam user-account get](user-account/get.md) — Returns the specified UserAccount resource.

- [yc beta iam workload-identity](workload-identity/index.md) — 



- [yc beta iam yandex-passport-user-account](yandex-passport-user-account/index.md) — A set of methods for managing YandexPassportUserAccount resources.

  - [yc beta iam yandex-passport-user-account get-by-login](yandex-passport-user-account/get-by-login.md) — Returns the specified YandexPassportUserAccount resource.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#