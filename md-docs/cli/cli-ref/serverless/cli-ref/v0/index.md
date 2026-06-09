# yc serverless v0

Manage Serverless resources.

#### Command Usage

Syntax:

`yc serverless v0 <group>`

#### Command Tree

- [yc serverless v0 api-gateway](api-gateway/index.md) — Manage API Gateways

  - [yc serverless v0 api-gateway add-access-binding](api-gateway/add-access-binding.md) — Add access binding for the specified API Gateway

  - [yc serverless v0 api-gateway add-domain](api-gateway/add-domain.md) — Attach domain to the specified API Gateway

  - [yc serverless v0 api-gateway create](api-gateway/create.md) — Create API Gateway

  - [yc serverless v0 api-gateway delete](api-gateway/delete.md) — Delete API Gateway

  - [yc serverless v0 api-gateway get](api-gateway/get.md) — Get API Gateway

  - [yc serverless v0 api-gateway get-spec](api-gateway/get-spec.md) — Get API Gateway openapi specification

  - [yc serverless v0 api-gateway list](api-gateway/list.md) — List API Gateways

  - [yc serverless v0 api-gateway list-access-bindings](api-gateway/list-access-bindings.md) — List API Gateway access bindings

  - [yc serverless v0 api-gateway list-operations](api-gateway/list-operations.md) — List API Gateway operations

  - [yc serverless v0 api-gateway release-canary](api-gateway/release-canary.md) — Set gateway specification variables to canary values and delete canary settings

  - [yc serverless v0 api-gateway remove-access-binding](api-gateway/remove-access-binding.md) — Remove access binding for the specified API Gateway

  - [yc serverless v0 api-gateway remove-domain](api-gateway/remove-domain.md) — Detach domain from the specified API Gateway

  - [yc serverless v0 api-gateway resume](api-gateway/resume.md) — Resume API Gateway

  - [yc serverless v0 api-gateway rollback-canary](api-gateway/rollback-canary.md) — Suspend sending requests to canary release(set canary weight to zero)

  - [yc serverless v0 api-gateway set-access-bindings](api-gateway/set-access-bindings.md) — Set access bindings for the specified API Gateway and delete all existing access bindings if there were any

  - [yc serverless v0 api-gateway stop](api-gateway/stop.md) — Stop API Gateway

  - [yc serverless v0 api-gateway update](api-gateway/update.md) — Update API Gateway

- [yc serverless v0 container](container/index.md) — Manage containers

  - [yc serverless v0 container add-access-binding](container/add-access-binding.md) — Add access binding for the specified container

  - [yc serverless v0 container add-labels](container/add-labels.md) — Add labels to specified container

  - [yc serverless v0 container allow-unauthenticated-invoke](container/allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified container

  - [yc serverless v0 container create](container/create.md) — Create a container

  - [yc serverless v0 container delete](container/delete.md) — Delete the specified container

  - [yc serverless v0 container deny-unauthenticated-invoke](container/deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified container

  - [yc serverless v0 container get](container/get.md) — Show information about the specified container

  - [yc serverless v0 container list](container/list.md) — List containers

  - [yc serverless v0 container list-access-bindings](container/list-access-bindings.md) — List access bindings for the specified container

  - [yc serverless v0 container list-operations](container/list-operations.md) — Show operations for the specified container

  - [yc serverless v0 container remove-access-binding](container/remove-access-binding.md) — Remove access binding for the specified container

  - [yc serverless v0 container remove-labels](container/remove-labels.md) — Remove labels from specified container

  - [yc serverless v0 container rollback](container/rollback.md) — Rollback the specified container to the specified revision

  - [yc serverless v0 container set-access-bindings](container/set-access-bindings.md) — Set access bindings for the specified container and delete all existing access bindings if there were any

  - [yc serverless v0 container update](container/update.md) — Update the specified container

- [yc serverless v0 eventrouter](eventrouter/index.md) — Manage eventrouters

  - [yc serverless v0 eventrouter put-event](eventrouter/put-event.md) — Send event

  - [yc serverless v0 eventrouter send-event](eventrouter/send-event.md) — Send event

- [yc serverless v0 function](function/index.md) — Manage functions

  - [yc serverless v0 function add-access-binding](function/add-access-binding.md) — Add access binding for the specified function

  - [yc serverless v0 function add-labels](function/add-labels.md) — Add labels to specified function

  - [yc serverless v0 function allow-unauthenticated-invoke](function/allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified function

  - [yc serverless v0 function create](function/create.md) — Create a function

  - [yc serverless v0 function delete](function/delete.md) — Delete the specified function

  - [yc serverless v0 function deny-unauthenticated-invoke](function/deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified function

  - [yc serverless v0 function get](function/get.md) — Show information about the specified function

  - [yc serverless v0 function invoke](function/invoke.md) — Invoke the specified function

  - [yc serverless v0 function list](function/list.md) — List functions

  - [yc serverless v0 function list-access-bindings](function/list-access-bindings.md) — List access bindings for the specified function

  - [yc serverless v0 function list-operations](function/list-operations.md) — Show operations for the specified function

  - [yc serverless v0 function list-scaling-policies](function/list-scaling-policies.md) — List existing scaling policies for specified function

  - [yc serverless v0 function logs](function/logs.md) — Show logs for the specified function

  - [yc serverless v0 function remove-access-binding](function/remove-access-binding.md) — Remove access binding for the specified function

  - [yc serverless v0 function remove-labels](function/remove-labels.md) — Remove labels from specified function

  - [yc serverless v0 function remove-scaling-policy](function/remove-scaling-policy.md) — Remove scaling policy for specified function and tag

  - [yc serverless v0 function set-access-bindings](function/set-access-bindings.md) — Set access bindings for the specified function and delete all existing access bindings if there were any

  - [yc serverless v0 function set-scaling-policy](function/set-scaling-policy.md) — Set scaling policy for specified function and tag

  - [yc serverless v0 function tag-history](function/tag-history.md) — Show history of the tag for the specified function

  - [yc serverless v0 function update](function/update.md) — Update the specified function

- [yc serverless v0 mcp-gateway](mcp-gateway/index.md) — Manage MCP Gateways

  - [yc serverless v0 mcp-gateway add-access-binding](mcp-gateway/add-access-binding.md) — Add access binding for the specified MCP Gateway

  - [yc serverless v0 mcp-gateway allow-unauthenticated-invoke](mcp-gateway/allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified MCP Gateway

  - [yc serverless v0 mcp-gateway create](mcp-gateway/create.md) — Create MCP Gateway

  - [yc serverless v0 mcp-gateway delete](mcp-gateway/delete.md) — Delete MCP Gateway

  - [yc serverless v0 mcp-gateway deny-unauthenticated-invoke](mcp-gateway/deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified MCP Gateway

  - [yc serverless v0 mcp-gateway get](mcp-gateway/get.md) — Get MCP Gateway

  - [yc serverless v0 mcp-gateway list](mcp-gateway/list.md) — List MCP Gateways

  - [yc serverless v0 mcp-gateway list-access-bindings](mcp-gateway/list-access-bindings.md) — List access bindings for the specified MCP Gateway

  - [yc serverless v0 mcp-gateway list-operations](mcp-gateway/list-operations.md) — List MCP Gateway operations

  - [yc serverless v0 mcp-gateway remove-access-binding](mcp-gateway/remove-access-binding.md) — Remove access binding for the specified MCP Gateway

  - [yc serverless v0 mcp-gateway set-access-bindings](mcp-gateway/set-access-bindings.md) — Set access bindings for the specified MCP Gateway and delete all existing access bindings if there were any

  - [yc serverless v0 mcp-gateway update](mcp-gateway/update.md) — Update MCP Gateway

- [yc serverless v0 mdbproxy](mdbproxy/index.md) — Manage proxies

  - [yc serverless v0 mdbproxy add-labels](mdbproxy/add-labels.md) — Add labels to specified proxy

  - [yc serverless v0 mdbproxy delete](mdbproxy/delete.md) — Delete the specified proxy

  - [yc serverless v0 mdbproxy get](mdbproxy/get.md) — Show information about the specified proxy

  - [yc serverless v0 mdbproxy list](mdbproxy/list.md) — List proxies

  - [yc serverless v0 mdbproxy list-operations](mdbproxy/list-operations.md) — Show history of the tag for the specified proxy

  - [yc serverless v0 mdbproxy remove-labels](mdbproxy/remove-labels.md) — Remove labels from specified proxy

- [yc serverless v0 network](network/index.md) — Manage networks used in serverless resources

  - [yc serverless v0 network get-used](network/get-used.md) — Show information about the specified network used in serverless resources

  - [yc serverless v0 network list-connections](network/list-connections.md) — List serverless resources connected to any network from specified scope (network, folder or cloud)

  - [yc serverless v0 network list-used](network/list-used.md) — List networks used in serverless resources in specified scope

  - [yc serverless v0 network trigger-used-cleanup](network/trigger-used-cleanup.md) — Force obsolete used network to start cleanup process as soon as possible

- [yc serverless v0 trigger](trigger/index.md) — Manage triggers

  - [yc serverless v0 trigger add-labels](trigger/add-labels.md) — Add labels to specified trigger

  - [yc serverless v0 trigger delete](trigger/delete.md) — Delete the specified trigger

  - [yc serverless v0 trigger get](trigger/get.md) — Show information about the specified trigger

  - [yc serverless v0 trigger list](trigger/list.md) — List triggers

  - [yc serverless v0 trigger list-operations](trigger/list-operations.md) — Show history of the tag for the specified trigger

  - [yc serverless v0 trigger pause](trigger/pause.md) — Pause the specified trigger

  - [yc serverless v0 trigger remove-labels](trigger/remove-labels.md) — Remove labels from specified trigger

  - [yc serverless v0 trigger resume](trigger/resume.md) — Resume the specified trigger

- [yc serverless v0 workflow](workflow/index.md) — Manage workflows

  - [yc serverless v0 workflow add-access-binding](workflow/add-access-binding.md) — Add access binding for the specified Workflow

  - [yc serverless v0 workflow allow-unauthenticated-execution](workflow/allow-unauthenticated-execution.md) — Allow unauthenticated execution for the specified Workflow

  - [yc serverless v0 workflow create](workflow/create.md) — Create Workflow

  - [yc serverless v0 workflow delete](workflow/delete.md) — Delete Workflow

  - [yc serverless v0 workflow deny-unauthenticated-execution](workflow/deny-unauthenticated-execution.md) — Deny unauthenticated execution for the specified Workflow

  - [yc serverless v0 workflow get](workflow/get.md) — Get Workflow

  - [yc serverless v0 workflow list](workflow/list.md) — List Workflows

  - [yc serverless v0 workflow list-access-bindings](workflow/list-access-bindings.md) — List access bindings for the specified Workflow

  - [yc serverless v0 workflow list-operations](workflow/list-operations.md) — List Workflow operations

  - [yc serverless v0 workflow remove-access-binding](workflow/remove-access-binding.md) — Remove access binding for the specified Workflow

  - [yc serverless v0 workflow set-access-bindings](workflow/set-access-bindings.md) — Set access bindings for the specified Workflow and delete all existing access bindings if there were any

  - [yc serverless v0 workflow update](workflow/update.md) — Update Workflow

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#