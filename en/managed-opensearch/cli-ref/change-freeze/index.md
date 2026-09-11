---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-opensearch/cli-ref/change-freeze/
---

# yc managed-opensearch change-freeze

Manage change freezes.

#### Command Usage

Syntax:

`yc managed-opensearch change-freeze <command>`

#### Command Tree

- [yc managed-opensearch change-freeze create](create.md) — Create a change freeze for the specified resource.

- [yc managed-opensearch change-freeze get](get.md) — Show the specified change freeze.

- [yc managed-opensearch change-freeze get-limits](get-limits.md) — Show change freeze limits for the specified resource.

- [yc managed-opensearch change-freeze list](list.md) — List change freezes.

- [yc managed-opensearch change-freeze terminate](terminate.md) — Terminate the specified change freeze.

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