---
editable: false
noIndex: true
---

# yc beta iam workload-identity



#### Command Usage

Syntax:

`yc beta iam workload-identity <group>`

#### Command Tree

- [yc beta iam workload-identity federated-credential](federated-credential/index.md) — A set of methods for managing federated credentials.

  - [yc beta iam workload-identity federated-credential create](federated-credential/create.md) — Creates a federated credential for the specified service account.

  - [yc beta iam workload-identity federated-credential delete](federated-credential/delete.md) — Deletes the specified federated credential.

  - [yc beta iam workload-identity federated-credential get](federated-credential/get.md) — Returns the specified federated credential.

  - [yc beta iam workload-identity federated-credential list](federated-credential/list.md) — Retrieves the list of federated credentials for the specified service account.

- [yc beta iam workload-identity oidc](oidc/index.md) — 



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