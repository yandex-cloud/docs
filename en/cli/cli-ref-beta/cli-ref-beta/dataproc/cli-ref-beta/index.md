---
editable: false
noIndex: true
---

# yc beta dataproc

Manage data processing clusters

#### Command Usage

Syntax:

`yc beta dataproc <group>`

#### Command Tree

- [yc beta dataproc cluster](cluster/index.md) — A set of methods for managing Yandex Data Processing clusters.

  - [yc beta dataproc cluster create](cluster/create.md) — Creates a cluster in the specified folder.

  - [yc beta dataproc cluster delete](cluster/delete.md) — Deletes the specified cluster.

  - [yc beta dataproc cluster get](cluster/get.md) — Returns the specified cluster.

  - [yc beta dataproc cluster list](cluster/list.md) — Retrieves the list of clusters in the specified folder.

  - [yc beta dataproc cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified cluster.

  - [yc beta dataproc cluster list-hosts](cluster/list-hosts.md) — Retrieves the list of hosts in the specified cluster.

  - [yc beta dataproc cluster list-operations](cluster/list-operations.md) — Lists operations for the specified cluster.

  - [yc beta dataproc cluster list-ui-links](cluster/list-ui-links.md) — Retrieves a list of links to web interfaces being proxied by Yandex Data Processing UI Proxy.

  - [yc beta dataproc cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified cluster.

  - [yc beta dataproc cluster start](cluster/start.md) — Starts the specified cluster.

  - [yc beta dataproc cluster stop](cluster/stop.md) — Stops the specified cluster.

  - [yc beta dataproc cluster update](cluster/update.md) — Updates the configuration of the specified cluster.

  - [yc beta dataproc cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified cluster.

- [yc beta dataproc job](job/index.md) — A set of methods for managing Yandex Data Processing jobs.

  - [yc beta dataproc job cancel](job/cancel.md) — Cancels the specified Yandex Data Processing job.

  - [yc beta dataproc job create](job/create.md) — Creates a job for a cluster.

  - [yc beta dataproc job get](job/get.md) — Returns the specified job.

  - [yc beta dataproc job list](job/list.md) — Retrieves a list of jobs for a cluster.

  - [yc beta dataproc job list-log](job/list-log.md) — Returns a log for specified job.

- [yc beta dataproc resource-preset](resource-preset/index.md) — A set of methods for managing ResourcePreset resources.

  - [yc beta dataproc resource-preset get](resource-preset/get.md) — Returns the specified ResourcePreset resource.

  - [yc beta dataproc resource-preset list](resource-preset/list.md) — Retrieves the list of available ResourcePreset resources.

- [yc beta dataproc subcluster](subcluster/index.md) — A set of methods for managing Yandex Data Processing subclusters.

  - [yc beta dataproc subcluster create](subcluster/create.md) — Creates a subcluster in the specified cluster.

  - [yc beta dataproc subcluster delete](subcluster/delete.md) — Deletes the specified subcluster.

  - [yc beta dataproc subcluster get](subcluster/get.md) — Returns the specified subcluster.

  - [yc beta dataproc subcluster list](subcluster/list.md) — Retrieves a list of subclusters in the specified cluster.

  - [yc beta dataproc subcluster update](subcluster/update.md) — Updates the specified subcluster.

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