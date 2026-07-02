[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [cloud-registry](../../index.md) > [v1](../index.md) > artifact > Overview

# yc cloud-registry v1 artifact

A set of methods for managing Artifacts.

#### Command Usage

Syntax:

`yc cloud-registry v1 artifact <command>`

#### Command Tree

- [yc cloud-registry v1 artifact add-access-binding](add-access-binding.md) — Add access binding for the specified artifact.

- [yc cloud-registry v1 artifact delete](delete.md) — Deletes the specified artifact.

- [yc cloud-registry v1 artifact get](get.md) — Returns the specified artifact resource.

- [yc cloud-registry v1 artifact get-by-path](get-by-path.md) — Returns the specified artifact resource by path within the registry.

- [yc cloud-registry v1 artifact list-access-bindings](list-access-bindings.md) — access bindings

- [yc cloud-registry v1 artifact remove-access-binding](remove-access-binding.md) — Remove access binding for the specified artifact.

- [yc cloud-registry v1 artifact set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified artifact (folder, package, artifact, etc).

- [yc cloud-registry v1 artifact update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified artifact (folder, package, artifact, etc).

- [yc cloud-registry v1 artifact upsert](upsert.md) — Upserts a folder at the specified path within the registry.

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