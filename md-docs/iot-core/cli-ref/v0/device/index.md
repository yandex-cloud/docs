# yc iot v0 device

Manage IoT devices

#### Command Usage

Syntax:

`yc iot device <group|command>`

Aliases:

- `devices`

#### Command Tree

- [yc iot v0 device add-topic-aliases](add-topic-aliases.md) — Add aliases for topics of specified device

- [yc iot v0 device create](create.md) — Create new device device

- [yc iot v0 device delete](delete.md) — Delete specified device

- [yc iot v0 device get](get.md) — Show information about specified device

- [yc iot v0 device list](list.md) — List IoT devices

- [yc iot v0 device logs](logs.md) — Show logs for the specified device

- [yc iot v0 device remove-topic-aliases](remove-topic-aliases.md) — Remove aliases for topics of specified device

- [yc iot v0 device update](update.md) — Update specified device

- [yc iot v0 device certificate](certificate/index.md) — Manage IoT device certificates

  - [yc iot v0 device certificate add](certificate/add.md) — Add new certificate to specified device

  - [yc iot v0 device certificate delete](certificate/delete.md) — Delete specified certificate from device

  - [yc iot v0 device certificate list](certificate/list.md) — List certificates associated with specified device

- [yc iot v0 device password](password/index.md) — Manage IoT device passwords

  - [yc iot v0 device password add](password/add.md) — Add new password to specified device

  - [yc iot v0 device password delete](password/delete.md) — Delete specified password from specified device

  - [yc iot v0 device password list](password/list.md) — List passwords associated with specified device

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