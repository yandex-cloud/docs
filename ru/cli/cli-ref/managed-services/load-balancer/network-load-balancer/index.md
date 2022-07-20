---
sourcePath: en/_cli-ref/cli-ref/managed-services/load-balancer/network-load-balancer/index.md
---
# yc load-balancer network-load-balancer

Manage network load balancer

#### Command Usage

Syntax: 

`yc load-balancer network-load-balancer <command>`

Aliases: 

- `nlb`

#### Command Tree

- [yc load-balancer network-load-balancer get](get.md) — Show information about the specified load balancer
- [yc load-balancer network-load-balancer list](list.md) — List load balancers
- [yc load-balancer network-load-balancer create](create.md) — Create a network load balancer
- [yc load-balancer network-load-balancer update](update.md) — Update the specified load balancer
- [yc load-balancer network-load-balancer delete](delete.md) — Delete the specified load balancer
- [yc load-balancer network-load-balancer start](start.md) — Starts load balancing and health checking with the specified network load balancer.
- [yc load-balancer network-load-balancer stop](stop.md) — Stops load balancing and health checking with the specified network load balancer.
- [yc load-balancer network-load-balancer attach-target-group](attach-target-group.md) — Attaches a target group to the specified network load balancer.
- [yc load-balancer network-load-balancer detach-target-group](detach-target-group.md) — Detaches the target group from the specified network load balancer.
- [yc load-balancer network-load-balancer target-states](target-states.md) — Show states of target resources in the attached target group
- [yc load-balancer network-load-balancer add-listener](add-listener.md) — Adds a listener to the specified network load balancer.
- [yc load-balancer network-load-balancer remove-listener](remove-listener.md) — Removes the listener from the specified network load balancer.
- [yc load-balancer network-load-balancer list-operations](list-operations.md) — List operations for the specified load balancer

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
