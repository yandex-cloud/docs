---
editable: false
noIndex: true
---

# yc beta dataproc cluster

A set of methods for managing Yandex Data Processing clusters.

#### Command Usage

Syntax:

`yc beta dataproc cluster <command>`

#### Command Tree

- [yc beta dataproc cluster create](create.md) — Creates a cluster in the specified folder.

- [yc beta dataproc cluster delete](delete.md) — Deletes the specified cluster.

- [yc beta dataproc cluster get](get.md) — Returns the specified cluster.

- [yc beta dataproc cluster list](list.md) — Retrieves the list of clusters in the specified folder.

- [yc beta dataproc cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified cluster.

- [yc beta dataproc cluster list-hosts](list-hosts.md) — Retrieves the list of hosts in the specified cluster.

- [yc beta dataproc cluster list-operations](list-operations.md) — Lists operations for the specified cluster.

- [yc beta dataproc cluster list-ui-links](list-ui-links.md) — Retrieves a list of links to web interfaces being proxied by Yandex Data Processing UI Proxy.

- [yc beta dataproc cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified cluster.

- [yc beta dataproc cluster start](start.md) — Starts the specified cluster.

- [yc beta dataproc cluster stop](stop.md) — Stops the specified cluster.

- [yc beta dataproc cluster update](update.md) — Updates the configuration of the specified cluster.

- [yc beta dataproc cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified cluster.

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