---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloud-registry/cli-ref/v1/registry/scan-policy/
---

# yc cloud-registry v1 registry scan-policy

A set of methods for managing scan policy resources.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry scan-policy <command>`

Aliases:

- `scan-policies`

- `sp`

#### Command Tree

- [yc cloud-registry v1 registry scan-policy create](create.md) — Create a scan policy.

- [yc cloud-registry v1 registry scan-policy delete](delete.md) — Deletes the specified scan policy.

- [yc cloud-registry v1 registry scan-policy get](get.md) — Returns the specified scan policy.

- [yc cloud-registry v1 registry scan-policy get-by-registry](get-by-registry.md) — Returns scan policy for the registry if any exists.

- [yc cloud-registry v1 registry scan-policy update](update.md) — Update the specified scan policy.

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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#