---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/reserved-instance-pool/index.md
---

# yc beta compute reserved-instance-pool

A set of methods for managing reserved instance pool resources.

#### Command Usage

Syntax: 

`yc beta compute reserved-instance-pool <command>`

#### Command Tree

- [yc beta compute reserved-instance-pool create](create.md) — Creates an reserved instance pool in the specified folder.
- [yc beta compute reserved-instance-pool delete](delete.md) — Deletes the specified reserved instance pool.
- [yc beta compute reserved-instance-pool get](get.md) — Returns the specified reserved instance pool resource.
- [yc beta compute reserved-instance-pool list](list.md) — Retrieves the list of reserved instance pool resources in the specified folder.
- [yc beta compute reserved-instance-pool list-instances](list-instances.md) — Retrieves the list of instances, using the specified reserved instance pool.
- [yc beta compute reserved-instance-pool list-operations](list-operations.md) — Lists operations for the specified reserved instance pool.
- [yc beta compute reserved-instance-pool update](update.md) — Updates the specified reserved instance pool.

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
