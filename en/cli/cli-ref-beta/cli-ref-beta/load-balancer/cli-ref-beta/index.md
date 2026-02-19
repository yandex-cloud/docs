---
editable: false
noIndex: true
---

# yc beta load-balancer

Manage Load Balancer resources

#### Command Usage

Syntax:

`yc beta load-balancer <group>`

#### Command Tree

- [yc beta load-balancer network-load-balancer](network-load-balancer/index.md) — A set of methods for managing NetworkLoadBalancer resources.

  - [yc beta load-balancer network-load-balancer add-listener](network-load-balancer/add-listener.md) — Adds a listener to the specified network load balancer.

  - [yc beta load-balancer network-load-balancer attach-target-group](network-load-balancer/attach-target-group.md) — Attaches a target group to the specified network load balancer.

  - [yc beta load-balancer network-load-balancer create](network-load-balancer/create.md) — Creates a network load balancer in the specified folder using the data specified in the request.

  - [yc beta load-balancer network-load-balancer delete](network-load-balancer/delete.md) — Deletes the specified network load balancer.

  - [yc beta load-balancer network-load-balancer detach-target-group](network-load-balancer/detach-target-group.md) — Detaches the target group from the specified network load balancer.

  - [yc beta load-balancer network-load-balancer disable-zones](network-load-balancer/disable-zones.md) — Disable zones for the specified network load balancer.

  - [yc beta load-balancer network-load-balancer enable-zones](network-load-balancer/enable-zones.md) — Enable zones for the specified network load balancer.

  - [yc beta load-balancer network-load-balancer get](network-load-balancer/get.md) — Returns the specified NetworkLoadBalancer resource.

  - [yc beta load-balancer network-load-balancer get-target-states](network-load-balancer/get-target-states.md) — Gets states of target resources in the attached target group.

  - [yc beta load-balancer network-load-balancer list](network-load-balancer/list.md) — Retrieves the list of NetworkLoadBalancer resources in the specified folder.

  - [yc beta load-balancer network-load-balancer list-operations](network-load-balancer/list-operations.md) — Lists operations for the specified network load balancer.

  - [yc beta load-balancer network-load-balancer remove-listener](network-load-balancer/remove-listener.md) — Removes the listener from the specified network load balancer.

  - [yc beta load-balancer network-load-balancer start](network-load-balancer/start.md) — Starts load balancing and health checking with the specified network load balancer with specified settings.

  - [yc beta load-balancer network-load-balancer stop](network-load-balancer/stop.md) — Stops load balancing and health checking with the specified network load balancer.

  - [yc beta load-balancer network-load-balancer update](network-load-balancer/update.md) — Updates the specified network load balancer.

- [yc beta load-balancer target-group](target-group/index.md) — A set of methods for managing TargetGroup resources.

  - [yc beta load-balancer target-group add-targets](target-group/add-targets.md) — Adds targets to the target group.

  - [yc beta load-balancer target-group create](target-group/create.md) — Creates a target group in the specified folder and adds the specified targets to it.

  - [yc beta load-balancer target-group delete](target-group/delete.md) — Deletes the specified target group.

  - [yc beta load-balancer target-group get](target-group/get.md) — Returns the specified TargetGroup resource.

  - [yc beta load-balancer target-group list](target-group/list.md) — Retrieves the list of TargetGroup resources in the specified folder.

  - [yc beta load-balancer target-group list-operations](target-group/list-operations.md) — Lists operations for the specified target group.

  - [yc beta load-balancer target-group remove-targets](target-group/remove-targets.md) — Removes targets from the target group.

  - [yc beta load-balancer target-group update](target-group/update.md) — Updates the specified target group.

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