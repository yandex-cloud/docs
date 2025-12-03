---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dataproc/cli-ref-beta/subcluster/index.md
---

# yc beta dataproc subcluster

A set of methods for managing Yandex Data Processing subclusters.

#### Command Usage

Syntax: 

`yc beta dataproc subcluster <command>`

#### Command Tree

- [yc beta dataproc subcluster create](create.md) — Creates a subcluster in the specified cluster.
- [yc beta dataproc subcluster delete](delete.md) — Deletes the specified subcluster.
- [yc beta dataproc subcluster get](get.md) — Returns the specified subcluster.
- [yc beta dataproc subcluster list](list.md) — Retrieves a list of subclusters in the specified cluster.
- [yc beta dataproc subcluster update](update.md) — Updates the specified subcluster.

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
