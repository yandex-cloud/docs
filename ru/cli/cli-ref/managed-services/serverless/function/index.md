---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/serverless/function/index.md
---

# yc serverless function

Manage functions

#### Command Usage

Syntax: 

`yc serverless function <group|command>`

Aliases: 

- `fn`

#### Command Tree

- [yc serverless function get](get.md) — Show information about the specified function
- [yc serverless function list](list.md) — List functions
- [yc serverless function create](create.md) — Create a function
- [yc serverless function update](update.md) — Update the specified function
- [yc serverless function add-labels](add-labels.md) — Add labels to specified function
- [yc serverless function remove-labels](remove-labels.md) — Remove labels from specified function
- [yc serverless function delete](delete.md) — Delete the specified function
- [yc serverless function tag-history](tag-history.md) — Show history of the tag for the specified function
- [yc serverless function list-operations](list-operations.md) — Show operations for the specified function
- [yc serverless function logs](logs.md) — Show logs for the specified function
- [yc serverless function invoke](invoke.md) — Invoke the specified function
- [yc serverless function list-access-bindings](list-access-bindings.md) — List access bindings for the specified function
- [yc serverless function set-access-bindings](set-access-bindings.md) — Set access bindings for the specified function and delete all existing access bindings if there were any
- [yc serverless function add-access-binding](add-access-binding.md) — Add access binding for the specified function
- [yc serverless function remove-access-binding](remove-access-binding.md) — Remove access binding for the specified function
- [yc serverless function allow-unauthenticated-invoke](allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified function
- [yc serverless function deny-unauthenticated-invoke](deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified function
- [yc serverless function list-scaling-policies](list-scaling-policies.md) — List existing scaling policies for specified function
- [yc serverless function set-scaling-policy](set-scaling-policy.md) — Set scaling policy for specified function and tag
- [yc serverless function remove-scaling-policy](remove-scaling-policy.md) — Remove scaling policy for specified function and tag
- [yc serverless function version](version/index.md) — Manage function versions
	- [yc serverless function version list](version/list.md) — List function versions
	- [yc serverless function version get](version/get.md) — Show information about the specified function version
	- [yc serverless function version create](version/create.md) — Create new function version
	- [yc serverless function version set-tag](version/set-tag.md) — Set a tag on the specified function version
	- [yc serverless function version remove-tag](version/remove-tag.md) — Remove a tag from the specified function version
	- [yc serverless function version get-by-tag](version/get-by-tag.md) — Get function version by tag
	- [yc serverless function version logs](version/logs.md) — Read function version logs
- [yc serverless function runtime](runtime/index.md) — Inspect function runtimes
	- [yc serverless function runtime list](runtime/list.md) — List runtimes

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
