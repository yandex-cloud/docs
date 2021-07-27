---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# yc application-load-balancer virtual-host

Manage http router virtual host

#### Command Usage

Syntax: 

`yc application-load-balancer virtual-host <command>`

Aliases: 

- `vh`

#### Command Tree

- [yc application-load-balancer virtual-host get](get.md) — Show information about the specified virtual host
- [yc application-load-balancer virtual-host list](list.md) — List http router virtual hosts
- [yc application-load-balancer virtual-host create](create.md) — Create an virtual host for the http router
- [yc application-load-balancer virtual-host update](update.md) — Update the specified virtual host
- [yc application-load-balancer virtual-host delete](delete.md) — Delete the specified virtual host of the http router
- [yc application-load-balancer virtual-host append-http-route](append-http-route.md) — Appends http route to the specified virtual host of the http router
- [yc application-load-balancer virtual-host prepend-http-route](prepend-http-route.md) — Prepends http route to the specified virtual host of the http router
- [yc application-load-balancer virtual-host remove-http-route](remove-http-route.md) — Removes http route from the specified virtual host of the http router
- [yc application-load-balancer virtual-host insert-http-route](insert-http-route.md) — Removes http route from the specified virtual host of the http router

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
