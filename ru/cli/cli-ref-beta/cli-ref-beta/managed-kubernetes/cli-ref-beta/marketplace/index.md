---
editable: false
noIndex: true
---

# yc beta managed-kubernetes marketplace



#### Command Usage

Syntax:

`yc beta managed-kubernetes marketplace <group>`

#### Command Tree

- [yc beta managed-kubernetes marketplace helm-release](helm-release/index.md) — A set of methods for managing Helm release.

  - [yc beta managed-kubernetes marketplace helm-release get](helm-release/get.md) — Returns the specified Helm release.

  - [yc beta managed-kubernetes marketplace helm-release install](helm-release/install.md) — Installs helm release into specified Kubernetes Cluster.

  - [yc beta managed-kubernetes marketplace helm-release list](helm-release/list.md) — Retrieves the list of Helm releases in the specified Kubernetes Cluster.

  - [yc beta managed-kubernetes marketplace helm-release uninstall](helm-release/uninstall.md) — Uninstalls helm release.

  - [yc beta managed-kubernetes marketplace helm-release update](helm-release/update.md) — Updates helm release.

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