---
sourcePath: ru/_cli-ref/cli-ref/managed-services/application-load-balancer/backend-group/index.md
---
# yc application-load-balancer backend-group

Manage application load balancer backend groups

#### Command Usage

Syntax: 

`yc application-load-balancer backend-group <command>`

Aliases: 

- `bg`

#### Command Tree

- [yc application-load-balancer backend-group get](get.md) — Show information about the specified backend group
- [yc application-load-balancer backend-group list](list.md) — List backend groups
- [yc application-load-balancer backend-group create](create.md) — Create an backend group
- [yc application-load-balancer backend-group update](update.md) — Update the specified backend group
- [yc application-load-balancer backend-group delete](delete.md) — Delete the specified backend group
- [yc application-load-balancer backend-group add-http-backend](add-http-backend.md) — Add HTTP backend to the backend group
- [yc application-load-balancer backend-group update-http-backend](update-http-backend.md) — Update HTTP backend to the backend group
- [yc application-load-balancer backend-group delete-http-backend](delete-http-backend.md) — Delete HTTP backend from the backend group
- [yc application-load-balancer backend-group add-grpc-backend](add-grpc-backend.md) — Add gRPC backend to the backend group
- [yc application-load-balancer backend-group update-grpc-backend](update-grpc-backend.md) — Update gRPC backend to the backend group
- [yc application-load-balancer backend-group delete-grpc-backend](delete-grpc-backend.md) — Delete gRPC backend from the backend group
- [yc application-load-balancer backend-group add-stream-backend](add-stream-backend.md) — Add Stream backend to the backend group
- [yc application-load-balancer backend-group update-stream-backend](update-stream-backend.md) — Update Stream backend to the backend group
- [yc application-load-balancer backend-group delete-stream-backend](delete-stream-backend.md) — Delete Stream backend from the backend group

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
