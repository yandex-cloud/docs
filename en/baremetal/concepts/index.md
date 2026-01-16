# {{ baremetal-full-name }} overview

In {{ baremetal-full-name }}, you can [lease](../operations/servers/server-lease.md) a physical server with all its hardware resources provisioned for your individual use. 

To create and conveniently operate an infrastructure relying on leased physical servers, {{ baremetal-name }} provides users with all the required tools to manage the servers and their network’s settings.

A system of flexible quotas and resource limits defines how many servers, networks, and how much space for custom OS images are available for each user.

## Servers {#servers}

You can order servers of the following configurations:

* Stock configuration: Get a ready-to-use server with or without an OS in minutes. Choose a server from dozens of configurations for typical tasks and workloads.

   [Leasing a stock configuration server](server-configurations.md)
* Custom configuration: Use our builder to create a server optimized for your load profile from available server components and get your new server in 4 days' time. 

  [Building a custom server configuration](server-custom-configurations.md)
* On-request configuration: If looking for a server for a variety of scenarios and workloads, apply for an on-request configuration. 
  
  [Describe your preferred configuration to get a personalized offer](https://yandex.cloud/en/services/baremetal#contact-form)

You can lease [servers](servers.md) for a period from one day to a year. When ordering a server, you can install an OS from ready-made Marketplace [images](images.md) or use your own distribution for installation by [uploading](../operations/image-upload.md) it to [{{ objstorage-full-name }}](../../storage/). You can also configure public and private IP addressing, SSH access, and server backup policies using [{{ backup-full-name }}](../../backup/).

## Network {#network}

All servers have multiple physical network interfaces connected to the [public internet](network.md#public-network) and to a [private network](./network.md#private-network) through different, independent switches which make up a single IP fabric with the spine-leaf topology.

In the public network, each server is allocated one public IPv4 address free of charge. You can also lease blocks of [dedicated public subnets](./network.md#public-subnet) of varying sizes and use them to assign addresses to servers. For servers with 10 and 25 Gbps network cards, you can select a daily internet traffic package.

In a private network, you can group servers at different levels through [private subnets](network.md#private-subnet) (L2, VLAN 802.1Q) and use routing to join them into a [VRF](network.md#vrf-segment) (L3). If required, you can assign multiple private subnets to a single server port (L2, trunk-port 802.1Q) or add static routes to the VRF.

To ensure stable operation of all networks, {{ baremetal-name }} has a number of [limits](network-restrictions.md).

{{ baremetal-name }} servers can use a private network to access your cloud infrastructure or other {{ yandex-cloud }} services with the help of [{{ interconnect-name }}](../../interconnect/), which allows you to combine your physical servers and cloud infrastructure into a single L3 network. This way, you can implement different scenarios for your infrastructure, e.g., use physical servers as [{{ managed-k8s-name }}](../tutorials/k8s-connect-bms-as-node.md) nodes or as dedicated data storage.

## Setup and management {#control}

You can access the server using a [KVM console](../operations/servers/server-kvm.md) or over SSH. You can also manage servers using the [CLI](../cli-ref/) and [API](../api-ref/).

To configure, manage, and audit actions with objects, {{ baremetal-name }} provides the following tools: the {{ yandex-cloud }} management console, [CLI](../cli-ref/), and [API](../api-ref). You can get audit logs of your operations using [{{ at-name }}](../../audit-trails/), and manage roles and accesses via [{{ iam-name }}](../../iam/).

## Quotas and limits {#quotas-and-limits}

[Quotas](limits.md) restrict the number of available servers, networks, and images. Also, certain [limits](network-restrictions.md) apply to networks.

#### See also {#see-also}

* [{#T}](./servers.md)
* [{#T}](./server-configurations.md)
* [{#T}](./smart-disk-analysis.md)
* [{#T}](./network.md)
* [{#T}](./dhcp.md)
* [{#T}](./network-restrictions.md)
* [Bare metal: Full control and high performance](https://yandex.cloud/ru/blog/bare-metal-guide)