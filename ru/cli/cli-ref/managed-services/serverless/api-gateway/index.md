---
sourcePath: ru/_cli-ref/cli-ref/managed-services/serverless/api-gateway/index.md
---
# yc serverless api-gateway

Manage API Gateways

#### Command Usage

Syntax: 

`yc serverless api-gateway <command>`

Aliases: 

- `gateway`
- `api-gw`
- `gw`

#### Command Tree

- [yc serverless api-gateway get](get.md) — Get API Gateway
- [yc serverless api-gateway list](list.md) — List API Gateways
- [yc serverless api-gateway get-spec](get-spec.md) — Get API Gateway openapi specification
- [yc serverless api-gateway create](create.md) — Create API Gateway
- [yc serverless api-gateway update](update.md) — Update API Gateway
- [yc serverless api-gateway delete](delete.md) — Delete API Gateway
- [yc serverless api-gateway list-operations](list-operations.md) — List API Gateway operations
- [yc serverless api-gateway list-access-bindings](list-access-bindings.md) — List API Gateway access bindings
- [yc serverless api-gateway set-access-bindings](set-access-bindings.md) — Set access bindings for the specified API Gateway and delete all existing access bindings if there were any
- [yc serverless api-gateway add-access-binding](add-access-binding.md) — Add access binding for the specified API Gateway
- [yc serverless api-gateway remove-access-binding](remove-access-binding.md) — Remove access binding for the specified API Gateway
- [yc serverless api-gateway add-domain](add-domain.md) — Attach domain to the specified API Gateway
- [yc serverless api-gateway remove-domain](remove-domain.md) — Detach domain from the specified API Gateway

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
