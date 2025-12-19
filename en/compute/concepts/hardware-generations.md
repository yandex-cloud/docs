---
title: Hardware generations in {{ compute-full-name }}
description: In this article, you will learn about the distinctive features of different hardware generations you can deploy {{ compute-name }} VMs on.
---

# Hardware generations

{{ compute-name }} [VMs](./vm.md) are a combination of virtualized hardware and software deployed on it. A virtual machine's virtualized hardware is defined by the [platform configuration](./vm-platforms.md), [vCPU performance level](./performance-levels.md), and virtualized hardware _generation_.

Each generation has its own [set of specifications](#configurations) determining the following VM features:

* OS [bootloader](https://en.wikipedia.org/wiki/Bootloader) operating mode.
* Supported [disk partition](https://en.wikipedia.org/wiki/Disk_partitioning) structure types.
* [PCI](https://en.wikipedia.org/wiki/Peripheral_Component_Interconnect) bus topology.
* Maximum possible number of connected [disk devices](./storage-overview.md) and [network interfaces](./network.md).

## Hardware generation specifications {#configurations}

#|
|| **Generation** | **Bootloader** | **Boot partition** | **Topology** | **Limit on the number of
disks** | **Limit on the number of**
**network interfaces** ||
|| Gen 1.1 | [BIOS](https://en.wikipedia.org/wiki/BIOS) | [BIOS Boot Partition](https://en.wikipedia.org/wiki/BIOS_boot_partition)
UUID `21686148-6449-`
`6E6F-744E-`
`656564454649` | `PCI_TOPOLOGY_V1` | 16^1^ | 8^1^ ||
|| Gen 1.2 | ^ | ^ | `PCI_TOPOLOGY_V2` |
For VMs with 2 and 4 vCPUs: 62.
For VMs with 6 or more vCPUs: 80. |
For VMs with 2 and 4 vCPUs: 20.
For VMs with 6 or more vCPUs: 32. ||
|| Gen 2 | [UEFI](https://en.wikipedia.org/wiki/UEFI) | [EFI System Partition](https://en.wikipedia.org/wiki/EFI_system_partition)
UUID `C12A7328-F81F-`
`11D2-BA4B-`
`00A0C93EC93B` | `PCI_TOPOLOGY_V2` |
For VMs with 2 and 4 vCPUs: 62.
For VMs with 6 or more vCPUs: 80. |
For VMs with 2 and 4 vCPUs: 20.
For VMs with 6 or more vCPUs: 32. ||
|#

^1^ For VMs without [GPUs](./gpus.md) hosted on two [NUMA](https://en.wikipedia.org/wiki/Non-uniform_memory_access) nodes of a physical server.

{% note warning %}

To guarantee the operability and performance of VMs with large numbers of disk devices and network interfaces, such numbers of devices and interfaces must be supported not by the VM hardware generation alone but by the OS as well, plus provided with enough vCPUs and RAM.

{% endnote %}

## Assigning a generation to a VM {#locking-generations}

The [hardware generation features](#configurations) must be supported by the VM's operating system. The OS boots from a boot [disk](./disk.md), which in turn is created from an [image](./image.md) or [snapshot](./snapshot.md). Therefore, the hardware generation is assigned to each disk, image, and snapshot and registered in the VM's parameters when creating the VM.

{% include [pinned-hardware-generations-warning](../../_includes/compute/pinned-hardware-generations-warning.md) %}

In {{ compute-name }}, some VM features are only available when using a `Gen 2` configuration. For example, to use the `gpu-standard-v3i` [GPU VM configuration](./gpus.md#config), you need the [UEFI](https://en.wikipedia.org/wiki/UEFI) bootloader only available in `Gen 2`. Therefore, the [image](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) recommended for this VM configuration has the `Gen 2` hardware generation assigned to it.

You can change the hardware generation assigned to a disk, image, or snapshot when recreating it from an existing disk, image, or snapshot. If you do not specify a hardware generation when creating a disk, image, or snapshot, it will get the same generation assigned as the original disk, image, or snapshot. For more information, see these guides:
* [{#T}](../operations/index.md#disk-create)
* [{#T}](../operations/index.md#snapshots)
* [{#T}](../operations/index.md#image-create)

If your VM requires [features](#configurations) that are not available for the current generation, such as connecting more disk devices and network interfaces or increasing boot speed, recreate your VM in a new configuration. Do it by creating a snapshot or image of your VM's boot disk with the right generation assigned, and then create a new VM with a new hardware configuration from the resulting snapshot or image.

{% note info %}

Some operating systems may not support all hardware configurations.

{% endnote %}