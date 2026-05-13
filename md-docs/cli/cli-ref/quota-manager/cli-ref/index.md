# yc quota-manager

Manage Yandex Quota Manager resources

#### Command Usage

Syntax:

`yc quota-manager <group>`

#### Command Tree

- [yc quota-manager quota-limit](quota-limit/index.md) — Manage quota limits

  - [yc quota-manager quota-limit get](quota-limit/get.md) — Show information about the specified quota

  - [yc quota-manager quota-limit list](quota-limit/list.md) — List quota limits

  - [yc quota-manager quota-limit list-services](quota-limit/list-services.md) — List quota services

- [yc quota-manager quota-request](quota-request/index.md) — Manage quota requests

  - [yc quota-manager quota-request cancel](quota-request/cancel.md) — Cancel quotas in the specified quota request.

  - [yc quota-manager quota-request create](quota-request/create.md) — Create a quota request

  - [yc quota-manager quota-request get](quota-request/get.md) — Show information about the specified quota request

  - [yc quota-manager quota-request list](quota-request/list.md) — List quota requests

  - [yc quota-manager quota-request list-operations](quota-request/list-operations.md) — List operations for the specified quota request

- [yc quota-manager v0](v0/index.md) — Manage Yandex Quota Manager resources



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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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