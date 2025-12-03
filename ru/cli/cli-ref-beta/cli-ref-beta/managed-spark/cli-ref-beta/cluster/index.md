---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-spark/cli-ref-beta/cluster/index.md
---

# yc beta managed-spark cluster

A set of methods for managing Spark clusters.

#### Command Usage

Syntax: 

`yc beta managed-spark cluster <command>`

#### Command Tree

- [yc beta managed-spark cluster create](create.md) — Creates a Spark cluster.
- [yc beta managed-spark cluster delete](delete.md) — Deletes the specified Spark cluster.
- [yc beta managed-spark cluster get](get.md) — Returns the specified Spark cluster.
- [yc beta managed-spark cluster list](list.md) — Retrieves a list of Spark clusters.
- [yc beta managed-spark cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified Spark cluster.
- [yc beta managed-spark cluster list-operations](list-operations.md) — 
- [yc beta managed-spark cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified Spark cluster.
- [yc beta managed-spark cluster start](start.md) — Start the specified Spark cluster.
- [yc beta managed-spark cluster stop](stop.md) — Stops the specified Spark cluster
- [yc beta managed-spark cluster update](update.md) — Updates configuration of the specified Spark cluster.
- [yc beta managed-spark cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Spark cluster.

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
