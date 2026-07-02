[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > instance > Overview

# yc compute v0 instance

Manage virtual machine instances

#### Command Usage

Syntax:

`yc compute instance <command>`

Aliases:

- `instances`

#### Command Tree

- [yc compute v0 instance add-access-binding](add-access-binding.md) — Add access binding for the specified instance

- [yc compute v0 instance add-labels](add-labels.md) — Add labels to specified virtual machine instance

- [yc compute v0 instance add-metadata](add-metadata.md) — Add or update metadata for the specified virtual machine instance

- [yc compute v0 instance add-one-to-one-nat](add-one-to-one-nat.md) — Add one-to-one NAT to the specified network interface of virtual machine instance

- [yc compute v0 instance attach-disk](attach-disk.md) — Attach existing disk to the specified virtual machine instance

- [yc compute v0 instance attach-filesystem](attach-filesystem.md) — Attach existing filesystem to the specified virtual machine instance

- [yc compute v0 instance attach-network-interface](attach-network-interface.md) — Attach the specified network interface to the virtual machine instance

- [yc compute v0 instance create](create.md) — Create a virtual machine instance

- [yc compute v0 instance create-with-container](create-with-container.md) — Create a virtual machine instance running Docker container

- [yc compute v0 instance delete](delete.md) — Delete the specified virtual machine instance

- [yc compute v0 instance detach-disk](detach-disk.md) — Detach disk from the specified virtual machine instance

- [yc compute v0 instance detach-filesystem](detach-filesystem.md) — Detach filesystem from the specified virtual machine instance

- [yc compute v0 instance detach-network-interface](detach-network-interface.md) — Detach the specified network interface from the virtual machine instance

- [yc compute v0 instance get](get.md) — Show information about the specified virtual machine instance

- [yc compute v0 instance get-serial-port-output](get-serial-port-output.md) — Return the serial port output of the specified virtual machine instance

- [yc compute v0 instance list](list.md) — List virtual machine instances

- [yc compute v0 instance list-access-bindings](list-access-bindings.md) — List access bindings for the specified instance

- [yc compute v0 instance list-operations](list-operations.md) — List operations for the specified instance

- [yc compute v0 instance move](move.md) — Move the specified virtual machine instance into the folder

- [yc compute v0 instance relocate](relocate.md) — Relocate the specified virtual machine instance to the zone

- [yc compute v0 instance remove-access-binding](remove-access-binding.md) — Remove access binding for the specified instance

- [yc compute v0 instance remove-labels](remove-labels.md) — Remove labels from specified virtual machine instance

- [yc compute v0 instance remove-metadata](remove-metadata.md) — Remove keys from metadata for the specified virtual machine instance

- [yc compute v0 instance remove-one-to-one-nat](remove-one-to-one-nat.md) — Remove one-to-one NAT to the specified network interface of virtual machine instance

- [yc compute v0 instance restart](restart.md) — Restart the specified virtual machine instance

- [yc compute v0 instance set-access-bindings](set-access-bindings.md) — Set access bindings for the specified instance and delete all existing access bindings if there were any

- [yc compute v0 instance simulate-maintenance-event](simulate-maintenance-event.md) — Simulate a maintenance event (maintenance policy must be set)

- [yc compute v0 instance start](start.md) — Start the specified virtual machine instance

- [yc compute v0 instance stop](stop.md) — Stop the specified virtual machine instance

- [yc compute v0 instance update](update.md) — Update the specified virtual machine instance

- [yc compute v0 instance update-container](update-container.md) — Update the specified virtual machine instance running Docker container

- [yc compute v0 instance update-network-interface](update-network-interface.md) — Update the specified network interface of virtual machine instance

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