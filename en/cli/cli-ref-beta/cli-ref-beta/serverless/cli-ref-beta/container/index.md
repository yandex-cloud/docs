---
editable: false
noIndex: true
---

# yc beta serverless container

A set of methods for managing serverless containers.

#### Command Usage

Syntax:

`yc beta serverless container <command>`

#### Command Tree

- [yc beta serverless container create](create.md) — Creates a container in the specified folder.

- [yc beta serverless container delete](delete.md) — Deletes the specified container.

- [yc beta serverless container deploy-revision](deploy-revision.md) — Deploys a revision for the specified container.

- [yc beta serverless container get](get.md) — Returns the specified container.

- [yc beta serverless container get-revision](get-revision.md) — Returns the specified revision of a container.

- [yc beta serverless container list](list.md) — Retrieves the list of containers in the specified folder.

- [yc beta serverless container list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified container.

- [yc beta serverless container list-operations](list-operations.md) — Lists operations for the specified container.

- [yc beta serverless container list-revisions](list-revisions.md) — Retrieves the list of revisions for the specified container, or of all container revisions

- [yc beta serverless container rollback](rollback.md) — Rollback the specified container to an old revision.

- [yc beta serverless container set-access-bindings](set-access-bindings.md) — Sets access bindings for the container.

- [yc beta serverless container update](update.md) — Updates the specified container.

- [yc beta serverless container update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified container.

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