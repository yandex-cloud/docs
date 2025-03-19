---
editable: false
sourcePath: en/_cli-ref/cli-ref/cloudrouter/cli-ref/routing-instance/index.md
---

# yc cloudrouter routing-instance

[PREVIEW] Manage routingInstances.

#### Command Usage

Syntax: 

`yc cloudrouter routing-instance <command>`

Aliases: 

- `routing-instances`
- `ri`
- `ris`

#### Command Tree

- [yc cloudrouter routing-instance add-labels](add-labels.md) — Assign labels to a routingInstance.
- [yc cloudrouter routing-instance add-private-connection](add-private-connection.md) — Add CIC private connection to the routingInstance.
- [yc cloudrouter routing-instance create](create.md) — Create a routingInstance.
- [yc cloudrouter routing-instance delete](delete.md) — Delete a routingInstance.
- [yc cloudrouter routing-instance get](get.md) — Get information about a routingInstance.
- [yc cloudrouter routing-instance list](list.md) — List routingInstances in a folder.
- [yc cloudrouter routing-instance list-operations](list-operations.md) — List operations for a routingInstance.
- [yc cloudrouter routing-instance remove-labels](remove-labels.md) — Remove labels from a routingInstance.
- [yc cloudrouter routing-instance remove-prefixes](remove-prefixes.md) — Remove announced VPC network prefixes from the routingInstance.
- [yc cloudrouter routing-instance remove-private-connection](remove-private-connection.md) — Remove CIC private connection from the routingInstance.
- [yc cloudrouter routing-instance update](update.md) — Modify configuration or attributes of a routingInstance.
- [yc cloudrouter routing-instance upsert-prefixes](upsert-prefixes.md) — Upsert announced VPC network prefixes to the routingInstance.

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
