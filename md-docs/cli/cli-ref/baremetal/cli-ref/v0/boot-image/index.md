[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [baremetal](../../index.md) > [v0](../index.md) > boot-image > Overview

# yc baremetal v0 boot-image

Manage images

#### Command Usage

Syntax:

`yc baremetal boot-image <command>`

#### Command Tree

- [yc baremetal v0 boot-image add-labels](add-labels.md) — Add labels to specified boot-image

- [yc baremetal v0 boot-image create](create.md) — Create an boot-image

- [yc baremetal v0 boot-image delete](delete.md) — Delete the specified boot-image

- [yc baremetal v0 boot-image get](get.md) — Show information about the specified boot-image

- [yc baremetal v0 boot-image list](list.md) — List boot-images

- [yc baremetal v0 boot-image list-operations](list-operations.md) — List operations for the specified boot-image

- [yc baremetal v0 boot-image remove-labels](remove-labels.md) — Remove labels from specified boot-image

- [yc baremetal v0 boot-image update](update.md) — Update the specified boot-image

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