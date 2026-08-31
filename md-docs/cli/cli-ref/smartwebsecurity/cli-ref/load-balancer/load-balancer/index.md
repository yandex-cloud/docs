[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [smartwebsecurity](../../index.md) > [load-balancer](../index.md) > load-balancer > Overview

# yc smartwebsecurity load-balancer load-balancer

Manage SmartWebSecurity load balancers

#### Command Usage

Syntax:

`yc smartwebsecurity load-balancer load-balancer <command>`

#### Command Tree

- [yc smartwebsecurity load-balancer load-balancer create](create.md) — Creates a load balancer in the specified folder.

- [yc smartwebsecurity load-balancer load-balancer delete](delete.md) — Deletes the specified load balancer.

- [yc smartwebsecurity load-balancer load-balancer get](get.md) — Returns the specified load balancer.

- [yc smartwebsecurity load-balancer load-balancer list](list.md) — Lists load balancers in the specified folder.

- [yc smartwebsecurity load-balancer load-balancer start](start.md) — Starts the specified load balancer.

- [yc smartwebsecurity load-balancer load-balancer stop](stop.md) — Stops the specified load balancer.

- [yc smartwebsecurity load-balancer load-balancer update](update.md) — Updates the specified load balancer.

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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#