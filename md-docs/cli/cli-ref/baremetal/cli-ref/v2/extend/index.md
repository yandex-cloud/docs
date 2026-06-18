# yc baremetal v2 extend



#### Command Usage

Syntax:

`yc baremetal v2 extend <group>`

#### Command Tree

- [yc baremetal v2 extend stackland-cluster](stackland-cluster/index.md) — A set of methods for managing StacklandCluster resources.

  - [yc baremetal v2 extend stackland-cluster create](stackland-cluster/create.md) — Creates new Stackland cluster.

  - [yc baremetal v2 extend stackland-cluster delete](stackland-cluster/delete.md) — Deletes the specified Stackland cluster.

  - [yc baremetal v2 extend stackland-cluster get](stackland-cluster/get.md) — Gets Stackland cluster by it's id.

  - [yc baremetal v2 extend stackland-cluster list](stackland-cluster/list.md) — List Stackland clusters in the specified folder.

  - [yc baremetal v2 extend stackland-cluster update](stackland-cluster/update.md) — Updates the specified Stackland cluster.

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