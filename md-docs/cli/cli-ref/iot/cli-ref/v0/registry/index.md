[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [iot](../../index.md) > [v0](../index.md) > registry > Overview

# yc iot v0 registry

Manage IoT registries

#### Command Usage

Syntax:

`yc iot v0 registry <group|command>`

Aliases:

- `registries`

#### Command Tree

- [yc iot v0 registry add-labels](add-labels.md) — Add labels to specified registry

- [yc iot v0 registry create](create.md) — Create new device registry

- [yc iot v0 registry delete](delete.md) — Delete specified registry

- [yc iot v0 registry disable](disable.md) — Disable this registry

- [yc iot v0 registry enable](enable.md) — Enable this registry

- [yc iot v0 registry get](get.md) — Show information about specified registry

- [yc iot v0 registry list](list.md) — List IoT registries

- [yc iot v0 registry list-device-topic-aliases](list-device-topic-aliases.md) — List all topic aliases set for devices in this registry

- [yc iot v0 registry logs](logs.md) — Show logs for the specified registry

- [yc iot v0 registry remove-labels](remove-labels.md) — Remove labels from specified registry

- [yc iot v0 registry update](update.md) — Update specified registry

- [yc iot v0 registry certificate](certificate/index.md) — Manage IoT registry certificates

  - [yc iot v0 registry certificate add](certificate/add.md) — Add new certificate to specified registry

  - [yc iot v0 registry certificate delete](certificate/delete.md) — Delete specified certificate from registry

  - [yc iot v0 registry certificate list](certificate/list.md) — List certificates associated with specified registry

- [yc iot v0 registry password](password/index.md) — Manage IoT registry passwords

  - [yc iot v0 registry password add](password/add.md) — Add new password to specified registry

  - [yc iot v0 registry password delete](password/delete.md) — Delete specified password from registry

  - [yc iot v0 registry password list](password/list.md) — List passwords associated with specified registry

- [yc iot v0 registry yds-export](yds-export/index.md) — Manage IoT device registry YDS exports

  - [yc iot v0 registry yds-export add](yds-export/add.md) — Add new data stream export to specified registry

  - [yc iot v0 registry yds-export delete](yds-export/delete.md) — Delete specified data stream export from specified registry

  - [yc iot v0 registry yds-export list](yds-export/list.md) — List data stream exports associated with specified registry

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