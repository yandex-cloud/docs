# Pricing policies for [!KEYREF compute-full-name]

[!INCLUDE [pricing-intro](../_includes/pricing-intro.md)]

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

## Virtual machines {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status changes to `RUNNING`) and to a complete stop. The time when the VM is stopped is not charged.

The VM starts automatically once it is created.

> [!NOTE]
>
>You are charged for your disks regardless of whether the VM is running. For more information about disk pricing, see the section [[!TITLE]](#disk).

### Computing resources {#burstable-instance-resources}

When creating a VM, you specify the number of vCPUs, the basic level of core performance, and the amount of RAM in GB. For more information, see the section [[!TITLE]](concepts/vm-types.md).

The basic level of core performance depends on the usage type:

* [With partial core usage](concepts/vm-types.md#burstable-cores): at least 5% of the core is used.
* [With full core usage](concepts/vm-types.md#standard-cores): 100% of the core is used.

[!KEYREF price-per-hour-count-per-second]

| Computing resources | Cost of 1 hour, without VAT | Cost of 1 hour, with VAT |
| ----- | ----- | ----- |
| 5%+ of vCPU | 0.16 ₽ | 0.19 ₽ |
| 100% of vCPU | 0.58 ₽ | 0.69 ₽ |
| RAM (for 1 GB) | 0.20 ₽ | 0.24 ₽ |

> [!NOTE]
>
> Pricing 0,5&nbsp;GB of RAM is equal to half the cost of 1&nbsp;GB.

#### Example of cost calculation

Let's compare the cost of VMs with partial and full usage of cores.

Two VMs have been created running Linux OS:

* With partial core usage (5%+ vCPU, 1 GB RAM).
* With full core usage (1 vCPU, 1 GB RAM).

Both VMs have been running for 30 days.

The cost of the VM with partial core usage is calculated as follows:

> 5% of vCPU = ₽0.19/hour * 30 days * 24 hours = 136.8 ₽
>
>1 GB RAM = ₽0.24/hour * 30 days * 24 hours = 172.8 ₽
>
>Total: 309.6&nbsp;₽

The cost of the VM with full core usage is calculated as follows:

> 1 vCPU = ₽0.69/hour * 30 days * 24 hours = 496.8 ₽
>
>1 GB RAM = ₽0.24/hour * 30 days * 24 hours = 172.8 ₽
>
>Total: 669.6&nbsp;₽

The cost of the VM with partial core usage is almost half the cost of the VM with full core usage.

### Operating systems {#burstable-instance-os}

OS usage on a VM is charged, as well. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

[!KEYREF price-per-hour-count-per-second]

| OS | Cost per vCPU per hour,<br/> without VAT | Cost per vCPU per hour,<br/> with VAT |
| ----- | ----- | ----- |
| Linux for all core types | 0 ₽ | 0 ₽ |
| Windows Server for 5%+ of vCPU | 0.47 ₽ | 0.56 ₽ |
| Windows Server for 1 vCPU | 0.95 ₽ | 1.12 ₽ |

## Disks, snapshots, and images {#disk}

When creating a disk, you specify its size, that is, the amount of block storage that the disk occupies. The cost of the service depends on the time between the disk's creation and deletion, the amount of disk space, and the disk type selected during its creation.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

The cost is specified for one month of use. Per-second rating.

| Type | Cost of 1 GB per month,<br/> without VAT | Cost of 1 GB per month,<br/> with VAT |
| ----- | ----- | ----- |
| Fast network drive (NVMe) | 6.20 ₽ | 7.32 ₽ |
| Standard disk drive (HDD) | 1.74 ₽ | 2.05 ₽ |
| Snapshot | 1.86 ₽ | 2.19 ₽ |
| Image | 1.86 ₽ | 2.19 ₽ |

## Network {#network}

### Outgoing traffic

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing-egress-traffic.md)]

### Public IP

When creating a VM, you can specify a public IP address for it.
For information about charges for using an external IP address, see the section [[!TITLE]](../vpc/pricing.md) in the Yandex Virtual Private Cloud documentation.
