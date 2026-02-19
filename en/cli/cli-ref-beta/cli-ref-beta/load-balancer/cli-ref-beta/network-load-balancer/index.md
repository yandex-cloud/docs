---
editable: false
noIndex: true
---

# yc beta load-balancer network-load-balancer

A set of methods for managing NetworkLoadBalancer resources.

#### Command Usage

Syntax:

`yc beta load-balancer network-load-balancer <command>`

#### Command Tree

- [yc beta load-balancer network-load-balancer add-listener](add-listener.md) — Adds a listener to the specified network load balancer.

- [yc beta load-balancer network-load-balancer attach-target-group](attach-target-group.md) — Attaches a target group to the specified network load balancer.

- [yc beta load-balancer network-load-balancer create](create.md) — Creates a network load balancer in the specified folder using the data specified in the request.

- [yc beta load-balancer network-load-balancer delete](delete.md) — Deletes the specified network load balancer.

- [yc beta load-balancer network-load-balancer detach-target-group](detach-target-group.md) — Detaches the target group from the specified network load balancer.

- [yc beta load-balancer network-load-balancer disable-zones](disable-zones.md) — Disable zones for the specified network load balancer.

- [yc beta load-balancer network-load-balancer enable-zones](enable-zones.md) — Enable zones for the specified network load balancer.

- [yc beta load-balancer network-load-balancer get](get.md) — Returns the specified NetworkLoadBalancer resource.

- [yc beta load-balancer network-load-balancer get-target-states](get-target-states.md) — Gets states of target resources in the attached target group.

- [yc beta load-balancer network-load-balancer list](list.md) — Retrieves the list of NetworkLoadBalancer resources in the specified folder.

- [yc beta load-balancer network-load-balancer list-operations](list-operations.md) — Lists operations for the specified network load balancer.

- [yc beta load-balancer network-load-balancer remove-listener](remove-listener.md) — Removes the listener from the specified network load balancer.

- [yc beta load-balancer network-load-balancer start](start.md) — Starts load balancing and health checking with the specified network load balancer with specified settings.

- [yc beta load-balancer network-load-balancer stop](stop.md) — Stops load balancing and health checking with the specified network load balancer.

- [yc beta load-balancer network-load-balancer update](update.md) — Updates the specified network load balancer.

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