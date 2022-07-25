# yc application-load-balancer target-group

Manage application load balancer target groups

#### Command Usage

Syntax: 

`yc application-load-balancer target-group <command>`

Aliases: 

- `tg`

#### Command Tree

- [yc application-load-balancer target-group get](get.md) — Show information about the specified target group
- [yc application-load-balancer target-group list](list.md) — List target groups
- [yc application-load-balancer target-group create](create.md) — Create a target group
- [yc application-load-balancer target-group update](update.md) — Update the specified target group
- [yc application-load-balancer target-group delete](delete.md) — Delete the specified application target group
- [yc application-load-balancer target-group add-targets](add-targets.md) — Add targets to the specified target group
- [yc application-load-balancer target-group remove-targets](remove-targets.md) — Remove targets from the specified target group

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
