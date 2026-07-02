[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [iot](../index.md) > v0 > Overview

# yc iot v0

Manage Yandex IoT Core resources

#### Command Usage

Syntax:

`yc iot v0 <group>`

#### Command Tree

- [yc iot v0 broker](broker/index.md) — Manage IoT brokers

  - [yc iot v0 broker add-labels](broker/add-labels.md) — Add labels to specified broker

  - [yc iot v0 broker create](broker/create.md) — Create new broker

  - [yc iot v0 broker delete](broker/delete.md) — Delete specified broker

  - [yc iot v0 broker get](broker/get.md) — Show information about specified broker

  - [yc iot v0 broker list](broker/list.md) — List IoT brokers

  - [yc iot v0 broker logs](broker/logs.md) — Show logs for the specified broker

  - [yc iot v0 broker remove-labels](broker/remove-labels.md) — Remove labels from specified broker

  - [yc iot v0 broker update](broker/update.md) — Update specified broker

- [yc iot v0 device](device/index.md) — Manage IoT devices

  - [yc iot v0 device add-topic-aliases](device/add-topic-aliases.md) — Add aliases for topics of specified device

  - [yc iot v0 device create](device/create.md) — Create new device device

  - [yc iot v0 device delete](device/delete.md) — Delete specified device

  - [yc iot v0 device get](device/get.md) — Show information about specified device

  - [yc iot v0 device list](device/list.md) — List IoT devices

  - [yc iot v0 device logs](device/logs.md) — Show logs for the specified device

  - [yc iot v0 device remove-topic-aliases](device/remove-topic-aliases.md) — Remove aliases for topics of specified device

  - [yc iot v0 device update](device/update.md) — Update specified device

- [yc iot v0 mqtt](mqtt/index.md) — Exchange MQTT messages

  - [yc iot v0 mqtt publish](mqtt/publish.md) — Publish telemetry

  - [yc iot v0 mqtt subscribe](mqtt/subscribe.md) — Subscribe telemetry

- [yc iot v0 registry](registry/index.md) — Manage IoT registries

  - [yc iot v0 registry add-labels](registry/add-labels.md) — Add labels to specified registry

  - [yc iot v0 registry create](registry/create.md) — Create new device registry

  - [yc iot v0 registry delete](registry/delete.md) — Delete specified registry

  - [yc iot v0 registry disable](registry/disable.md) — Disable this registry

  - [yc iot v0 registry enable](registry/enable.md) — Enable this registry

  - [yc iot v0 registry get](registry/get.md) — Show information about specified registry

  - [yc iot v0 registry list](registry/list.md) — List IoT registries

  - [yc iot v0 registry list-device-topic-aliases](registry/list-device-topic-aliases.md) — List all topic aliases set for devices in this registry

  - [yc iot v0 registry logs](registry/logs.md) — Show logs for the specified registry

  - [yc iot v0 registry remove-labels](registry/remove-labels.md) — Remove labels from specified registry

  - [yc iot v0 registry update](registry/update.md) — Update specified registry

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