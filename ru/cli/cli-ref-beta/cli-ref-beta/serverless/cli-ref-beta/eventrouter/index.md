---
editable: false
noIndex: true
---

# yc beta serverless eventrouter



#### Command Usage

Syntax:

`yc beta serverless eventrouter <group>`

#### Command Tree

- [yc beta serverless eventrouter bus](bus/index.md) — A set of methods for managing buses for serverless eventrouter.

  - [yc beta serverless eventrouter bus create](bus/create.md) — Creates a bus in the specified folder.

  - [yc beta serverless eventrouter bus delete](bus/delete.md) — Deletes the specified bus.

  - [yc beta serverless eventrouter bus get](bus/get.md) — Returns the specified bus.

  - [yc beta serverless eventrouter bus list](bus/list.md) — Retrieves the list of buses in the specified folder.

  - [yc beta serverless eventrouter bus list-access-bindings](bus/list-access-bindings.md) — Lists existing access bindings for the specified bus.

  - [yc beta serverless eventrouter bus list-operations](bus/list-operations.md) — Lists operations for the specified bus.

  - [yc beta serverless eventrouter bus set-access-bindings](bus/set-access-bindings.md) — Sets access bindings for the bus.

  - [yc beta serverless eventrouter bus update](bus/update.md) — Updates the specified bus.

  - [yc beta serverless eventrouter bus update-access-bindings](bus/update-access-bindings.md) — Updates access bindings for the specified bus.

- [yc beta serverless eventrouter connector](connector/index.md) — A set of methods for managing connectors for serverless eventrouter.

  - [yc beta serverless eventrouter connector create](connector/create.md) — Creates a connector in the specified folder.

  - [yc beta serverless eventrouter connector delete](connector/delete.md) — Deletes the specified connector.

  - [yc beta serverless eventrouter connector get](connector/get.md) — Returns the specified bus.

  - [yc beta serverless eventrouter connector list](connector/list.md) — Retrieves the list of connectors in the specified folder.

  - [yc beta serverless eventrouter connector list-access-bindings](connector/list-access-bindings.md) — Lists existing access bindings for the specified bus.

  - [yc beta serverless eventrouter connector list-operations](connector/list-operations.md) — Lists operations for the specified connector.

  - [yc beta serverless eventrouter connector set-access-bindings](connector/set-access-bindings.md) — Sets access bindings for the connector.

  - [yc beta serverless eventrouter connector start](connector/start.md) — Starts the specified connector.

  - [yc beta serverless eventrouter connector stop](connector/stop.md) — Stops the specified connector.

  - [yc beta serverless eventrouter connector update](connector/update.md) — Updates the specified connector.

  - [yc beta serverless eventrouter connector update-access-bindings](connector/update-access-bindings.md) — Updates access bindings for the specified connector.

- [yc beta serverless eventrouter event](event/index.md) — Service for put events to bus for serverless eventrouter.

  - [yc beta serverless eventrouter event put](event/put.md) — Puts event to bus.

  - [yc beta serverless eventrouter event send](event/send.md) — Send events to bus.

- [yc beta serverless eventrouter rule](rule/index.md) — A set of methods for managing rules for serverless eventrouter.

  - [yc beta serverless eventrouter rule create](rule/create.md) — Creates a rule in the specified folder.

  - [yc beta serverless eventrouter rule delete](rule/delete.md) — Deletes the specified rule.

  - [yc beta serverless eventrouter rule disable](rule/disable.md) — Disables the specified rule.

  - [yc beta serverless eventrouter rule enable](rule/enable.md) — Enables the specified rule.

  - [yc beta serverless eventrouter rule get](rule/get.md) — Returns the specified rules.

  - [yc beta serverless eventrouter rule list](rule/list.md) — Retrieves the list of rules in the specified folder.

  - [yc beta serverless eventrouter rule list-access-bindings](rule/list-access-bindings.md) — Lists existing access bindings for the specified rule.

  - [yc beta serverless eventrouter rule list-operations](rule/list-operations.md) — Lists operations for the specified rule.

  - [yc beta serverless eventrouter rule set-access-bindings](rule/set-access-bindings.md) — Sets access bindings for the rule.

  - [yc beta serverless eventrouter rule update](rule/update.md) — Updates the specified rule.

  - [yc beta serverless eventrouter rule update-access-bindings](rule/update-access-bindings.md) — Updates access bindings for the specified rule.

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