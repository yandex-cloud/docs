[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [resource-manager](../index.md) > folder > Overview

# yc resource-manager folder

Manage folders

#### Command Usage

Syntax:

`yc resource-manager folder <command>`

Aliases:

- `folders`

#### Command Tree

- [yc resource-manager folder add-access-binding](add-access-binding.md) — Add access binding for the specified folder

- [yc resource-manager folder add-labels](add-labels.md) — Add labels to specified folder

- [yc resource-manager folder bind-access-policy](bind-access-policy.md) — Bind access policy to the specified folder

- [yc resource-manager folder create](create.md) — Create a folder

- [yc resource-manager folder delete](delete.md) — Delete the specified folder

- [yc resource-manager folder get](get.md) — Show information about the specified folder

- [yc resource-manager folder list](list.md) — List folders

- [yc resource-manager folder list-access-bindings](list-access-bindings.md) — List access bindings for the specified folder

- [yc resource-manager folder list-access-policy-bindings](list-access-policy-bindings.md) — List access policy bindings for the specified folder

- [yc resource-manager folder list-operations](list-operations.md) — List operations for the specified folder

- [yc resource-manager folder remove-access-binding](remove-access-binding.md) — Remove access binding for the specified folder

- [yc resource-manager folder remove-labels](remove-labels.md) — Remove labels from specified folder

- [yc resource-manager folder set-access-bindings](set-access-bindings.md) — Set access bindings for the specified folder and delete all existing access bindings if there were any

- [yc resource-manager folder unbind-access-policy](unbind-access-policy.md) — Unbind access policy from the specified folder

- [yc resource-manager folder update](update.md) — Update the specified folder

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