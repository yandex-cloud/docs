---
editable: false
noIndex: true
---

# yc beta iam workload-identity oidc



#### Command Usage

Syntax:

`yc beta iam workload-identity oidc <group>`

#### Command Tree

- [yc beta iam workload-identity oidc federation](federation/index.md) — A set of methods for managing OIDC workload identity federations.

  - [yc beta iam workload-identity oidc federation create](federation/create.md) — Creates an OIDC workload identity federation in the specified folder.

  - [yc beta iam workload-identity oidc federation delete](federation/delete.md) — Deletes the specified OIDC workload identity federation.

  - [yc beta iam workload-identity oidc federation get](federation/get.md) — Returns the specified OIDC workload identity federation.

  - [yc beta iam workload-identity oidc federation list](federation/list.md) — Retrieves the list of OIDC workload identity federations in the specified folder.

  - [yc beta iam workload-identity oidc federation list-access-bindings](federation/list-access-bindings.md) — Lists access bindings for the specified OIDC workload identity federation.

  - [yc beta iam workload-identity oidc federation set-access-bindings](federation/set-access-bindings.md) — Sets access bindings for the specified OIDC workload identity federation.

  - [yc beta iam workload-identity oidc federation update](federation/update.md) — Updates the specified OIDC workload identity federation.

  - [yc beta iam workload-identity oidc federation update-access-bindings](federation/update-access-bindings.md) — Updates access bindings for the specified OIDC workload identity federation.

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