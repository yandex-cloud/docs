---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/host-group/index.md
---

# yc beta compute host-group

A set of methods for managing groups of dedicated hosts.

#### Command Usage

Syntax: 

`yc beta compute host-group <command>`

#### Command Tree

- [yc beta compute host-group create](create.md) — Creates a host group in the specified folder.
- [yc beta compute host-group delete](delete.md) — Deletes the specified host group.
- [yc beta compute host-group get](get.md) — Returns the specified host group.
- [yc beta compute host-group list](list.md) — Retrieves the list of host groups in the specified folder.
- [yc beta compute host-group list-access-bindings](list-access-bindings.md) — Lists access bindings for the host group.
- [yc beta compute host-group list-hosts](list-hosts.md) — Lists hosts that belongs to the specified host group.
- [yc beta compute host-group list-instances](list-instances.md) — Lists instances that belongs to the specified host group.
- [yc beta compute host-group list-operations](list-operations.md) — Lists operations for the specified host group.
- [yc beta compute host-group set-access-bindings](set-access-bindings.md) — Sets access bindings for the host group.
- [yc beta compute host-group update](update.md) — Updates the specified host group.
- [yc beta compute host-group update-access-bindings](update-access-bindings.md) — Updates access bindings for the host group.
- [yc beta compute host-group update-host](update-host.md) — Update host

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
