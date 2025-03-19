---
editable: false
sourcePath: en/_cli-ref/cli-ref/cloudrouter/cli-ref/index.md
---

# yc cloudrouter

[PREVIEW] Manage Yandex Cloud Router resources

#### Command Usage

Syntax: 

`yc cloudrouter <group>`

#### Command Tree

- [yc cloudrouter routing-instance](routing-instance/index.md) — [PREVIEW] Manage routingInstances.
	- [yc cloudrouter routing-instance add-labels](routing-instance/add-labels.md) — Assign labels to a routingInstance.
	- [yc cloudrouter routing-instance add-private-connection](routing-instance/add-private-connection.md) — Add CIC private connection to the routingInstance.
	- [yc cloudrouter routing-instance create](routing-instance/create.md) — Create a routingInstance.
	- [yc cloudrouter routing-instance delete](routing-instance/delete.md) — Delete a routingInstance.
	- [yc cloudrouter routing-instance get](routing-instance/get.md) — Get information about a routingInstance.
	- [yc cloudrouter routing-instance list](routing-instance/list.md) — List routingInstances in a folder.
	- [yc cloudrouter routing-instance list-operations](routing-instance/list-operations.md) — List operations for a routingInstance.
	- [yc cloudrouter routing-instance remove-labels](routing-instance/remove-labels.md) — Remove labels from a routingInstance.
	- [yc cloudrouter routing-instance remove-prefixes](routing-instance/remove-prefixes.md) — Remove announced VPC network prefixes from the routingInstance.
	- [yc cloudrouter routing-instance remove-private-connection](routing-instance/remove-private-connection.md) — Remove CIC private connection from the routingInstance.
	- [yc cloudrouter routing-instance update](routing-instance/update.md) — Modify configuration or attributes of a routingInstance.
	- [yc cloudrouter routing-instance upsert-prefixes](routing-instance/upsert-prefixes.md) — Upsert announced VPC network prefixes to the routingInstance.

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
