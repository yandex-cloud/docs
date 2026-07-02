[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > Концепции > Настройка и управление > Справочник CLI (англ.) > Overview

# yc baremetal

Manage Baremetal resources

Command tree v1 (new CLI interface) is the default. Run `yc baremetal v1 <command>`.
Legacy command tree v0 is also available: `yc baremetal v0 <command>`.
Set `services.baremetal.version: v0` or `services.baremetal.version: v1` in your profile to change the default.

#### Command Usage

Syntax:

`yc baremetal <group>`

#### Command Tree

- [yc baremetal boot-image](boot-image/index.md) — A set of methods for managing Image resources.

  - [yc baremetal boot-image create](boot-image/create.md) — Creates an image in the specified folder.

  - [yc baremetal boot-image delete](boot-image/delete.md) — Deletes the specified image.

  - [yc baremetal boot-image get](boot-image/get.md) — Returns the specific Image resource.

  - [yc baremetal boot-image list](boot-image/list.md) — Retrieves the list of Image resources in the specified folder.

  - [yc baremetal boot-image list-operations](boot-image/list-operations.md) — Lists operations for the specified image.

  - [yc baremetal boot-image update](boot-image/update.md) — Updates the specified image.

- [yc baremetal configuration](configuration/index.md) — A set of methods to retrieve information about Configuration resources.

  - [yc baremetal configuration get](configuration/get.md) — Returns the specific Configuration resource.

  - [yc baremetal configuration list](configuration/list.md) — Retrieves the list of Configuration resources.

  - [yc baremetal configuration list-configuration-network-interface](configuration/list-configuration-network-interface.md) — Retrieves the list of ConfigurationNetworkInterface resources.

- [yc baremetal hardware-pool](hardware-pool/index.md) — A set of methods to retrieve information about HardwarePool resources.

  - [yc baremetal hardware-pool get](hardware-pool/get.md) — Returns the specific HardwarePool resource.

  - [yc baremetal hardware-pool list](hardware-pool/list.md) — Retrieves the list of HardwarePool resources.

- [yc baremetal mounted-image](mounted-image/index.md) — A set of methods for managing Image mounting.

  - [yc baremetal mounted-image create](mounted-image/create.md) — Mount user image.

  - [yc baremetal mounted-image delete](mounted-image/delete.md) — Unmount user image.

  - [yc baremetal mounted-image get](mounted-image/get.md) — Get mounted user image.

- [yc baremetal private-cloud-connection](private-cloud-connection/index.md) — A set of methods for managing Private cloud connection resources.

  - [yc baremetal private-cloud-connection create](private-cloud-connection/create.md) — Creates a private cloud connection in the specified folder.

  - [yc baremetal private-cloud-connection delete](private-cloud-connection/delete.md) — Removes a private cloud connection and all allocated network resouces

  - [yc baremetal private-cloud-connection get](private-cloud-connection/get.md) — Returns the specific Private cloud connection resource.

  - [yc baremetal private-cloud-connection list](private-cloud-connection/list.md) — Retrieves the list of Private cloud connection resources in the specified folder.

  - [yc baremetal private-cloud-connection update](private-cloud-connection/update.md) — Updates the routing_instance_id in a private cloud connection.

- [yc baremetal private-subnet](private-subnet/index.md) — A set of methods for managing PrivateSubnet resources.

  - [yc baremetal private-subnet create](private-subnet/create.md) — Creates a private subnet in the specified folder.

  - [yc baremetal private-subnet delete](private-subnet/delete.md) — Deletes the specified private subnet.

  - [yc baremetal private-subnet get](private-subnet/get.md) — Returns the specific PrivateSubnet resource.

  - [yc baremetal private-subnet list](private-subnet/list.md) — Retrieves the list of PrivateSubnet resources in the specified folder.

  - [yc baremetal private-subnet list-operations](private-subnet/list-operations.md) — Lists operations for the specified private subnet.

  - [yc baremetal private-subnet update](private-subnet/update.md) — Updates the specified private subnet.

- [yc baremetal public-prefix-pool](public-prefix-pool/index.md) — 

  - [yc baremetal public-prefix-pool get](public-prefix-pool/get.md) — Returns the specified public prefix pool.

  - [yc baremetal public-prefix-pool list](public-prefix-pool/list.md) — Lists public prefix pools in the specified folder.

  - [yc baremetal public-prefix-pool list-operations](public-prefix-pool/list-operations.md) — Lists operations for the specified public prefix pool.

  - [yc baremetal public-prefix-pool update](public-prefix-pool/update.md) — Updates the specified public prefix pool.

- [yc baremetal public-subnet](public-subnet/index.md) — A set of methods for managing PublicSubnet resources.

  - [yc baremetal public-subnet create](public-subnet/create.md) — Creates a public subnet in the specified folder.

  - [yc baremetal public-subnet delete](public-subnet/delete.md) — Deletes the specified public subnet.

  - [yc baremetal public-subnet get](public-subnet/get.md) — Returns the specific PublicSubnet resource.

  - [yc baremetal public-subnet list](public-subnet/list.md) — Retrieves the list of PublicSubnet resources in the specified folder.

  - [yc baremetal public-subnet list-operations](public-subnet/list-operations.md) — Lists operations for the specified public subnet.

  - [yc baremetal public-subnet update](public-subnet/update.md) — Updates the specified public subnet.

- [yc baremetal rental-period](rental-period/index.md) — A set of methods to retrieve information about RentalPeriod resources.

  - [yc baremetal rental-period list](rental-period/list.md) — Retrieves the list of RentalPeriod resources.

- [yc baremetal server](server/index.md) — A set of methods for managing Server resources.

  - [yc baremetal server batch-create](server/batch-create.md) — Creates multiple servers in the specified folder.

  - [yc baremetal server create](server/create.md) — Creates a server in the specified folder.

  - [yc baremetal server get](server/get.md) — Returns the specific Server resource.

  - [yc baremetal server list](server/list.md) — Retrieves the list of Server resources in the specified folder.

  - [yc baremetal server list-operations](server/list-operations.md) — Lists operations for the specified server.

  - [yc baremetal server power-off](server/power-off.md) — Powers off the specified server.

  - [yc baremetal server power-on](server/power-on.md) — Powers on the specified server.

  - [yc baremetal server prolongate-ended-rent](server/prolongate-ended-rent.md) — Enable prolongation after rental period end

  - [yc baremetal server reboot](server/reboot.md) — Reboots the specified server.

  - [yc baremetal server reinstall](server/reinstall.md) — Reinstalls the specified server.

  - [yc baremetal server start-prolongation](server/start-prolongation.md) — Starts prolongation of the specified server.

  - [yc baremetal server stop-prolongation](server/stop-prolongation.md) — Stops prolongation of the specified server.

  - [yc baremetal server update](server/update.md) — Updates the specified server.

- [yc baremetal standard-image](standard-image/index.md) — A set of methods to retrieve information about standard image .

  - [yc baremetal standard-image get](standard-image/get.md) — Returns the specific standard Image resource.

  - [yc baremetal standard-image list](standard-image/list.md) — Retrieves the list of Image resources in the specified folder. Pass the "baremetal-standard-images" folder to get general images.

- [yc baremetal storage](storage/index.md) — A set of methods to retrieve information about default storages.

  - [yc baremetal storage batch-get-default](storage/batch-get-default.md) — Returns the default storages for the specified configurations.

  - [yc baremetal storage get-default](storage/get-default.md) — Returns the default storage for the specified configuration.

- [yc baremetal v0](v0/index.md) — (legacy command tree) Manage Baremetal resources



- [yc baremetal v1alpha](v1alpha/index.md) — Manage Baremetal resources



- [yc baremetal v2](v2/index.md) — Manage Baremetal resources

  - [yc baremetal v2 configuration](v2/configuration.md) — A set of methods to retrieve information about Configuration resources.

- [yc baremetal vrf](vrf/index.md) — A set of methods for managing VRF resources.

  - [yc baremetal vrf create](vrf/create.md) — Creates a VRF in the specified folder.

  - [yc baremetal vrf delete](vrf/delete.md) — Deletes the specified VRF resource.

  - [yc baremetal vrf get](vrf/get.md) — Returns the specific VRF resource.

  - [yc baremetal vrf list](vrf/list.md) — Retrieves the list of VRF resources in the specified folder.

  - [yc baremetal vrf list-operations](vrf/list-operations.md) — Lists operations for the specified VRF.

  - [yc baremetal vrf update](vrf/update.md) — Updates the specified VRF resource.

- [yc baremetal zone](zone/index.md) — A set of methods to retrieve information about availability zones.

  - [yc baremetal zone get](zone/get.md) — Returns the specific Zone resource.

  - [yc baremetal zone list](zone/list.md) — Retrieves the list of Zone resources.

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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#