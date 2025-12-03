---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iot/cli-ref-beta/device/index.md
---

# yc beta iot device

A set of methods for managing devices.

#### Command Usage

Syntax: 

`yc beta iot device <command>`

#### Command Tree

- [yc beta iot device add-certificate](add-certificate.md) — Adds a certificate.
- [yc beta iot device add-password](add-password.md) — Adds password for the specified device.
- [yc beta iot device create](create.md) — Creates a device in the specified registry.
- [yc beta iot device delete](delete.md) — Deletes the specified device.
- [yc beta iot device delete-certificate](delete-certificate.md) — Deletes the specified device certificate.
- [yc beta iot device delete-password](delete-password.md) — Deletes the specified password.
- [yc beta iot device get](get.md) — Returns the specified device.
- [yc beta iot device get-by-name](get-by-name.md) — 
- [yc beta iot device list](list.md) — Retrieves the list of devices in the specified registry.
- [yc beta iot device list-certificates](list-certificates.md) — Retrieves the list of device certificates for the specified device.
- [yc beta iot device list-operations](list-operations.md) — Lists operations for the specified device.
- [yc beta iot device list-passwords](list-passwords.md) — Retrieves the list of passwords for the specified device.
- [yc beta iot device update](update.md) — Updates the specified device.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
