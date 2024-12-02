---
editable: false
---

# yc organization-manager federation group-mapping

Manage group mappings for federation

#### Command Usage

Syntax: 

`yc organization-manager federation group-mapping <command>`

Aliases: 

- `group-mappings`

#### Command Tree

- [yc organization-manager federation group-mapping add-mapping-items](add-mapping-items.md) — Add group mapping items to the specified federation
- [yc organization-manager federation group-mapping create](create.md) — Create a group mapping for specified federation
- [yc organization-manager federation group-mapping delete](delete.md) — Delete a group mapping for specified federation
- [yc organization-manager federation group-mapping get](get.md) — Show group mapping information about the specified federation
- [yc organization-manager federation group-mapping list-mapping-items](list-mapping-items.md) — List group mapping items for specified federation
- [yc organization-manager federation group-mapping remove-mapping-items](remove-mapping-items.md) — Remove group mapping items from the specified federation
- [yc organization-manager federation group-mapping update](update.md) — Update a group mapping for specified federation

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
