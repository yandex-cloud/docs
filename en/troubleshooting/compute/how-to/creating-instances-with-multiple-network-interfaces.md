# How to create VMs with multiple network interfaces


## Case description {#case-description}

You need to create a VM with multiple network interfaces.

## Solution {#case-resolution}

To create a VM with multiple network interfaces, use images from the [**Network infrastructure** category](https://yandex.cloud/en/marketplace?categories=network&utm_referrer=about%3Ablank) in {{ marketplace-full-name }}. Images from this category allow you to create VMs with multiple interfaces used to connect to different cloud networks.

{% note warning %}

You can only set the number of network interfaces when creating a VM. Once you have created it, you will not be able to add new interfaces or delete the existing ones.

If you need to change the number of network interfaces on an existing VM, use [snapshots](../../../compute/operations/vm-create/create-from-snapshots.md) or [disk images](../../../compute/operations/vm-create/create-from-user-image.md) to create a VM copy and set the number you need when creating a VM instance.

{% endnote %}

As an option, you can use the [NAT instance image](https://yandex.cloud/en/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) based on an LTS release of Ubuntu. You can learn how to set up egress traffic routing on a VM based on this image in [this tutorial](../../../tutorials/routing/nat-instance/index.md).

If you are familiar with the Cisco or Mikrotik solutions, you can use them as virtual routers: their images are also available in {{ marketplace-full-name }}, but you need to purchase a license first to use them. You can find more details about these products here:

* [Installing the Cisco CSR 1000v virtual router](../../../vpc/tutorials/cisco.md).
* [Installing the Mikrotik CHR virtual router](../../../vpc/tutorials/mikrotik.md).

Maximum number of network interfaces depends on the platform and vCPU on your VM.
Here are the current limits on the number of network interfaces for hardware platforms used in {{ yandex-cloud }}:

1. Broadwell (`standard-v1`):

   * 2 to 16 vCPUs: 8 interfaces
   * 20 to 32 vCPUs: 16 interfaces

1. Cascade Lake (`standard-v2`):

   * 2 to 16 vCPUs: 8 interfaces
   * 20 to 80 vCPUs: 16 interfaces

1. Ice Lake (`standard-v3`):

   * 2 to 32 vCPUs: 8 interfaces
   * 36 to 96 vCPUs: 16 interfaces

Note that when a VM is starting, you can connect a maximum of 14 devices, including the boot disk and a NIC, to it. A VM will not start if you connect more than 14 devices. Keep this in mind when creating a VM. You can connect other devices when your VM is already running.

For more information, see [this guide](../../../compute/concepts/limits.md#compute-limits-vm).

{% note alert %}

If you restart a VM with more than 14 devices connected, it will not be able to boot.

{% endnote %}