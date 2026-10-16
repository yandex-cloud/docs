[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник (англ.)](../../../../../index.md) > [iam](../../../index.md) > [v0](../../index.md) > [workload-identity](../index.md) > oidc > Overview

# yc iam v0 workload-identity oidc



#### Command Usage

Syntax:

`yc iam v0 workload-identity oidc <group>`

#### Command Tree

- [yc iam v0 workload-identity oidc federation](federation/index.md) — Manage workload identity OIDC federation

  - [yc iam v0 workload-identity oidc federation add-access-binding](federation/add-access-binding.md) — Add access binding to access the specified workload identity federation as a resource.

  - [yc iam v0 workload-identity oidc federation add-audiences](federation/add-audiences.md) — Add audiences to workload identity federation

  - [yc iam v0 workload-identity oidc federation add-labels](federation/add-labels.md) — Add labels to workload identity federation

  - [yc iam v0 workload-identity oidc federation create](federation/create.md) — Create a workload identity federation

  - [yc iam v0 workload-identity oidc federation delete](federation/delete.md) — Delete the specified workload identity federation

  - [yc iam v0 workload-identity oidc federation get](federation/get.md) — Show information about the specified workload identity federation

  - [yc iam v0 workload-identity oidc federation list](federation/list.md) — List workload identity federations

  - [yc iam v0 workload-identity oidc federation list-access-bindings](federation/list-access-bindings.md) — List access bindings for accessing the specified workload identity federation.

  - [yc iam v0 workload-identity oidc federation remove-access-binding](federation/remove-access-binding.md) — Remove access binding for accessing the specified workload identity federation as a resource.

  - [yc iam v0 workload-identity oidc federation remove-audiences](federation/remove-audiences.md) — Remove audiences from workload identity federation

  - [yc iam v0 workload-identity oidc federation remove-labels](federation/remove-labels.md) — Remove labels from workload identity federation

  - [yc iam v0 workload-identity oidc federation set-access-bindings](federation/set-access-bindings.md) — Set access bindings for accessing the specified workload identity federation and DELETE all other existing access bindings if there were any.

  - [yc iam v0 workload-identity oidc federation update](federation/update.md) — Update the specified workload identity federation

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