---
editable: false
noIndex: true
---

# yc beta application-load-balancer load-balancer

A set of methods for managing application load balancers.

#### Command Usage

Syntax:

`yc beta application-load-balancer load-balancer <command>`

#### Command Tree

- [yc beta application-load-balancer load-balancer add-listener](add-listener.md) — Adds a listener to the specified application load balancer.

- [yc beta application-load-balancer load-balancer add-sni-match](add-sni-match.md) — Adds a SNI handler to the specified listener.

- [yc beta application-load-balancer load-balancer cancel-zonal-shift](cancel-zonal-shift.md) — Cancel ZonalShift for the specified load balancer.

- [yc beta application-load-balancer load-balancer create](create.md) — Creates an application load balancer in the specified folder.

- [yc beta application-load-balancer load-balancer delete](delete.md) — Deletes the specified application load balancer.

- [yc beta application-load-balancer load-balancer disable-zones](disable-zones.md) — Disable L7 traffic routing in zones for the specified load balancer.

- [yc beta application-load-balancer load-balancer enable-zones](enable-zones.md) — Enable L7 traffic routing back in zones for the specified load balancer.

- [yc beta application-load-balancer load-balancer get](get.md) — Returns the specified application load balancer.

- [yc beta application-load-balancer load-balancer get-target-states](get-target-states.md) — Returns the statuses of all targets of the specified backend group in all their availability zones.

- [yc beta application-load-balancer load-balancer list](list.md) — Lists application load balancers in the specified folder.

- [yc beta application-load-balancer load-balancer list-operations](list-operations.md) — Lists operations for the specified application load balancer.

- [yc beta application-load-balancer load-balancer remove-listener](remove-listener.md) — Deletes the specified listener.

- [yc beta application-load-balancer load-balancer remove-sni-match](remove-sni-match.md) — Deletes the specified SNI handler.

- [yc beta application-load-balancer load-balancer start](start.md) — Starts the specified application load balancer.

- [yc beta application-load-balancer load-balancer start-zonal-shift](start-zonal-shift.md) — Start ZonalShift for the specified load balancer.

- [yc beta application-load-balancer load-balancer stop](stop.md) — Stops the specified application load balancer.

- [yc beta application-load-balancer load-balancer update](update.md) — Updates the specified application load balancer.

- [yc beta application-load-balancer load-balancer update-listener](update-listener.md) — Updates the specified listener of the specified application load balancer.

- [yc beta application-load-balancer load-balancer update-sni-match](update-sni-match.md) — Updates the specified SNI handler of the specified listener.

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