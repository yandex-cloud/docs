---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/eventrouter/index.md
---

# yc serverless eventrouter

Manage eventrouters

#### Command Usage

Syntax: 

`yc serverless eventrouter <group|command>`

Aliases: 

- `er`

#### Command Tree

- [yc serverless eventrouter put-event](put-event.md) — Send event
- [yc serverless eventrouter bus](bus/index.md) — Manage buses
	- [yc serverless eventrouter bus add-access-binding](bus/add-access-binding.md) — Add access binding for the specified bus
	- [yc serverless eventrouter bus create](bus/create.md) — Create a bus
	- [yc serverless eventrouter bus delete](bus/delete.md) — Delete the specified bus(es)
	- [yc serverless eventrouter bus get](bus/get.md) — Show information about the specified bus(es)
	- [yc serverless eventrouter bus list](bus/list.md) — List buses
	- [yc serverless eventrouter bus list-access-bindings](bus/list-access-bindings.md) — List access bindings for the specified function
	- [yc serverless eventrouter bus list-operations](bus/list-operations.md) — Show operations for the specified bus
	- [yc serverless eventrouter bus remove-access-binding](bus/remove-access-binding.md) — Remove access binding for the specified bus
	- [yc serverless eventrouter bus set-access-bindings](bus/set-access-bindings.md) — Set access bindings for the specified bus and delete all existing access bindings if there were any
	- [yc serverless eventrouter bus update](bus/update.md) — Update the specified bus
- [yc serverless eventrouter connector](connector/index.md) — Manage connectors
	- [yc serverless eventrouter connector add-access-binding](connector/add-access-binding.md) — Add access binding for the specified connector
	- [yc serverless eventrouter connector delete](connector/delete.md) — Delete the specified connector(s)
	- [yc serverless eventrouter connector get](connector/get.md) — Show information about the specified connector(s)
	- [yc serverless eventrouter connector list](connector/list.md) — List connectors
	- [yc serverless eventrouter connector list-access-bindings](connector/list-access-bindings.md) — List access bindings for the specified function
	- [yc serverless eventrouter connector list-operations](connector/list-operations.md) — Show operations for the specified connector
	- [yc serverless eventrouter connector remove-access-binding](connector/remove-access-binding.md) — Remove access binding for the specified connector
	- [yc serverless eventrouter connector set-access-bindings](connector/set-access-bindings.md) — Set access bindings for the specified connector and delete all existing access bindings if there were any
	- [yc serverless eventrouter connector start](connector/start.md) — Start the specified connector
	- [yc serverless eventrouter connector stop](connector/stop.md) — Stop the specified connector
	- [yc serverless eventrouter connector update](connector/update.md) — Update the specified connector
- [yc serverless eventrouter rule](rule/index.md) — Manage rules
	- [yc serverless eventrouter rule add-access-binding](rule/add-access-binding.md) — Add access binding for the specified rule
	- [yc serverless eventrouter rule create](rule/create.md) — Create a rule
	- [yc serverless eventrouter rule delete](rule/delete.md) — Delete the specified rule(es)
	- [yc serverless eventrouter rule disable](rule/disable.md) — Enable the specified rule
	- [yc serverless eventrouter rule enable](rule/enable.md) — Enable the specified rule
	- [yc serverless eventrouter rule get](rule/get.md) — Show information about the specified rule(es)
	- [yc serverless eventrouter rule list](rule/list.md) — List rulees
	- [yc serverless eventrouter rule list-access-bindings](rule/list-access-bindings.md) — List access bindings for the specified function
	- [yc serverless eventrouter rule list-operations](rule/list-operations.md) — Show operations for the specified rule
	- [yc serverless eventrouter rule remove-access-binding](rule/remove-access-binding.md) — Remove access binding for the specified rule
	- [yc serverless eventrouter rule set-access-bindings](rule/set-access-bindings.md) — Set access bindings for the specified rule and delete all existing access bindings if there were any
	- [yc serverless eventrouter rule update](rule/update.md) — Update the specified rule

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
