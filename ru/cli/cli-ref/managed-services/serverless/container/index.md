---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/serverless/container/index.md
---

# yc serverless container

Manage containers

#### Command Usage

Syntax: 

`yc serverless container <group|command>`

Aliases: 

- `containers`

#### Command Tree

- [yc serverless container get](get.md) — Show information about the specified container
- [yc serverless container list](list.md) — List containers
- [yc serverless container create](create.md) — Create a container
- [yc serverless container update](update.md) — Update the specified container
- [yc serverless container rollback](rollback.md) — Rollback the specified container to the specified revision
- [yc serverless container add-labels](add-labels.md) — Add labels to specified container
- [yc serverless container remove-labels](remove-labels.md) — Remove labels from specified container
- [yc serverless container delete](delete.md) — Delete the specified container
- [yc serverless container list-operations](list-operations.md) — Show operations for the specified container
- [yc serverless container list-access-bindings](list-access-bindings.md) — List access bindings for the specified container
- [yc serverless container set-access-bindings](set-access-bindings.md) — Set access bindings for the specified container and delete all existing access bindings if there were any
- [yc serverless container add-access-binding](add-access-binding.md) — Add access binding for the specified container
- [yc serverless container remove-access-binding](remove-access-binding.md) — Remove access binding for the specified container
- [yc serverless container allow-unauthenticated-invoke](allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified container
- [yc serverless container deny-unauthenticated-invoke](deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified container
- [yc serverless container revision](revision/index.md) — Manage container revisions
	- [yc serverless container revision list](revision/list.md) — List container revisions
	- [yc serverless container revision get](revision/get.md) — Show information about the specified container revision
	- [yc serverless container revision deploy](revision/deploy.md) — Deploy new container revision

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
|`-h`,`--help`|Display help for the command.|
