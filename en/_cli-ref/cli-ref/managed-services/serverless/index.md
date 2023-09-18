---
editable: false
---

# yc serverless

Manage Serverless resources.

#### Command Usage

Syntax: 

`yc serverless <group>`

Aliases: 

- `sls`

#### Command Tree

- [yc serverless function](function/index.md) — Manage functions
	- [yc serverless function get](function/get.md) — Show information about the specified function
	- [yc serverless function list](function/list.md) — List functions
	- [yc serverless function create](function/create.md) — Create a function
	- [yc serverless function update](function/update.md) — Update the specified function
	- [yc serverless function add-labels](function/add-labels.md) — Add labels to specified function
	- [yc serverless function remove-labels](function/remove-labels.md) — Remove labels from specified function
	- [yc serverless function delete](function/delete.md) — Delete the specified function
	- [yc serverless function tag-history](function/tag-history.md) — Show history of the tag for the specified function
	- [yc serverless function list-operations](function/list-operations.md) — Show operations for the specified function
	- [yc serverless function logs](function/logs.md) — Show logs for the specified function
	- [yc serverless function invoke](function/invoke.md) — Invoke the specified function
	- [yc serverless function list-access-bindings](function/list-access-bindings.md) — List access bindings for the specified function
	- [yc serverless function set-access-bindings](function/set-access-bindings.md) — Set access bindings for the specified function and delete all existing access bindings if there were any
	- [yc serverless function add-access-binding](function/add-access-binding.md) — Add access binding for the specified function
	- [yc serverless function remove-access-binding](function/remove-access-binding.md) — Remove access binding for the specified function
	- [yc serverless function allow-unauthenticated-invoke](function/allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified function
	- [yc serverless function deny-unauthenticated-invoke](function/deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified function
	- [yc serverless function list-scaling-policies](function/list-scaling-policies.md) — List existing scaling policies for specified function
	- [yc serverless function set-scaling-policy](function/set-scaling-policy.md) — Set scaling policy for specified function and tag
	- [yc serverless function remove-scaling-policy](function/remove-scaling-policy.md) — Remove scaling policy for specified function and tag
- [yc serverless trigger](trigger/index.md) — Manage triggers
	- [yc serverless trigger get](trigger/get.md) — Show information about the specified trigger
	- [yc serverless trigger list](trigger/list.md) — List triggers
	- [yc serverless trigger add-labels](trigger/add-labels.md) — Add labels to specified trigger
	- [yc serverless trigger remove-labels](trigger/remove-labels.md) — Remove labels from specified trigger
	- [yc serverless trigger delete](trigger/delete.md) — Delete the specified trigger
	- [yc serverless trigger pause](trigger/pause.md) — Pause the specified trigger
	- [yc serverless trigger resume](trigger/resume.md) — Resume the specified trigger
	- [yc serverless trigger list-operations](trigger/list-operations.md) — Show history of the tag for the specified trigger
- [yc serverless api-gateway](api-gateway/index.md) — Manage API Gateways
	- [yc serverless api-gateway get](api-gateway/get.md) — Get API Gateway
	- [yc serverless api-gateway list](api-gateway/list.md) — List API Gateways
	- [yc serverless api-gateway get-spec](api-gateway/get-spec.md) — Get API Gateway openapi specification
	- [yc serverless api-gateway create](api-gateway/create.md) — Create API Gateway
	- [yc serverless api-gateway update](api-gateway/update.md) — Update API Gateway
	- [yc serverless api-gateway delete](api-gateway/delete.md) — Delete API Gateway
	- [yc serverless api-gateway list-operations](api-gateway/list-operations.md) — List API Gateway operations
	- [yc serverless api-gateway list-access-bindings](api-gateway/list-access-bindings.md) — List API Gateway access bindings
	- [yc serverless api-gateway set-access-bindings](api-gateway/set-access-bindings.md) — Set access bindings for the specified API Gateway and delete all existing access bindings if there were any
	- [yc serverless api-gateway add-access-binding](api-gateway/add-access-binding.md) — Add access binding for the specified API Gateway
	- [yc serverless api-gateway remove-access-binding](api-gateway/remove-access-binding.md) — Remove access binding for the specified API Gateway
	- [yc serverless api-gateway add-domain](api-gateway/add-domain.md) — Attach domain to the specified API Gateway
	- [yc serverless api-gateway remove-domain](api-gateway/remove-domain.md) — Detach domain from the specified API Gateway
	- [yc serverless api-gateway release-canary](api-gateway/release-canary.md) — Set gateway specification variables to canary values and delete canary settings
	- [yc serverless api-gateway rollback-canary](api-gateway/rollback-canary.md) — Suspend sending requests to canary release(set canary weight to zero)
- [yc serverless container](container/index.md) — Manage containers
	- [yc serverless container get](container/get.md) — Show information about the specified container
	- [yc serverless container list](container/list.md) — List containers
	- [yc serverless container create](container/create.md) — Create a container
	- [yc serverless container update](container/update.md) — Update the specified container
	- [yc serverless container rollback](container/rollback.md) — Rollback the specified container to the specified revision
	- [yc serverless container add-labels](container/add-labels.md) — Add labels to specified container
	- [yc serverless container remove-labels](container/remove-labels.md) — Remove labels from specified container
	- [yc serverless container delete](container/delete.md) — Delete the specified container
	- [yc serverless container list-operations](container/list-operations.md) — Show operations for the specified container
	- [yc serverless container list-access-bindings](container/list-access-bindings.md) — List access bindings for the specified container
	- [yc serverless container set-access-bindings](container/set-access-bindings.md) — Set access bindings for the specified container and delete all existing access bindings if there were any
	- [yc serverless container add-access-binding](container/add-access-binding.md) — Add access binding for the specified container
	- [yc serverless container remove-access-binding](container/remove-access-binding.md) — Remove access binding for the specified container
	- [yc serverless container allow-unauthenticated-invoke](container/allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified container
	- [yc serverless container deny-unauthenticated-invoke](container/deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified container
- [yc serverless mdbproxy](mdbproxy/index.md) — Manage proxies
	- [yc serverless mdbproxy get](mdbproxy/get.md) — Show information about the specified proxy
	- [yc serverless mdbproxy list](mdbproxy/list.md) — List proxies
	- [yc serverless mdbproxy add-labels](mdbproxy/add-labels.md) — Add labels to specified proxy
	- [yc serverless mdbproxy remove-labels](mdbproxy/remove-labels.md) — Remove labels from specified proxy
	- [yc serverless mdbproxy delete](mdbproxy/delete.md) — Delete the specified proxy
	- [yc serverless mdbproxy list-operations](mdbproxy/list-operations.md) — Show history of the tag for the specified proxy

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
