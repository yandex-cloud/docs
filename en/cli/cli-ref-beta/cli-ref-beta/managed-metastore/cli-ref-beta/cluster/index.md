---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-metastore/cli-ref-beta/cluster/index.md
---

# yc beta managed-metastore cluster

A set of methods for managing Metastore Cluster resources.

#### Command Usage

Syntax: 

`yc beta managed-metastore cluster <command>`

#### Command Tree

- [yc beta managed-metastore cluster create](create.md) — Creates a Metastore Cluster.
- [yc beta managed-metastore cluster delete](delete.md) — Deletes the specified Metastore Cluster.
- [yc beta managed-metastore cluster export-data](export-data.md) — Exports data from the specified Metastore Cluster.
- [yc beta managed-metastore cluster get](get.md) — Returns the specified Metastore Cluster.
- [yc beta managed-metastore cluster import-data](import-data.md) — Imports data to the specified Metastore Cluster.
- [yc beta managed-metastore cluster list](list.md) — Retrieves a list of Metastore Clusters.
- [yc beta managed-metastore cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified Metastore cluster.
- [yc beta managed-metastore cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified Hive Metastore Cluster.
- [yc beta managed-metastore cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified Metastore cluster.
- [yc beta managed-metastore cluster start](start.md) — Starts the specified Metastore Cluster.
- [yc beta managed-metastore cluster stop](stop.md) — Stops the specified Metastore Cluster.
- [yc beta managed-metastore cluster update](update.md) — Updates the configuration of the specified Metastore Cluster.
- [yc beta managed-metastore cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Metastore cluster.

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
