# Creating VMs having multiple network interfaces

## Issue description {#case-description}
You need to create a VM with more than one network interface.

## Solution {#case-resolution}
To create a VM with multiple network interfaces, use images from the [Network infrastructure category](https://cloud.yandex.ru/marketplace?categories=network) in Yandex Cloud Marketplace. Images from this category allow you to create instances with multiple interfaces used to connect to different cloud networks.

As an option, you can use the [NAT instance image](https://cloud.yandex.ru/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) based on an LTS release of Ubuntu Linux. In the [documentation section](../../../tutorials/routing/nat-instance/index.md), you can find a scenario for setting up egress traffic routing on a VM instance based on this image.

If you are familiar with to Cisco or Mikrotik solutions, you can use them as virtual routers: images for such products are also available in Yandex Cloud Marketplace, but you need to purchase a license to use them.
You can find more details about these products here:
- [Installing a Cisco CSR 1000v virtual router](../../../vpc/tutorials/cisco.md).
- [Installing a Mikrotik CHR virtual router](../../../vpc/tutorials/mikrotik.md).

Maximum number of network interfaces depends on the platform and vCPU on your VM.
Here are the current limits on the number of network interfaces for hardware platforms used in Yandex Cloud:

Broadwell (`standard-v1`):
- 2 to 16 vCPUs: 8 interfaces
- 20 to 32 vCPUs: 16 interfaces

Cascade Lake (`standard-v2`):
- 2 to 16 vCPUs: 8 interfaces
- 20 to 80 vCPUs: 16 interfaces

For Ice Lake (`standard-v3`):
- 2 to 32 vCPUs: 8 interfaces 
- 36 to 96 vCPUs: 16 interfaces

Note that when a VM is starting, a maximum of 14 devices, including the boot disk and a NIC, can be connected to it. A VM will not start if it has more than 14 connected devices. Keep this in mind when creating the VM. More devices should be connected to a running VM, if needed.
For more information, see the [documentation article](../../../compute/concepts/limits.md#compute-limits-vm).

{% note alert %}

If you restart a VM with more than 14 connected devices, it will not start up.

{% endnote %}