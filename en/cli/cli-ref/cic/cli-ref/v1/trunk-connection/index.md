---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cic/cli-ref/v1/trunk-connection/
---

# yc cic v1 trunk-connection

A set of methods for managing TrunkConnection resources.

#### Command Usage

Syntax:

`yc cic v1 trunk-connection <command>`

#### Command Tree

- [yc cic v1 trunk-connection add-labels](add-labels.md) — Add labels to a trunk connection.

- [yc cic v1 trunk-connection batch-get](batch-get.md) — 

- [yc cic v1 trunk-connection delete](delete.md) — Deletes a TrunkConnection resource.

- [yc cic v1 trunk-connection get](get.md) — Returns the specified TrunkConnection resource.

- [yc cic v1 trunk-connection list](list.md) — Retrieves the list of TrunkConnection resources in the specified folder.

- [yc cic v1 trunk-connection list-operations](list-operations.md) — Lists operations for the specified TrunkConnection.

- [yc cic v1 trunk-connection list-private-connections](list-private-connections.md) — Retrieves the list of PrivateConnection resources associated with the specified TrunkConnection.

- [yc cic v1 trunk-connection list-public-connections](list-public-connections.md) — Retrieves the list of PublicConnection resources associated with the specified TrunkConnection.

- [yc cic v1 trunk-connection move](move.md) — Moves the specified TrunkConnection to another folder.

- [yc cic v1 trunk-connection remove-labels](remove-labels.md) — Remove labels from a trunk connection.

- [yc cic v1 trunk-connection update](update.md) — Modify configuration or attributes of a trunk connection.

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