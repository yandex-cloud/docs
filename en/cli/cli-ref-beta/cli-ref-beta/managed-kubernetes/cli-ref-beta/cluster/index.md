---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kubernetes/cli-ref-beta/cluster/index.md
---

# yc beta managed-kubernetes cluster

A set of methods for managing Kubernetes cluster.

#### Command Usage

Syntax: 

`yc beta managed-kubernetes cluster <command>`

#### Command Tree

- [yc beta managed-kubernetes cluster create](create.md) — Creates a Kubernetes cluster in the specified folder.
- [yc beta managed-kubernetes cluster delete](delete.md) — Deletes the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster get](get.md) — Returns the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster list](list.md) — Retrieves the list of Kubernetes cluster in the specified folder.
- [yc beta managed-kubernetes cluster list-access-bindings](list-access-bindings.md) — Lists cluster's access bindings
- [yc beta managed-kubernetes cluster list-node-groups](list-node-groups.md) — Lists nodegroup for the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster list-nodes](list-nodes.md) — Lists cluster's nodes.
- [yc beta managed-kubernetes cluster list-operations](list-operations.md) — Lists operations for the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules mandatory maintenance for the specified cluster.
- [yc beta managed-kubernetes cluster set-access-bindings](set-access-bindings.md) — Sets cluster's access bindings
- [yc beta managed-kubernetes cluster start](start.md) — Starts the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster stop](stop.md) — Stops the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster update](update.md) — Updates the specified Kubernetes cluster.
- [yc beta managed-kubernetes cluster update-access-bindings](update-access-bindings.md) — Updates cluster's access bindings

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
