---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/vrf/index.md
---

# yc baremetal vrf

Manage vrf

#### Command Usage

Syntax: 

`yc baremetal vrf <command>`

#### Command Tree

- [yc baremetal vrf add-labels](add-labels.md) — Add labels to specified vrf
- [yc baremetal vrf create](create.md) — Create a vrf
- [yc baremetal vrf delete](delete.md) — Delete the specified vrf
- [yc baremetal vrf get](get.md) — Show information about the specified vrf
- [yc baremetal vrf list](list.md) — List vrfs
- [yc baremetal vrf list-operations](list-operations.md) — List operations for the specified vrf
- [yc baremetal vrf remove-labels](remove-labels.md) — Remove labels from specified vrf
- [yc baremetal vrf update](update.md) — Update the specified vrf

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
