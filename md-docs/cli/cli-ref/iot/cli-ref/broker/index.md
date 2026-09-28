[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [iot](../index.md) > broker > Overview

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

  - [yc iot broker password delete](password/delete.md) — Delete specified password from broker

  - [yc iot broker password list](password/list.md) — List passwords associated with specified broker

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