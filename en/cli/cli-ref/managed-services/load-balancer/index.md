---
sourcePath: en/_cli-ref/cli-ref/managed-services/load-balancer/index.md
---
# yc load-balancer

Manage Yandex Load Balancer resources

#### Command Usage

Syntax: 

`yc load-balancer <group>`

Aliases: 

- `balancer`
- `lb`

#### Command Tree

- [yc load-balancer network-load-balancer](network-load-balancer/index.md) — Manage network load balancer
	- [yc load-balancer network-load-balancer get](network-load-balancer/get.md) — Show information about the specified load balancer
	- [yc load-balancer network-load-balancer list](network-load-balancer/list.md) — List load balancers
	- [yc load-balancer network-load-balancer create](network-load-balancer/create.md) — Create a network load balancer
	- [yc load-balancer network-load-balancer update](network-load-balancer/update.md) — Update the specified load balancer
	- [yc load-balancer network-load-balancer delete](network-load-balancer/delete.md) — Delete the specified load balancer
	- [yc load-balancer network-load-balancer start](network-load-balancer/start.md) — Starts load balancing and health checking with the specified network load balancer.
	- [yc load-balancer network-load-balancer stop](network-load-balancer/stop.md) — Stops load balancing and health checking with the specified network load balancer.
	- [yc load-balancer network-load-balancer attach-target-group](network-load-balancer/attach-target-group.md) — Attaches a target group to the specified network load balancer.
	- [yc load-balancer network-load-balancer detach-target-group](network-load-balancer/detach-target-group.md) — Detaches the target group from the specified network load balancer.
	- [yc load-balancer network-load-balancer target-states](network-load-balancer/target-states.md) — Show states of target resources in the attached target group
	- [yc load-balancer network-load-balancer add-listener](network-load-balancer/add-listener.md) — Adds a listener to the specified network load balancer.
	- [yc load-balancer network-load-balancer remove-listener](network-load-balancer/remove-listener.md) — Removes the listener from the specified network load balancer.
	- [yc load-balancer network-load-balancer list-operations](network-load-balancer/list-operations.md) — List operations for the specified load balancer
- [yc load-balancer target-group](target-group/index.md) — Manage target groups
	- [yc load-balancer target-group get](target-group/get.md) — Show information about the specified target group
	- [yc load-balancer target-group list](target-group/list.md) — List target groups
	- [yc load-balancer target-group create](target-group/create.md) — Create a target group
	- [yc load-balancer target-group update](target-group/update.md) — Update the specified target group
	- [yc load-balancer target-group delete](target-group/delete.md) — Delete the specified target group
	- [yc load-balancer target-group add-targets](target-group/add-targets.md) — Add targets to the specified target group
	- [yc load-balancer target-group remove-targets](target-group/remove-targets.md) — Remove targets from the specified target group
	- [yc load-balancer target-group list-operations](target-group/list-operations.md) — List operations for the specified target group

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
