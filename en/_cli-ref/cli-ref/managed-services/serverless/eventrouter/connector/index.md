---
editable: false
---

# yc serverless eventrouter connector

Manage connectors

#### Command Usage

Syntax: 

`yc serverless eventrouter connector <group|command>`

#### Command Tree

- [yc serverless eventrouter connector get](get.md) — Show information about the specified connector(s)
- [yc serverless eventrouter connector list](list.md) — List connectors
- [yc serverless eventrouter connector update](update.md) — Update the specified connector
- [yc serverless eventrouter connector delete](delete.md) — Delete the specified connector(s)
- [yc serverless eventrouter connector list-operations](list-operations.md) — Show operations for the specified connector
- [yc serverless eventrouter connector list-access-bindings](list-access-bindings.md) — List access bindings for the specified function
- [yc serverless eventrouter connector set-access-bindings](set-access-bindings.md) — Set access bindings for the specified connector and delete all existing access bindings if there were any
- [yc serverless eventrouter connector add-access-binding](add-access-binding.md) — Add access binding for the specified connector
- [yc serverless eventrouter connector remove-access-binding](remove-access-binding.md) — Remove access binding for the specified connector
- [yc serverless eventrouter connector stop](stop.md) — Stop the specified connector
- [yc serverless eventrouter connector start](start.md) — Start the specified connector
- [yc serverless eventrouter connector create](create/index.md) — Create connector
	- [yc serverless eventrouter connector create data-stream](create/data-stream.md) — Create a data stream connector
	- [yc serverless eventrouter connector create message-queue](create/message-queue.md) — Create a message queue connector

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
