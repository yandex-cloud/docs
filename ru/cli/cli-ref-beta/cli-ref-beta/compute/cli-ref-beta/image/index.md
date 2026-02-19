---
editable: false
noIndex: true
---

# yc beta compute image

A set of methods for managing Image resources.

#### Command Usage

Syntax:

`yc beta compute image <command>`

#### Command Tree

- [yc beta compute image create](create.md) — Creates an image in the specified folder.

- [yc beta compute image delete](delete.md) — Deletes the specified image.

- [yc beta compute image get](get.md) — Returns the specified Image resource.

- [yc beta compute image get-latest-by-family](get-latest-by-family.md) — Returns the latest image that is part of an image family.

- [yc beta compute image list](list.md) — Retrieves the list of Image resources in the specified folder.

- [yc beta compute image list-access-bindings](list-access-bindings.md) — Lists access bindings for the image.

- [yc beta compute image list-operations](list-operations.md) — Lists operations for the specified image.

- [yc beta compute image set-access-bindings](set-access-bindings.md) — Sets access bindings for the image.

- [yc beta compute image update](update.md) — Updates the specified image.

- [yc beta compute image update-access-bindings](update-access-bindings.md) — Updates access bindings for the image.

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