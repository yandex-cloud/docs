# yc iot broker

Manage IoT brokers

#### Command Usage

Syntax:

`yc iot broker <group|command>`

Aliases:

- `brokers`

#### Command Tree

- [yc iot broker add-labels](add-labels.md) — Add labels to specified broker

- [yc iot broker create](create.md) — Create new broker

- [yc iot broker delete](delete.md) — Delete specified broker

- [yc iot broker get](get.md) — Show information about specified broker

- [yc iot broker list](list.md) — List IoT brokers

- [yc iot broker logs](logs.md) — Show logs for the specified broker

- [yc iot broker remove-labels](remove-labels.md) — Remove labels from specified broker

- [yc iot broker update](update.md) — Update specified broker

- [yc iot broker certificate](certificate/index.md) — Manage IoT broker certificates

  - [yc iot broker certificate add](certificate/add.md) — Add new certificate to specified broker

  - [yc iot broker certificate delete](certificate/delete.md) — Delete specified certificate from broker

  - [yc iot broker certificate list](certificate/list.md) — List certificates associated with specified broker

- [yc iot broker password](password/index.md) — Manage IoT broker passwords

  - [yc iot broker password add](password/add.md) — Add new password to specified broker

  - [yc iot broker password delete](password/delete.md) — Delete specified password from specified broker

  - [yc iot broker password list](password/list.md) — List passwords associated with specified broker

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