---
editable: false
noIndex: true
---

# yc beta application-load-balancer

Manage Application Load Balancer resources

#### Command Usage

Syntax:

`yc beta application-load-balancer <group>`

#### Command Tree

- [yc beta application-load-balancer backend-group](backend-group/index.md) — A set of methods for managing backend groups.

  - [yc beta application-load-balancer backend-group add-backend](backend-group/add-backend.md) — Adds backends to the specified backend group.

  - [yc beta application-load-balancer backend-group create](backend-group/create.md) — Creates a backend group in the specified folder.

  - [yc beta application-load-balancer backend-group delete](backend-group/delete.md) — Deletes the specified backend group.

  - [yc beta application-load-balancer backend-group get](backend-group/get.md) — Returns the specified backend group.

  - [yc beta application-load-balancer backend-group list](backend-group/list.md) — Lists backend groups in the specified folder.

  - [yc beta application-load-balancer backend-group list-operations](backend-group/list-operations.md) — Lists operations for the specified backend group.

  - [yc beta application-load-balancer backend-group remove-backend](backend-group/remove-backend.md) — Removes backends from the specified backend group.

  - [yc beta application-load-balancer backend-group update](backend-group/update.md) — Updates the specified backend group.

  - [yc beta application-load-balancer backend-group update-backend](backend-group/update-backend.md) — Updates the specified backend.

- [yc beta application-load-balancer http-router](http-router/index.md) — A set of methods for managing HTTP routers.

  - [yc beta application-load-balancer http-router create](http-router/create.md) — Creates an HTTP router in the specified folder.

  - [yc beta application-load-balancer http-router delete](http-router/delete.md) — Deletes the specified HTTP router.

  - [yc beta application-load-balancer http-router get](http-router/get.md) — Returns the specified HTTP router.

  - [yc beta application-load-balancer http-router list](http-router/list.md) — Lists HTTP routers in the specified folder.

  - [yc beta application-load-balancer http-router list-operations](http-router/list-operations.md) — Lists operations for the specified HTTP router.

  - [yc beta application-load-balancer http-router update](http-router/update.md) — Updates the specified HTTP router.

- [yc beta application-load-balancer load-balancer](load-balancer/index.md) — A set of methods for managing application load balancers.

  - [yc beta application-load-balancer load-balancer add-listener](load-balancer/add-listener.md) — Adds a listener to the specified application load balancer.

  - [yc beta application-load-balancer load-balancer add-sni-match](load-balancer/add-sni-match.md) — Adds a SNI handler to the specified listener.

  - [yc beta application-load-balancer load-balancer cancel-zonal-shift](load-balancer/cancel-zonal-shift.md) — Cancel ZonalShift for the specified load balancer.

  - [yc beta application-load-balancer load-balancer create](load-balancer/create.md) — Creates an application load balancer in the specified folder.

  - [yc beta application-load-balancer load-balancer delete](load-balancer/delete.md) — Deletes the specified application load balancer.

  - [yc beta application-load-balancer load-balancer disable-zones](load-balancer/disable-zones.md) — Disable L7 traffic routing in zones for the specified load balancer.

  - [yc beta application-load-balancer load-balancer enable-zones](load-balancer/enable-zones.md) — Enable L7 traffic routing back in zones for the specified load balancer.

  - [yc beta application-load-balancer load-balancer get](load-balancer/get.md) — Returns the specified application load balancer.

  - [yc beta application-load-balancer load-balancer get-target-states](load-balancer/get-target-states.md) — Returns the statuses of all targets of the specified backend group in all their availability zones.

  - [yc beta application-load-balancer load-balancer list](load-balancer/list.md) — Lists application load balancers in the specified folder.

  - [yc beta application-load-balancer load-balancer list-operations](load-balancer/list-operations.md) — Lists operations for the specified application load balancer.

  - [yc beta application-load-balancer load-balancer remove-listener](load-balancer/remove-listener.md) — Deletes the specified listener.

  - [yc beta application-load-balancer load-balancer remove-sni-match](load-balancer/remove-sni-match.md) — Deletes the specified SNI handler.

  - [yc beta application-load-balancer load-balancer start](load-balancer/start.md) — Starts the specified application load balancer.

  - [yc beta application-load-balancer load-balancer start-zonal-shift](load-balancer/start-zonal-shift.md) — Start ZonalShift for the specified load balancer.

  - [yc beta application-load-balancer load-balancer stop](load-balancer/stop.md) — Stops the specified application load balancer.

  - [yc beta application-load-balancer load-balancer update](load-balancer/update.md) — Updates the specified application load balancer.

  - [yc beta application-load-balancer load-balancer update-listener](load-balancer/update-listener.md) — Updates the specified listener of the specified application load balancer.

  - [yc beta application-load-balancer load-balancer update-sni-match](load-balancer/update-sni-match.md) — Updates the specified SNI handler of the specified listener.

- [yc beta application-load-balancer target-group](target-group/index.md) — A set of methods for managing target groups.

  - [yc beta application-load-balancer target-group add-targets](target-group/add-targets.md) — Adds targets to the specified target group.

  - [yc beta application-load-balancer target-group create](target-group/create.md) — Creates a target group in the specified folder.

  - [yc beta application-load-balancer target-group delete](target-group/delete.md) — Deletes the specified target group.

  - [yc beta application-load-balancer target-group get](target-group/get.md) — Returns the specified target group.

  - [yc beta application-load-balancer target-group list](target-group/list.md) — Lists target groups in the specified folder.

  - [yc beta application-load-balancer target-group list-operations](target-group/list-operations.md) — Lists operations for the specified target group.

  - [yc beta application-load-balancer target-group remove-targets](target-group/remove-targets.md) — Removes targets from the specified target group.

  - [yc beta application-load-balancer target-group update](target-group/update.md) — Updates the specified target group.

- [yc beta application-load-balancer virtual-host](virtual-host/index.md) — A set of methods for managing virtual hosts of HTTP routers.

  - [yc beta application-load-balancer virtual-host create](virtual-host/create.md) — Creates a virtual host in the specified HTTP router.

  - [yc beta application-load-balancer virtual-host delete](virtual-host/delete.md) — Deletes the specified virtual host.

  - [yc beta application-load-balancer virtual-host get](virtual-host/get.md) — Returns the specified virtual host.

  - [yc beta application-load-balancer virtual-host list](virtual-host/list.md) — Lists virtual hosts of the specified HTTP router.

  - [yc beta application-load-balancer virtual-host remove-route](virtual-host/remove-route.md) — Deletes the specified route from the specified virtual host.

  - [yc beta application-load-balancer virtual-host update](virtual-host/update.md) — Updates the specified virtual host of the specified HTTP router.

  - [yc beta application-load-balancer virtual-host update-route](virtual-host/update-route.md) — Updates the specified route of the specified virtual host.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#