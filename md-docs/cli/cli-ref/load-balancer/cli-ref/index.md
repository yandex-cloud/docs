[Документация Yandex Cloud](../../../../index.md) > [Интерфейс командной строки](../../../index.md) > [Справочник (англ.)](../../index.md) > load-balancer > Overview

# yc load-balancer

Manage Yandex Load Balancer resources

Command tree v0 is the default. Run `yc load-balancer <command>` or `yc load-balancer v0 <command>`.

#### Command Usage

Syntax:

`yc load-balancer <group>`

Aliases:

- `balancer`

- `lb`

#### Command Tree

- [yc load-balancer network-load-balancer](network-load-balancer/index.md) — Manage network load balancer

  - [yc load-balancer network-load-balancer add-listener](network-load-balancer/add-listener.md) — Adds a listener to the specified network load balancer.

  - [yc load-balancer network-load-balancer attach-target-group](network-load-balancer/attach-target-group.md) — Attaches a target group to the specified network load balancer.

  - [yc load-balancer network-load-balancer create](network-load-balancer/create.md) — Create a network load balancer

  - [yc load-balancer network-load-balancer delete](network-load-balancer/delete.md) — Delete the specified load balancer

  - [yc load-balancer network-load-balancer detach-target-group](network-load-balancer/detach-target-group.md) — Detaches the target group from the specified network load balancer.

  - [yc load-balancer network-load-balancer disable-zones](network-load-balancer/disable-zones.md) — Disable zones for the specified network load balancer

  - [yc load-balancer network-load-balancer enable-zones](network-load-balancer/enable-zones.md) — Enable zones for the specified network load balancer

  - [yc load-balancer network-load-balancer get](network-load-balancer/get.md) — Show information about the specified load balancer

  - [yc load-balancer network-load-balancer list](network-load-balancer/list.md) — List load balancers

  - [yc load-balancer network-load-balancer list-operations](network-load-balancer/list-operations.md) — List operations for the specified load balancer

  - [yc load-balancer network-load-balancer remove-listener](network-load-balancer/remove-listener.md) — Removes the listener from the specified network load balancer.

  - [yc load-balancer network-load-balancer start](network-load-balancer/start.md) — Starts load balancing and health checking with the specified network load balancer.

  - [yc load-balancer network-load-balancer stop](network-load-balancer/stop.md) — Stops load balancing and health checking with the specified network load balancer.

  - [yc load-balancer network-load-balancer target-states](network-load-balancer/target-states.md) — Show states of target resources in the attached target group

  - [yc load-balancer network-load-balancer update](network-load-balancer/update.md) — Update the specified load balancer

- [yc load-balancer target-group](target-group/index.md) — Manage target groups

  - [yc load-balancer target-group add-targets](target-group/add-targets.md) — Add targets to the specified target group

  - [yc load-balancer target-group create](target-group/create.md) — Create a target group

  - [yc load-balancer target-group delete](target-group/delete.md) — Delete the specified target group

  - [yc load-balancer target-group get](target-group/get.md) — Show information about the specified target group

  - [yc load-balancer target-group list](target-group/list.md) — List target groups

  - [yc load-balancer target-group list-operations](target-group/list-operations.md) — List operations for the specified target group

  - [yc load-balancer target-group remove-targets](target-group/remove-targets.md) — Remove targets from the specified target group

  - [yc load-balancer target-group update](target-group/update.md) — Update the specified target group

- [yc load-balancer v0](v0/index.md) — Manage Yandex Load Balancer resources



#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#