---
editable: false
---

# yc dataproc cluster

Manage DataProc clusters.

#### Command Usage

Syntax:

`yc dataproc cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc dataproc cluster add-access-binding](add-access-binding.md) — Add access binding for the specified cluster

- [yc dataproc cluster add-labels](add-labels.md) — Assign labels to a cluster.

- [yc dataproc cluster create](create.md) — Create a cluster.

- [yc dataproc cluster delete](delete.md) — Delete a cluster.

- [yc dataproc cluster get](get.md) — Get information about a cluster.

- [yc dataproc cluster list](list.md) — List clusters in a folder.

- [yc dataproc cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified cluster

- [yc dataproc cluster list-hosts](list-hosts.md) — List hosts for a cluster.

- [yc dataproc cluster list-operations](list-operations.md) — List operations for a cluster.

- [yc dataproc cluster list-ui-links](list-ui-links.md) — Show URLs of proxied web user interfaces.

- [yc dataproc cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified cluster

- [yc dataproc cluster remove-labels](remove-labels.md) — Remove labels from a cluster.

- [yc dataproc cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified cluster and delete all existing access bindings if there were any

- [yc dataproc cluster start](start.md) — Start a cluster.

- [yc dataproc cluster stop](stop.md) — Stop a cluster.

- [yc dataproc cluster update](update.md) — Modify attributes of a cluster.

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