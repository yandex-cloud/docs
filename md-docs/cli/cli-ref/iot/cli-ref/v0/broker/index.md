# yc iot v0 broker

Manage IoT brokers

#### Command Usage

Syntax:

`yc iot broker <group|command>`

Aliases:

- `brokers`

#### Command Tree

- [yc iot v0 broker add-labels](add-labels.md) — Add labels to specified broker

- [yc iot v0 broker create](create.md) — Create new broker

- [yc iot v0 broker delete](delete.md) — Delete specified broker

- [yc iot v0 broker get](get.md) — Show information about specified broker

- [yc iot v0 broker list](list.md) — List IoT brokers

- [yc iot v0 broker logs](logs.md) — Show logs for the specified broker

- [yc iot v0 broker remove-labels](remove-labels.md) — Remove labels from specified broker

- [yc iot v0 broker update](update.md) — Update specified broker

- [yc iot v0 broker certificate](certificate/index.md) — Manage IoT broker certificates

  - [yc iot v0 broker certificate add](certificate/add.md) — Add new certificate to specified broker

  - [yc iot v0 broker certificate delete](certificate/delete.md) — Delete specified certificate from broker

  - [yc iot v0 broker certificate list](certificate/list.md) — List certificates associated with specified broker

- [yc iot v0 broker password](password/index.md) — Manage IoT broker passwords

  - [yc iot v0 broker password add](password/add.md) — Add new password to specified broker

  - [yc iot v0 broker password delete](password/delete.md) — Delete specified password from specified broker

  - [yc iot v0 broker password list](password/list.md) — List passwords associated with specified broker

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