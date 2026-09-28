[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [iot](../index.md) > device > Overview

# yc iot device

Manage IoT devices

#### Command Usage

Syntax:

`yc iot device <group|command>`

Aliases:

- `devices`

#### Command Tree

- [yc iot device add-topic-aliases](add-topic-aliases.md) — Add aliases for topics of specified device

- [yc iot device create](create.md) — Create new device device

- [yc iot device delete](delete.md) — Delete specified device

- [yc iot device get](get.md) — Show information about specified device

- [yc iot device list](list.md) — List IoT devices

- [yc iot device logs](logs.md) — Show logs for the specified device

- [yc iot device remove-topic-aliases](remove-topic-aliases.md) — Remove aliases for topics of specified device

- [yc iot device update](update.md) — Update specified device

- [yc iot device certificate](certificate/index.md) — Manage IoT device certificates

  - [yc iot device certificate add](certificate/add.md) — Add new certificate to specified device

  - [yc iot device certificate delete](certificate/delete.md) — Delete specified certificate from device

  - [yc iot device certificate list](certificate/list.md) — List certificates associated with specified device

- [yc iot device password](password/index.md) — Manage IoT device passwords

  - [yc iot device password add](password/add.md) — Add new password to specified device

  - [yc iot device password delete](password/delete.md) — Delete specified password from device

  - [yc iot device password list](password/list.md) — List passwords associated with specified device

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