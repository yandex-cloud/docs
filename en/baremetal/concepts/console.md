---
title: '{{ baremetal-full-name }} management console'
description: In this section, you will learn about the capabilities you get from the {{ yandex-cloud }} management console to work with {{ baremetal-full-name }} servers.
---

# {{ baremetal-name }} management console

The [management console](../../console/index.yaml) is a user [interface]({{ link-console-main }}) allowing you to manage the {{ baremetal-full-name }} resources.

The {{ baremetal-name }} management console consists of the following sections:

#### ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.baremetal.label_servers_sCNgb }}** {#servers}

This section is where you [rent](../operations/servers/server-lease.md) {{ baremetal-name }} servers, [edit](../operations/servers/server-update.md) their basic settings, [start, restart, and stop](../operations/servers/server-stop-and-start.md) servers, [reinstall](../operations/servers/reinstall-os-from-marketplace.md) their operating system, and [terminate](../operations/servers/server-lease-cancel.md) their rent.

Additionally, this section gives each {{ baremetal-name }} server a [KVM console](../operations/servers/server-kvm.md), which is a specialized UI where you can manage the server at the OS level, edit its [additional settings](./server-advanced-settings.md), start it from bootable media, and [install](../operations/servers/reinstall-os-from-own-image.md) operating systems and other software from [custom images](./images.md#user-images).

For more information about {{ baremetal-name }} servers, see [{#T}](./servers.md).

#### ![nodes-right](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}** {#subnets}

This section is where you manage [private subnets](./private-network.md#private-subnet) and their settings.

A private subnet is a [virtual local area network (VLAN)](https://en.wikipedia.org/wiki/VLAN) that groups {{ baremetal-name }} servers together within one [server pool](./servers.md#server-pools) at L2 [OSI](https://en.wikipedia.org/wiki/OSI_model) level. This network is physically isolated from the internet and logically from other users' virtual networks.

For more information about private subnets, see [{#T}](./private-network.md).

#### ![vector-square](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** {#vrfs}

This section is where you manage [virtual network segments](./private-network.md#vrf-segment), [static routes](./private-network.md#static-routes), and [private connections](./private-network.md#vrf-segment) to cloud networks.

Virtual network segments (VRFs) provide OSI L3 network connectivity. VRFs enable connectivity between {{ baremetal-name }} servers located in different server pools, as well as between {{ baremetal-name }} servers and other {{ yandex-cloud }} resources.

For more information about virtual network segments, see [{#T}](./private-network.md#vrf-segment).

#### ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}** {#public-ips}

This section is where you [manage](../operations/reserve-public-subnet.md) IP addresses and subnets in a [public network](./public-network.md).

A public network gives {{ baremetal-name }} servers access to the internet. To give a server access to the internet, assign a public IP address to it.

For more information about public networks and public subnets, see [{#T}](./public-network.md).

#### ![layers](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.baremetal.label_images_duoXD }}** {#images}

This section is where you upload and delete custom [images](./images.md#user-images) of operating systems and software products in {{ baremetal-name }}.

You can install operating systems and other software on {{ baremetal-name }} servers from custom images. Do it by [uploading](../operations/image-upload.md) your image to {{ baremetal-full-name }} and initiating installation from that image using the KVM console.

For more information about custom images, see [{#T}](./images.md#user-images).

#### ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** {#operations}

This section contains information about [operations](../../api-design-guide/concepts/about-async.md) with {{ baremetal-full-name }} resources and their statuses.

Whenever you invoke any operation that changes the status of a {{ yandex-cloud }} resource, an `Operation` object is created, which you can use to track the status of the operation.

For more information about operations in {{ yandex-cloud }}, see [{#T}](../../api-design-guide/concepts/about-async.md).
