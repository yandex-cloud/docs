---
editable: false
noIndex: true
---

# yc beta serverless function

A set of methods for managing serverless functions.

#### Command Usage

Syntax:

`yc beta serverless function <command>`

#### Command Tree

- [yc beta serverless function create](create.md) — Creates a function in the specified folder.

- [yc beta serverless function create-version](create-version.md) — Creates a version for the specified function.

- [yc beta serverless function delete](delete.md) — Deletes the specified function.

- [yc beta serverless function delete-version](delete-version.md) — Deletes the specified version of a function.

- [yc beta serverless function get](get.md) — Returns the specified function.

- [yc beta serverless function get-version](get-version.md) — Returns the specified version of a function.

- [yc beta serverless function get-version-by-tag](get-version-by-tag.md) — Returns all versions with the specified tag.

- [yc beta serverless function list](list.md) — Retrieves the list of functions in the specified folder.

- [yc beta serverless function list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified function.

- [yc beta serverless function list-operations](list-operations.md) — Lists operations for the specified function.

- [yc beta serverless function list-runtimes](list-runtimes.md) — Lists available runtime environments for the specified function.

- [yc beta serverless function list-scaling-policies](list-scaling-policies.md) — Lists existing scaling policies for specified function

- [yc beta serverless function list-tag-history](list-tag-history.md) — Returns the log of tags assigned to versions of the specified function.

- [yc beta serverless function list-versions](list-versions.md) — Retrieves the list of versions for the specified function, or of all function versions

- [yc beta serverless function remove-scaling-policy](remove-scaling-policy.md) — Remove scaling policy for specified function and tag

- [yc beta serverless function remove-tag](remove-tag.md) — Remove a tag from the specified version of a function.

- [yc beta serverless function set-access-bindings](set-access-bindings.md) — Sets access bindings for the function.

- [yc beta serverless function set-scaling-policy](set-scaling-policy.md) — Set scaling policy for specified function and tag

- [yc beta serverless function set-tag](set-tag.md) — Set a tag for the specified version of a function.

- [yc beta serverless function update](update.md) — Updates the specified function.

- [yc beta serverless function update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified function.

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