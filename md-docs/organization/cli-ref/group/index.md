[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Справочник CLI (англ.)](../index.md) > group > Overview

# yc organization-manager group

Manage groups in organizations

#### Command Usage

Syntax:

`yc organization-manager group <command>`

Aliases:

- `groups`

#### Command Tree

- [yc organization-manager group add-access-binding](add-access-binding.md) — Add access binding for the specified group

- [yc organization-manager group add-labels](add-labels.md) — Add labels to specified group

- [yc organization-manager group add-members](add-members.md) — Add members to the specified group

- [yc organization-manager group create](create.md) — Create a group

- [yc organization-manager group delete](delete.md) — Delete the specified group

- [yc organization-manager group get](get.md) — Show information about the specified group

- [yc organization-manager group list](list.md) — List groups

- [yc organization-manager group list-access-bindings](list-access-bindings.md) — List access bindings for the specified group

- [yc organization-manager group list-effective](list-effective.md) — List groups that the subject belongs to within a specific organization.

- [yc organization-manager group list-members](list-members.md) — List members of the specified group

- [yc organization-manager group list-operations](list-operations.md) — List operations for the specified group

- [yc organization-manager group remove-access-binding](remove-access-binding.md) — Remove access binding for the specified group

- [yc organization-manager group remove-labels](remove-labels.md) — Remove labels from specified group

- [yc organization-manager group remove-members](remove-members.md) — Remove members from the specified group

- [yc organization-manager group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified group and delete all existing access bindings if there were any

- [yc organization-manager group update](update.md) — Update the specified group

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