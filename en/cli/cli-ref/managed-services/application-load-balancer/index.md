# yc application-load-balancer

[PREVIEW] Manage Yandex Application Load Balancer resources

#### Command Usage

Syntax: 

`yc application-load-balancer <group>`

Aliases: 

- `alb`

#### Command Tree

- [yc application-load-balancer load-balancer](load-balancer/index.md) — Manage application load balancer
	- [yc application-load-balancer load-balancer get](load-balancer/get.md) — Show information about the specified load balancer
	- [yc application-load-balancer load-balancer list](load-balancer/list.md) — List application load balancers
	- [yc application-load-balancer load-balancer create](load-balancer/create.md) — Create an application load balancer
	- [yc application-load-balancer load-balancer update](load-balancer/update.md) — Update the specified application load balancer
	- [yc application-load-balancer load-balancer delete](load-balancer/delete.md) — Delete the specified application load balancer
	- [yc application-load-balancer load-balancer add-listener](load-balancer/add-listener.md) — Adds a listener to the specified application load balancer.
	- [yc application-load-balancer load-balancer update-listener](load-balancer/update-listener.md) — Updates listener in the specified application load balancer.
	- [yc application-load-balancer load-balancer remove-listener](load-balancer/remove-listener.md) — Removes the listener from the specified application load balancer.
	- [yc application-load-balancer load-balancer remove-sni](load-balancer/remove-sni.md) — Removes sni match from application load balancer's listener.
	- [yc application-load-balancer load-balancer add-sni](load-balancer/add-sni.md) — Adds sni match to application load balancer's listener.
	- [yc application-load-balancer load-balancer update-sni](load-balancer/update-sni.md) — Updates sni match of the application load balancer's listener.
	- [yc application-load-balancer load-balancer list-operations](load-balancer/list-operations.md) — List operations for the specified application load balancer
	- [yc application-load-balancer load-balancer disable-traffic](load-balancer/disable-traffic.md) — Disables traffic in specified zones for application load balancer.
	- [yc application-load-balancer load-balancer enable-traffic](load-balancer/enable-traffic.md) — Enables traffic in specified zones for application load balancer.
	- [yc application-load-balancer load-balancer add-location](load-balancer/add-location.md) — Adds locations to application load balancer.
	- [yc application-load-balancer load-balancer remove-location](load-balancer/remove-location.md) — Removes locations from application load balancer.
	- [yc application-load-balancer load-balancer target-states](load-balancer/target-states.md) — Shows states of targets in the target group and backend group for application load balancer.
- [yc application-load-balancer backend-group](backend-group/index.md) — Manage application load balancer backend groups
	- [yc application-load-balancer backend-group get](backend-group/get.md) — Show information about the specified backend group
	- [yc application-load-balancer backend-group list](backend-group/list.md) — List backend groups
	- [yc application-load-balancer backend-group create](backend-group/create.md) — Create an backend group
	- [yc application-load-balancer backend-group update](backend-group/update.md) — Update the specified backend group
	- [yc application-load-balancer backend-group delete](backend-group/delete.md) — Delete the specified backend group
	- [yc application-load-balancer backend-group add-http-backend](backend-group/add-http-backend.md) — Add HTTP backend to the backend group
	- [yc application-load-balancer backend-group update-http-backend](backend-group/update-http-backend.md) — Update HTTP backend to the backend group
	- [yc application-load-balancer backend-group delete-http-backend](backend-group/delete-http-backend.md) — Delete HTTP backend from the backend group
- [yc application-load-balancer http-router](http-router/index.md) — Manage application load balancer http router
	- [yc application-load-balancer http-router get](http-router/get.md) — Show information about the specified http router
	- [yc application-load-balancer http-router list](http-router/list.md) — List http routers
	- [yc application-load-balancer http-router create](http-router/create.md) — Create an http router
	- [yc application-load-balancer http-router update](http-router/update.md) — Update the specified http router
	- [yc application-load-balancer http-router delete](http-router/delete.md) — Delete the specified http router
- [yc application-load-balancer virtual-host](virtual-host/index.md) — Manage http router virtual host
	- [yc application-load-balancer virtual-host get](virtual-host/get.md) — Show information about the specified virtual host
	- [yc application-load-balancer virtual-host list](virtual-host/list.md) — List http router virtual hosts
	- [yc application-load-balancer virtual-host create](virtual-host/create.md) — Create an virtual host for the http router
	- [yc application-load-balancer virtual-host update](virtual-host/update.md) — Update the specified virtual host
	- [yc application-load-balancer virtual-host delete](virtual-host/delete.md) — Delete the specified virtual host of the http router
	- [yc application-load-balancer virtual-host append-http-route](virtual-host/append-http-route.md) — Appends http route to the specified virtual host of the http router
	- [yc application-load-balancer virtual-host prepend-http-route](virtual-host/prepend-http-route.md) — Prepends http route to the specified virtual host of the http router
	- [yc application-load-balancer virtual-host remove-http-route](virtual-host/remove-http-route.md) — Removes http route from the specified virtual host of the http router
	- [yc application-load-balancer virtual-host insert-http-route](virtual-host/insert-http-route.md) — Removes http route from the specified virtual host of the http router
- [yc application-load-balancer target-group](target-group/index.md) — Manage application load balancer target groups
	- [yc application-load-balancer target-group get](target-group/get.md) — Show information about the specified target group
	- [yc application-load-balancer target-group list](target-group/list.md) — List target groups
	- [yc application-load-balancer target-group create](target-group/create.md) — Create a target group
	- [yc application-load-balancer target-group update](target-group/update.md) — Update the specified target group
	- [yc application-load-balancer target-group delete](target-group/delete.md) — Delete the specified application target group
	- [yc application-load-balancer target-group add-targets](target-group/add-targets.md) — Add targets to the specified target group
	- [yc application-load-balancer target-group remove-targets](target-group/remove-targets.md) — Remove targets from the specified target group

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
