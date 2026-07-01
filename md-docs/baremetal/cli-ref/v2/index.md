# yc baremetal v2

Manage Baremetal resources

#### Command Usage

Syntax:

`yc baremetal v2 <group|command>`

#### Command Tree

- [yc baremetal v2 configuration](configuration.md) — A set of methods to retrieve information about Configuration resources.

- [yc baremetal v2 extend](extend/index.md) — 



- [yc baremetal v2 hardware-pool](hardware-pool/index.md) — A set of methods to retrieve information about HardwarePool resources.

  - [yc baremetal v2 hardware-pool get](hardware-pool/get.md) — Returns the specific HardwarePool resource.

  - [yc baremetal v2 hardware-pool list](hardware-pool/list.md) — Retrieves the list of HardwarePool resources.

- [yc baremetal v2 private-subnet](private-subnet/index.md) — A set of methods for managing PrivateSubnet resources.

  - [yc baremetal v2 private-subnet create](private-subnet/create.md) — Creates a private subnet in the specified folder.

  - [yc baremetal v2 private-subnet delete](private-subnet/delete.md) — Deletes the specified private subnet.

  - [yc baremetal v2 private-subnet get](private-subnet/get.md) — Returns the specific PrivateSubnet resource.

  - [yc baremetal v2 private-subnet list](private-subnet/list.md) — Retrieves the list of PrivateSubnet resources in the specified folder.

  - [yc baremetal v2 private-subnet update](private-subnet/update.md) — Updates the specified private subnet.

- [yc baremetal v2 public-prefix-pool](public-prefix-pool/index.md) — A set of methods for managing PublicPrefixPool resources.

  - [yc baremetal v2 public-prefix-pool get](public-prefix-pool/get.md) — Returns the specified public prefix pool.

  - [yc baremetal v2 public-prefix-pool list](public-prefix-pool/list.md) — Lists public prefix pools in the specified folder.

  - [yc baremetal v2 public-prefix-pool update](public-prefix-pool/update.md) — Updates the specified public prefix pool.

- [yc baremetal v2 public-subnet](public-subnet/index.md) — A set of methods for managing PublicSubnet resources.

  - [yc baremetal v2 public-subnet create](public-subnet/create.md) — Creates a public subnet in the specified folder.

  - [yc baremetal v2 public-subnet delete](public-subnet/delete.md) — Deletes the specified public subnet.

  - [yc baremetal v2 public-subnet get](public-subnet/get.md) — Returns the specific PublicSubnet resource.

  - [yc baremetal v2 public-subnet list](public-subnet/list.md) — Retrieves the list of PublicSubnet resources in the specified folder.

  - [yc baremetal v2 public-subnet update](public-subnet/update.md) — Updates the specified public subnet.

- [yc baremetal v2 rental-period](rental-period/index.md) — A set of methods to retrieve information about RentalPeriod resources.

  - [yc baremetal v2 rental-period list](rental-period/list.md) — Retrieves the list of RentalPeriod resources.

- [yc baremetal v2 server](server/index.md) — A set of methods for managing Server resources.

  - [yc baremetal v2 server batch-create](server/batch-create.md) — Creates multiple servers in the specified folder.

  - [yc baremetal v2 server create](server/create.md) — Creates a server in the specified folder.

  - [yc baremetal v2 server get](server/get.md) — Returns the specific Server resource.

  - [yc baremetal v2 server list](server/list.md) — Retrieves the list of Server resources in the specified folder.

  - [yc baremetal v2 server power-off](server/power-off.md) — Powers off the specified server.

  - [yc baremetal v2 server power-on](server/power-on.md) — Powers on the specified server.

  - [yc baremetal v2 server reboot](server/reboot.md) — Reboots the specified server.

  - [yc baremetal v2 server reinstall](server/reinstall.md) — Reinstalls the specified server.

  - [yc baremetal v2 server renew-rental](server/renew-rental.md) — Enable prolongation after rental period end

  - [yc baremetal v2 server update](server/update.md) — Updates the specified server.

- [yc baremetal v2 vrf](vrf/index.md) — A set of methods for managing VRF resources.

  - [yc baremetal v2 vrf create](vrf/create.md) — Creates a VRF in the specified folder.

  - [yc baremetal v2 vrf delete](vrf/delete.md) — Deletes the specified VRF resource.

  - [yc baremetal v2 vrf get](vrf/get.md) — Returns the specific VRF resource.

  - [yc baremetal v2 vrf list](vrf/list.md) — Retrieves the list of VRF resources in the specified folder.

  - [yc baremetal v2 vrf update](vrf/update.md) — Updates the specified VRF resource.

- [yc baremetal v2 zone](zone/index.md) — A set of methods to retrieve information about availability zones.

  - [yc baremetal v2 zone get](zone/get.md) — Returns the specific Zone resource.

  - [yc baremetal v2 zone list](zone/list.md) — Retrieves the list of Zone resources.

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