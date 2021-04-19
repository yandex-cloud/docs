# yc serverless api-gateway

[PREVIEW] Manage api-gateways

#### Command Usage

Syntax: 

`yc serverless api-gateway <command>`

#### Command Tree

- [yc serverless api-gateway get](get.md) — Get api-gateway
- [yc serverless api-gateway list](list.md) — List api-gateways
- [yc serverless api-gateway get-spec](get-spec.md) — Get api-gateway openapi specification
- [yc serverless api-gateway create](create.md) — Create api-gateway
- [yc serverless api-gateway update](update.md) — Update api-gateway
- [yc serverless api-gateway delete](delete.md) — Delete api-gateway
- [yc serverless api-gateway list-operations](list-operations.md) — List api-gateway operations
- [yc serverless api-gateway list-access-bindings](list-access-bindings.md) — List api-gateway access bindings
- [yc serverless api-gateway set-access-bindings](set-access-bindings.md) — Set access bindings for the specified api-gateway and delete all existing access bindings if there were any
- [yc serverless api-gateway add-access-binding](add-access-binding.md) — Add access binding for the specified api-gateway
- [yc serverless api-gateway remove-access-binding](remove-access-binding.md) — Remove access binding for the specified api-gateway

#### Flags

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
