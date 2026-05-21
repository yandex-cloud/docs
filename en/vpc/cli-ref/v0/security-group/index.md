---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/vpc/cli-ref/v0/security-group/
editable: false
---

# yc vpc v0 security-group

Manage security groups.

#### Command Usage

Syntax:

`yc vpc security-group <command>`

Aliases:

- `security-groups`

- `sg`

#### Command Tree

- [yc vpc v0 security-group add-labels](add-labels.md) — Add labels to a security group.

- [yc vpc v0 security-group create](create.md) — Create a security group.

- [yc vpc v0 security-group delete](delete.md) — Delete a security group.

- [yc vpc v0 security-group get](get.md) — Get information about a security group.

- [yc vpc v0 security-group list](list.md) — List security groups in a folder.

- [yc vpc v0 security-group list-operations](list-operations.md) — List operations for a security group.

- [yc vpc v0 security-group move](move.md) — Move a security group to another folder.

- [yc vpc v0 security-group remove-labels](remove-labels.md) — Remove labels from a security group.

- [yc vpc v0 security-group update](update.md) — Modify configuration or attributes of a security group.

- [yc vpc v0 security-group update-rule-meta](update-rule-meta.md) — Update rule of a security group.

- [yc vpc v0 security-group update-rules](update-rules.md) — Update rules of a security group.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
