---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dataproc/cli-ref-beta/cluster/index.md
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
- [yc beta dataproc cluster list-hosts](list-hosts.md) — Retrieves the list of hosts in the specified cluster.
- [yc beta dataproc cluster list-operations](list-operations.md) — Lists operations for the specified cluster.
- [yc beta dataproc cluster list-ui-links](list-ui-links.md) — Retrieves a list of links to web interfaces being proxied by Yandex Data Processing UI Proxy.
- [yc beta dataproc cluster start](start.md) — Starts the specified cluster.
- [yc beta dataproc cluster stop](stop.md) — Stops the specified cluster.
- [yc beta dataproc cluster update](update.md) — Updates the configuration of the specified cluster.

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
