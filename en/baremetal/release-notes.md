---
title: '{{ baremetal-full-name }} release notes'
description: This section contains the {{ baremetal-name }} release notes.
---

# {{ baremetal-full-name }} release notes

## Q2 2026 {#q2-2026}

* Published the new [REST API v2 reference](./api-ref/authentication.md) for {{ baremetal-name }}.
* [{{ yandex-cloud }} CLI](../cli/quickstart.md): Added a command branch for {{ baremetal-name }} with the new `yc baremetal v2` syntax.
* Described [scenarios for using {{ baremetal-name }} together with other {{ yandex-cloud }} services](./concepts/integrations.md).
* Enabled switching server network interfaces between public and private [network types](./operations/servers/switch-network-type.md).
* Added support for [deleting dedicated public subnets](./operations/delete-public-subnet.md).
* Introduced cost-effective, [pre-assembled stock server configurations](./concepts/server-configurations.md).
* Added the ability to pre-fill order forms for [custom configuration](./concepts/server-custom-configurations.md) servers from a template.
* Described the [disk types](./concepts/disks/disk-types.md) and [RAID implementation methods](./concepts/disks/raid.md) supported in {{ baremetal-name }} servers.
* Implemented a new ISO image mounting method in the [KVM console](./operations/servers/reinstall-os-from-own-image.md#boot-from-image).
* Updated [restrictions](./concepts/network-restrictions.md) for ports blocked in {{ baremetal-name }}.
* Added [{{ at-name }} management events](./at-ref.md) for the ExternalFlow network.

## Q1 2026 {#q1-2026}

* Supported [static routes](./operations/create-static-route.md) within {{ baremetal-name }} private networks.
* Added the ability to [connect multiple private subnets to a single server](./operations/servers/set-up-tagged-vlan.md).
* Added the [Management console](./concepts/console.md) section to {{ baremetal-name }} concepts.
* Introduced [on-request server configurations](./concepts/server-individual-configurations.md).
* Added the `Deleting` status to the [server lifecycle](./concepts/servers.md).
* Added warnings regarding the [BMC and BIOS configuration modifications](./concepts/server-advanced-settings.md).
* [{{ yandex-cloud }} CLI](../cli/quickstart.md):
  * Added the `ephemeral-public-subnet` option to the `--network-interfaces` parameter in the `yc baremetal server create` and `yc baremetal server update` commands to explicitly specify an ephemeral public subnet.
  * Added the `yc baremetal public-prefix-pool` command to manage the pool of public IP prefixes.
  * Added the `yc baremetal vrf update` command to manage VRF static routes.
  * Added the `yc baremetal public-subnet create --cidr-auto-allocation` and `yc baremetal public-subnet create --cidr-manual-allocation` commands to select the method for public subnet CIDR block allocation.

## Q4 2025 {#q4-2025}

* Introduced [custom server configurations](./concepts/server-custom-configurations.md) with tailored CPU, RAM, disk, and network card specifications.
* Enabled [connecting a {{ baremetal-name }} server to a {{ managed-k8s-name }} cluster](./concepts/integrations.md) as an external node.
* Added the ability to [expand the traffic package in public subnets](./concepts/network-restrictions.md), including via the management console.
* Updated [MAC address limits](./concepts/network-restrictions.md) for server network interfaces.
* [{{ yandex-cloud }} CLI](../cli/quickstart.md): Added the `yc baremetal private-cloud-connection` command for managing private connections to cloud networks.

## Q3 2025 {#q3-2025}

* Published the [REST API reference](./api-ref/authentication.md) for {{ baremetal-name }}.
* Supported [MC-LAG network redundancy](./concepts/mc-lag.md). Added a guide on [manual MC-LAG configuration](./operations/servers/set-up-mc-lag.md).
* Expanded documentation on [OS images](./concepts/images.md) and [custom ISO image installations](./operations/servers/reinstall-os-from-own-image.md), including using {{ objstorage-name }}.
* Added documentation covering the use of built-in [RAID on x9drw and x10drw servers](./concepts/disks/raid.md).
* Updated [network](./concepts/limits.md) and disk limits.
* [{{ yandex-cloud }} CLI](../cli/quickstart.md):
  * Added the `yc baremetal image` command group to manage images.
  * Added the `yc baremetal rental-period list` command to get available server rental periods.

## Q2 2025 {#q2-2025}

* Released {{ baremetal-full-name }} to [General Availability](../overview/concepts/launch-stages.md).
* Supported connecting a server to [{{ backup-name }}](./operations/backup-baremetal.md) while placing the order.
* Added documentation covering the [ephemeral public subnet lifecycle](./concepts/public-network.md).
* Described the [HWCheck](./operations/servers/use-hwatcher.md) script for independent server state analysis, and added a section on [disk health checks](./concepts/smart-disk-analysis.md).
