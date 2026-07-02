[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [cic](../../index.md) > [v1](../index.md) > private-connection > Overview

# yc cic v1 private-connection

A set of methods for managing PrivateConnection resources.

#### Command Usage

Syntax:

`yc cic v1 private-connection <command>`

#### Command Tree

- [yc cic v1 private-connection add-labels](add-labels.md) — Assign labels to a privateConnection.

- [yc cic v1 private-connection batch-get](batch-get.md) — Get list of PrivateConnections by their IDs

- [yc cic v1 private-connection create](create.md) — Create a privateConnection.

- [yc cic v1 private-connection delete](delete.md) — Deletes a PrivateConnection resource.

- [yc cic v1 private-connection get](get.md) — Returns the specified PrivateConnection resource.

- [yc cic v1 private-connection list](list.md) — Retrieves the list of PrivateConnection resources in the specified folder.

- [yc cic v1 private-connection list-operations](list-operations.md) — Lists operations for the specified PrivateConnection.

- [yc cic v1 private-connection move](move.md) — Moves the specified PrivateConnection to another folder.

- [yc cic v1 private-connection remove-labels](remove-labels.md) — Remove labels from a privateConnection.

- [yc cic v1 private-connection remove-static-routes](remove-static-routes.md) — Remove static routes from a privateConnection.

- [yc cic v1 private-connection update](update.md) — Modify configuration or attributes of a privateConnection.

- [yc cic v1 private-connection upsert-static-routes](upsert-static-routes.md) — Upsert static routes to a privateConnection.

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