---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/lifecycle-policy/index.md
---

# yc beta container lifecycle-policy

A set of methods for managing Lifecycle policy resources.

#### Command Usage

Syntax:

`yc beta container lifecycle-policy <command>`

#### Command Tree

- [yc beta container lifecycle-policy create](create.md) — Creates a lifecycle policy in the specified repository.

- [yc beta container lifecycle-policy delete](delete.md) — Deletes the specified lifecycle policy.

- [yc beta container lifecycle-policy dry-run](dry-run.md) — Creates a request of a dry run of the lifecycle policy.

- [yc beta container lifecycle-policy get](get.md) — Returns the specified lifecycle policy.

- [yc beta container lifecycle-policy get-dry-run-result](get-dry-run-result.md) — Returns the dry run result of the specified lifecycle policy.

- [yc beta container lifecycle-policy list](list.md) — Retrieves the list of lifecycle policies in the specified repository.

- [yc beta container lifecycle-policy list-dry-run-result-affected-images](list-dry-run-result-affected-images.md) — Retrieves the list of the affected images.

- [yc beta container lifecycle-policy list-dry-run-results](list-dry-run-results.md) — Retrieves the list of the dry run results.

- [yc beta container lifecycle-policy update](update.md) — Updates the specified lifecycle policy.

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