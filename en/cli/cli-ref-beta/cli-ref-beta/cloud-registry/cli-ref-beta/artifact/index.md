---
editable: false
noIndex: true
---

# yc beta cloud-registry artifact

A set of methods for managing Artifacts.

#### Command Usage

Syntax:

`yc beta cloud-registry artifact <command>`

#### Command Tree

- [yc beta cloud-registry artifact delete](delete.md) — Deletes the specified artifact.

- [yc beta cloud-registry artifact get](get.md) — Returns the specified artifact resource.

- [yc beta cloud-registry artifact list-access-bindings](list-access-bindings.md) — access bindings

- [yc beta cloud-registry artifact set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified artifact (folder, package, artifact, etc).

- [yc beta cloud-registry artifact update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified artifact (folder, package, artifact, etc).

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