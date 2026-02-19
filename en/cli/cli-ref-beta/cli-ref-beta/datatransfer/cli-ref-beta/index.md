---
editable: false
noIndex: true
---

# yc beta datatransfer

Manage Data Transfer endpoints and transfers

#### Command Usage

Syntax:

`yc beta datatransfer <group>`

#### Command Tree

- [yc beta datatransfer endpoint](endpoint/index.md) — A set of methods for managing [endpoints]({{ api-url-prefix

  - [yc beta datatransfer endpoint create](endpoint/create.md) — Creates an endpoint in the specified folder.

  - [yc beta datatransfer endpoint delete](endpoint/delete.md) — Deletes the specified endpoint.

  - [yc beta datatransfer endpoint get](endpoint/get.md) — Returns the specified endpoint.

  - [yc beta datatransfer endpoint list](endpoint/list.md) — Lists endpoints in the specified folder.

  - [yc beta datatransfer endpoint update](endpoint/update.md) — Updates the specified endpoint.

- [yc beta datatransfer transfer](transfer/index.md) — 

  - [yc beta datatransfer transfer activate](transfer/activate.md) — Activates the specified transfer.

  - [yc beta datatransfer transfer create](transfer/create.md) — Creates a transfer in the specified folder.

  - [yc beta datatransfer transfer deactivate](transfer/deactivate.md) — Deactivates the specified transfer.

  - [yc beta datatransfer transfer delete](transfer/delete.md) — Deletes the specified transfer.

  - [yc beta datatransfer transfer get](transfer/get.md) — Returns the specified transfer.

  - [yc beta datatransfer transfer list](transfer/list.md) — Lists transfers in the specified folder.

  - [yc beta datatransfer transfer update](transfer/update.md) — Updates the specified transfer.

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