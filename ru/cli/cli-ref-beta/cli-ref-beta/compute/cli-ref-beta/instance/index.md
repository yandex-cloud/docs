---
editable: false
noIndex: true
---

# yc beta compute instance

A set of methods for managing Instance resources.

#### Command Usage

Syntax:

`yc beta compute instance <command>`

#### Command Tree

- [yc beta compute instance add-one-to-one-nat](add-one-to-one-nat.md) — Enables One-to-one NAT on the network interface.

- [yc beta compute instance attach-disk](attach-disk.md) — Attaches the disk to the instance.

- [yc beta compute instance attach-filesystem](attach-filesystem.md) — Attaches the filesystem to the instance.

- [yc beta compute instance attach-network-interface](attach-network-interface.md) — Attaches the network-interface to the instance.

- [yc beta compute instance create](create.md) — Creates an instance in the specified folder.

- [yc beta compute instance delete](delete.md) — Deletes the specified instance.

- [yc beta compute instance detach-disk](detach-disk.md) — Detaches the disk from the instance.

- [yc beta compute instance detach-filesystem](detach-filesystem.md) — Detaches the filesystem from the instance.

- [yc beta compute instance detach-network-interface](detach-network-interface.md) — Detaches the network-interface to the instance.

- [yc beta compute instance get](get.md) — Returns the specified Instance resource.

- [yc beta compute instance get-serial-port-output](get-serial-port-output.md) — Returns the serial port output of the specified Instance resource.

- [yc beta compute instance list](list.md) — Retrieves the list of Instance resources in the specified folder.

- [yc beta compute instance list-access-bindings](list-access-bindings.md) — Lists access bindings for the instance.

- [yc beta compute instance list-operations](list-operations.md) — Lists operations for the specified instance.

- [yc beta compute instance move](move.md) — Moves the specified instance to another folder of the same cloud.

- [yc beta compute instance relocate](relocate.md) — Moves the specified instance to another availability zone

- [yc beta compute instance remove-one-to-one-nat](remove-one-to-one-nat.md) — Removes One-to-one NAT from the network interface.

- [yc beta compute instance restart](restart.md) — Restarts the running instance.

- [yc beta compute instance set-access-bindings](set-access-bindings.md) — Sets access bindings for the instance.

- [yc beta compute instance simulate-maintenance-event](simulate-maintenance-event.md) — 

- [yc beta compute instance start](start.md) — Starts the stopped instance.

- [yc beta compute instance stop](stop.md) — Stops the running instance.

- [yc beta compute instance update](update.md) — Updates the specified instance.

- [yc beta compute instance update-access-bindings](update-access-bindings.md) — Updates access bindings for the instance.

- [yc beta compute instance update-metadata](update-metadata.md) — Updates the metadata of the specified instance. For more information on metadata, see [VM metadata](/docs/compute/concepts/vm-metadata).

- [yc beta compute instance update-network-interface](update-network-interface.md) — Updates the specified instance network interface.

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