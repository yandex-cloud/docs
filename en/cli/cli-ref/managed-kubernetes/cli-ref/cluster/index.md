---
editable: false
---

# yc managed-kubernetes cluster

Manage Kubernetes clusters.

#### Command Usage

Syntax:

`yc managed-kubernetes cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-kubernetes cluster add-access-binding](add-access-binding.md) — Add access binding for the specified Kubernetes cluster.

- [yc managed-kubernetes cluster add-labels](add-labels.md) — Add labels to the specified Kubernetes cluster.

- [yc managed-kubernetes cluster create](create.md) — Create a Kubernetes cluster.

- [yc managed-kubernetes cluster delete](delete.md) — Delete a Kubernetes cluster.

- [yc managed-kubernetes cluster get](get.md) — Get information about a Kubernetes cluster.

- [yc managed-kubernetes cluster get-credentials](get-credentials.md) — Create or update kubeconfig for the specified Kubernetes cluster.

- [yc managed-kubernetes cluster list](list.md) — List Kubernetes clusters available in a folder.

- [yc managed-kubernetes cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified Kubernetes cluster.

- [yc managed-kubernetes cluster list-node-groups](list-node-groups.md) — List Kubernetes cluster node groups.

- [yc managed-kubernetes cluster list-nodes](list-nodes.md) — List nodes in all node groups of the specified Kubernetes cluster.

- [yc managed-kubernetes cluster list-operations](list-operations.md) — List operations for the specified Kubernetes cluster.

- [yc managed-kubernetes cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Kubernetes cluster.

- [yc managed-kubernetes cluster remove-labels](remove-labels.md) — Remove labels from the specified Kubernetes cluster.

- [yc managed-kubernetes cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule mandatory maintenance for the specified Kubernetes cluster.

- [yc managed-kubernetes cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Kubernetes cluster and delete all existing access bindings if there were any

- [yc managed-kubernetes cluster start](start.md) — Start a Kubernetes cluster and all its node groups.

- [yc managed-kubernetes cluster stop](stop.md) — Stop a Kubernetes cluster and all its node groups.

- [yc managed-kubernetes cluster update](update.md) — Modify configuration or attributes of a Kubernetes cluster.

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