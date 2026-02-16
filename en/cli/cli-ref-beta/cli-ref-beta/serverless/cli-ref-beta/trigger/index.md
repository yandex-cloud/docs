---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/trigger/index.md
---

# yc beta serverless trigger

A set of methods for managing triggers for serverless functions.

#### Command Usage

Syntax:

`yc beta serverless trigger <command>`

#### Command Tree

- [yc beta serverless trigger create](create.md) — Creates a trigger in the specified folder.

- [yc beta serverless trigger delete](delete.md) — Deletes the specified trigger.

- [yc beta serverless trigger get](get.md) — Returns the specified trigger.

- [yc beta serverless trigger list](list.md) — Retrieves the list of triggers in the specified folder.

- [yc beta serverless trigger list-operations](list-operations.md) — Lists operations for the specified trigger.

- [yc beta serverless trigger pause](pause.md) — Pauses the specified trigger.

- [yc beta serverless trigger resume](resume.md) — Restarts the specified trigger.

- [yc beta serverless trigger update](update.md) — Updates the specified trigger.

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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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