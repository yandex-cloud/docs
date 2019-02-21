---
editable: false
---
# Pricing policy for [!KEYREF compute-full-name]

## What goes into the cost of using [!KEYREF compute-short-name] {#rules}

The cost of [!KEYREF compute-short-name] usage is based on:

* Computing resources
    * Type and number of cores (vCPU)
    * Amount of memory (RAM)
* Operating systems
* Type and size of storage:
    * Disks
    * Images
    * Snapshots
* The amount of outgoing traffic.
* Public IP address.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Use of VM instances {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status changes to `RUNNING`) and to a complete stop. The time when the VM is stopped is not charged.

The VM starts automatically once it is created.

When creating a VM, you can specify a public IP address for it.
For information about charges for using an external IP address, see the section [[!TITLE]](../vpc/pricing.md) in the Yandex Virtual Private Cloud documentation.

#### Computing resources {#instance-resources}

When creating a VM, you specify the number of vCPUs, the basic level of core performance, and the amount of RAM in GB. For more information, see the section [[!TITLE]](concepts/vm-types.md).

The basic level of core performance depends on the VM type:

* [[!TITLE]](concepts/vm-types.md#light-vms): at least 5% of the core is guaranteed.
* [[!TITLE]](concepts/vm-types.md#standard-vms): 100% of the core is guaranteed.

[!KEYREF price-per-hour-count-per-second]

#### Operating systems {#burstable-instance-os}

OS usage on a VM is charged, as well. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

[!KEYREF price-per-hour-count-per-second]

#### Example of cost calculation

Let's compare the cost of light and standard VMs.

Two VMs have been created running Linux OS:

* Light (5%+ vCPU, 1 GB RAM).
* Standard (1 vCPU, 1 GB RAM).

Both VMs have been running for 30 days.

The cost of the light VM is calculated as follows:

> 5% of vCPU = ₽0.1932/hour * 30 days * 24 hours = 139.1040 ₽
>
>1 GB RAM = ₽0.2441/hour * 30 days * 24 hours = 175.7520 ₽
>
>Total: 314.8560 ₽

The cost of the standard VM is calculated as follows:

> 1 vCPU = ₽0.7017/hour * 30 days * 24 hours = 505.2240 ₽
>
>1 GB RAM = ₽0.2441/hour * 30 days * 24 hours = 175.7520 ₽
>
>Total: 680.9760 ₽

The cost of the light VM is almost half the cost of the standard VM.

### Use of storage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, that is, the amount of block storage that the disk occupies. The cost of the service depends on the time between the disk's creation and deletion, the amount of disk space, and the disk type selected during its creation.

You are charged for your disks regardless of whether the VM is running.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

The cost is specified for one month of use. Charging per second.

## Prices {#prices}

### Computing resources  {#prices-instance-resources}

| Computing resources | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| 5%+ of vCPU | 0.1610 ₽ | 0.1932 ₽ |
| 100% of vCPU | 0.5847 ₽ | 0.7017 ₽ |
| RAM (for 1 GB) | 0.2034 ₽ | 0.2441 ₽ |

### Operating systems {#burstable-instance-os}

| OS | Cost per vCPU per hour,<br/> without VAT | Cost per vCPU per hour,<br/> with VAT |
| ----- | ----- | ----- |
| Linux for all core types | 0 ₽ | 0 ₽ |
| Windows Server for 5%+ of vCPU | 0.5288 ₽ | 0.6346 ₽ |
| Windows Server for 1 vCPU | 1.0576 ₽ | 1.2691 ₽ |

### Disks, snapshots, and images {#prices-storage}

| Type | Cost of 1 GB per month,<br/> without VAT | Cost of 1 GB per month,<br/> with VAT |
| ----- | ----- | ----- |
| Fast network drive (NVMe) | 6.2034 ₽ | 7.4441 ₽ |
| Standard disk drive (HDD) | 1.7373 ₽ | 2.0847 ₽ |
| Snapshot | 1.8559 ₽ | 2.2271 ₽ |
| Image | 1.8559 ₽ | 2.2271 ₽ |

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

