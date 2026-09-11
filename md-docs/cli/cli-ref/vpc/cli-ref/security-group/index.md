[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [vpc](../index.md) > security-group > Overview

# yc vpc security-group

Manage security groups.

#### Command Usage

Syntax:

`yc vpc security-group <command>`

Aliases:

- `security-groups`

- `sg`

#### Command Tree

- [yc vpc security-group add-labels](add-labels.md) — Add labels to a security group.

- [yc vpc security-group create](create.md) — Create a security group.

- [yc vpc security-group delete](delete.md) — Delete a security group.

- [yc vpc security-group get](get.md) — Get information about a security group.

- [yc vpc security-group list](list.md) — List security groups in a folder.

- [yc vpc security-group list-operations](list-operations.md) — List operations for a security group.

- [yc vpc security-group move](move.md) — Move a security group to another folder.

- [yc vpc security-group remove-labels](remove-labels.md) — Remove labels from a security group.

- [yc vpc security-group update](update.md) — Modify configuration or attributes of a security group.

- [yc vpc security-group update-rule-meta](update-rule-meta.md) — Update rule of a security group.

- [yc vpc security-group update-rules](update-rules.md) — Update rules of a security group.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
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