---
editable: false
noIndex: true
---

# yc beta loadtesting test

A set of methods for managing tests.

#### Command Usage

Syntax:

`yc beta loadtesting test <command>`

#### Command Tree

- [yc beta loadtesting test create](create.md) — Creates (runs) a test in the specified folder.

- [yc beta loadtesting test delete](delete.md) — Deletes specified tests.

- [yc beta loadtesting test get](get.md) — Returns the specified test.

- [yc beta loadtesting test list](list.md) — Retrieves the list of test in the specified folder.

- [yc beta loadtesting test stop](stop.md) — Stops the specified test.

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