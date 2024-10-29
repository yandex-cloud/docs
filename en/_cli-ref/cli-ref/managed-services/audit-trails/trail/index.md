---
editable: false
---

# yc audit-trails trail

Manage trails

#### Command Usage

Syntax: 

`yc audit-trails trail <command>`

#### Command Tree

- [yc audit-trails trail get](get.md) — Show information about the specified trail
- [yc audit-trails trail list](list.md) — List trails
- [yc audit-trails trail create](create.md) — Create the specified trail
- [yc audit-trails trail update](update.md) — Update the specified trail
- [yc audit-trails trail delete](delete.md) — Delete the specified trail
- [yc audit-trails trail list-operations](list-operations.md) — List operations for the specified trail
- [yc audit-trails trail list-access-bindings](list-access-bindings.md) — List access bindings for the specified trail
- [yc audit-trails trail set-access-bindings](set-access-bindings.md) — Set access bindings for the specified trail and delete all existing access bindings if there were any
- [yc audit-trails trail add-access-binding](add-access-binding.md) — Add access binding for the specified trail
- [yc audit-trails trail remove-access-binding](remove-access-binding.md) — Remove access binding for the specified trail

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
