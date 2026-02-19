---
editable: false
noIndex: true
---

# yc beta iot

Manage IoT Core resources

#### Command Usage

Syntax:

`yc beta iot <group>`

#### Command Tree

- [yc beta iot broker](broker/index.md) — A set of methods for managing broker.

  - [yc beta iot broker add-certificate](broker/add-certificate.md) — Adds a certificate.

  - [yc beta iot broker add-password](broker/add-password.md) — Adds password for the specified broker.

  - [yc beta iot broker create](broker/create.md) — Creates a broker in the specified folder.

  - [yc beta iot broker delete](broker/delete.md) — Deletes the specified broker.

  - [yc beta iot broker delete-certificate](broker/delete-certificate.md) — Deletes the specified broker certificate.

  - [yc beta iot broker delete-password](broker/delete-password.md) — Deletes the specified password.

  - [yc beta iot broker get](broker/get.md) — Returns the specified broker.

  - [yc beta iot broker list](broker/list.md) — Retrieves the list of brokers in the specified folder.

  - [yc beta iot broker list-certificates](broker/list-certificates.md) — Retrieves the list of broker certificates for the specified broker.

  - [yc beta iot broker list-operations](broker/list-operations.md) — Lists operations for the specified broker.

  - [yc beta iot broker list-passwords](broker/list-passwords.md) — Retrieves the list of passwords for the specified broker.

  - [yc beta iot broker update](broker/update.md) — Updates the specified broker.

- [yc beta iot broker-data](broker-data/index.md) — A set of methods to work with IoT Core messages on behalf of broker

  - [yc beta iot broker-data publish](broker-data/publish.md) — Publishes message on behalf of specified broker

- [yc beta iot device](device/index.md) — A set of methods for managing devices.

  - [yc beta iot device add-certificate](device/add-certificate.md) — Adds a certificate.

  - [yc beta iot device add-password](device/add-password.md) — Adds password for the specified device.

  - [yc beta iot device create](device/create.md) — Creates a device in the specified registry.

  - [yc beta iot device delete](device/delete.md) — Deletes the specified device.

  - [yc beta iot device delete-certificate](device/delete-certificate.md) — Deletes the specified device certificate.

  - [yc beta iot device delete-password](device/delete-password.md) — Deletes the specified password.

  - [yc beta iot device get](device/get.md) — Returns the specified device.

  - [yc beta iot device get-by-name](device/get-by-name.md) — 

  - [yc beta iot device list](device/list.md) — Retrieves the list of devices in the specified registry.

  - [yc beta iot device list-certificates](device/list-certificates.md) — Retrieves the list of device certificates for the specified device.

  - [yc beta iot device list-operations](device/list-operations.md) — Lists operations for the specified device.

  - [yc beta iot device list-passwords](device/list-passwords.md) — Retrieves the list of passwords for the specified device.

  - [yc beta iot device update](device/update.md) — Updates the specified device.

- [yc beta iot device-data](device-data/index.md) — A set of methods to work with IoT Core messages on behalf of device

  - [yc beta iot device-data publish](device-data/publish.md) — Publishes message on behalf of specified device

- [yc beta iot registry](registry/index.md) — A set of methods for managing registry.

  - [yc beta iot registry add-certificate](registry/add-certificate.md) — Adds a certificate.

  - [yc beta iot registry add-data-stream-export](registry/add-data-stream-export.md) — Adds YDS export for the specified registry.

  - [yc beta iot registry add-password](registry/add-password.md) — Adds password for the specified registry.

  - [yc beta iot registry create](registry/create.md) — Creates a registry in the specified folder.

  - [yc beta iot registry delete](registry/delete.md) — Deletes the specified registry.

  - [yc beta iot registry delete-certificate](registry/delete-certificate.md) — Deletes the specified registry certificate.

  - [yc beta iot registry delete-data-stream-export](registry/delete-data-stream-export.md) — Deletes the specified YDS export.

  - [yc beta iot registry delete-password](registry/delete-password.md) — Deletes the specified password.

  - [yc beta iot registry disable](registry/disable.md) — Disables the specified registry.

  - [yc beta iot registry enable](registry/enable.md) — Enables the specified registry.

  - [yc beta iot registry get](registry/get.md) — Returns the specified registry.

  - [yc beta iot registry get-by-name](registry/get-by-name.md) — 

  - [yc beta iot registry list](registry/list.md) — Retrieves the list of registries in the specified folder.

  - [yc beta iot registry list-certificates](registry/list-certificates.md) — Retrieves the list of registry certificates for the specified registry.

  - [yc beta iot registry list-data-stream-exports](registry/list-data-stream-exports.md) — Retrieves the list of YDS exports for the specified registry.

  - [yc beta iot registry list-device-topic-aliases](registry/list-device-topic-aliases.md) — Retrieves the list of device topic aliases for the specified registry.

  - [yc beta iot registry list-operations](registry/list-operations.md) — Lists operations for the specified registry.

  - [yc beta iot registry list-passwords](registry/list-passwords.md) — Retrieves the list of passwords for the specified registry.

  - [yc beta iot registry update](registry/update.md) — Updates the specified registry.

- [yc beta iot registry-data](registry-data/index.md) — A set of methods to work with IoT Core messages on behalf of registry

  - [yc beta iot registry-data publish](registry-data/publish.md) — Publishes message on behalf of specified registry

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