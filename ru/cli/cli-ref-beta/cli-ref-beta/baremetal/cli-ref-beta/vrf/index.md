---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/vrf/index.md
---

# yc beta baremetal vrf

A set of methods for managing VRF resources.

#### Command Usage

Syntax: 

`yc beta baremetal vrf <command>`

#### Command Tree

- [yc beta baremetal vrf create](create.md) — Creates a VRF in the specified folder.
- [yc beta baremetal vrf delete](delete.md) — Deletes the specified VRF resource.
- [yc beta baremetal vrf get](get.md) — Returns the specific VRF resource.
- [yc beta baremetal vrf list](list.md) — Retrieves the list of VRF resources in the specified folder.
- [yc beta baremetal vrf list-operations](list-operations.md) — Lists operations for the specified VRF.
- [yc beta baremetal vrf update](update.md) — Updates the specified VRF resource.

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
