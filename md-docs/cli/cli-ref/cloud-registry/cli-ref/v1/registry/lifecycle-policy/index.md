[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник CLI (англ.)](../../../../../index.md) > [cloud-registry](../../../index.md) > [v1](../../index.md) > [registry](../index.md) > lifecycle-policy > Overview

# yc cloud-registry v1 registry lifecycle-policy

A set of methods for managing LifecyclePolicy resources.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry lifecycle-policy <command>`

Aliases:

- `lifecycle-policies`

- `lp`

#### Command Tree

- [yc cloud-registry v1 registry lifecycle-policy change-state](change-state.md) — Changes the state of the specified lifecycle policy.

- [yc cloud-registry v1 registry lifecycle-policy create](create.md) — Create a lifecycle policy.

- [yc cloud-registry v1 registry lifecycle-policy delete](delete.md) — Deletes the specified lifecycle policy.

- [yc cloud-registry v1 registry lifecycle-policy dry-run](dry-run.md) — Creates a request of a dry run of the lifecycle policy.

- [yc cloud-registry v1 registry lifecycle-policy get](get.md) — Returns the specified lifecycle policy.

- [yc cloud-registry v1 registry lifecycle-policy list](list.md) — Retrieves the list of lifecycle policies in the specified registry.

- [yc cloud-registry v1 registry lifecycle-policy update](update.md) — Update the specified lifecycle policy.

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