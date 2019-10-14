---
editable: false
---
# Pricing for {{ compute-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ compute-short-name }} {#rules}

The cost of {{ compute-short-name }} usage is based on:

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

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### VM usage {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status changes to `RUNNING`) until it is completely stopped. The time when the VM is stopped is not charged.

The VM starts automatically once it is created.

When creating a VM, you can specify a public IP address for it.
For information about external IP address usage pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} service documentation.

#### Computing resources {#instance-resources}

When creating a VM, you specify the number of vCPUs and graphics accelerators ([GPUs](concepts/gpus.md)), as well as the basic level of core performance and the amount of RAM in GB. Read more in [{#T}](concepts/performance-levels.md).

The basic level of core performance depends on the [platform](./concepts/vm-platforms.md) you selected.

{{ price-per-hour-count-per-second }}

#### Operating systems {#instance-os}

OS usage on a VM is charged, as well. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

{{ price-per-hour-count-per-second }}

#### Example of cost calculation

Let's compare the cost of running VMs on the Intel Broadwell [platform](./concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Two VMs have been created running Linux OS:

* 5% of vCPU and 1 GB RAM
* 100% of vCPU and 1 GB RAM

Both VMs have been running for 30 days.

VM cost with 5% vCPU:

> 5% vCPU = ₽0.1932/hour * 30 days * 24 hours = ₽139.1040
>
> 1 GB RAM = ₽0.2441/hour * 30 days * 24 hours = ₽175.7520
>
> Total: ₽314.8560

VM cost with 100% vCPU:

> 1 vCPU = ₽0.7017/hour * 30 days * 24 hours = ₽505.2240
>
> 1 GB RAM = ₽0.2441/hour * 30 days * 24 hours = ₽175.7520
>
> Total: ₽680.9760

As you can see, the cost of the VM using 5% vCPU is about half as much as that of the VM using 100% vCPU.

### Use of storage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, that is, the amount of block storage that the disk occupies. The cost of the service depends on the time between the disk's creation and deletion, the amount of disk space, and the disk type selected during its creation.

You are charged for your disks regardless of whether the VM is running.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

The cost is specified for one month of use. Billing occurs per second.

### Usage {{ ig-name }} {#instance-groups}

The {{ ig-name }} component can be used free of charge. You can create instance groups and use the storage and computing resources within the [available limits](concepts/limits.md).

All other Yandex.Cloud services, such as creation of VMs or allocation of external IP addresses, are [charged as usual](../billing/pricing.md). Outgoing traffic is [charged](#prices-traffic) the same as other services.

## Pricing {#prices}

### VM computing resources {#prices-instance-resources}

{% list tabs %}

- Prices in USD

  Computing resources | Rate for 1 hour, without VAT |
  ----- | -----
  **Intel Broadwell** |
  5% vCPU | $0.002476
  20% vCPU | $0.007051 |
  100% vCPU | $0.008996 |
  RAM (за 1 ГБ) | $0.003129
  **Intel Cascade Lake** |
  5% vCPU | $0.001307
  20%+ vCPU | $0.003923
  50%+ vCPU | $0.005753
  100% vCPU | $0.009584
  RAM (за 1 ГБ) | $0.002538

- Prices in roubles

  Computing resources | Rate for 1 hour, with VAT |
  ----- | -----
  **Intel Broadwell** |
  5% vCPU | ₽0.1932
  20% vCPU | ₽0.5500 |
  100% vCPU | ₽0.7017 |
  RAM (за 1 ГБ) | ₽0.2441
  **Intel Cascade Lake** |
  5% vCPU | ₽0.1020
  20%+ vCPU | ₽0.3060
  50%+ vCPU | ₽0.4488
  100% vCPU | ₽0.7476
  RAM (за 1 ГБ) | ₽0.1980

{% endlist %}

### Preemptible VM computing resources {#prices-preemptible-instance-resources}

{% list tabs %}

- Prices in USD

  Computing resources | Rate for 1 hour, without VAT |
  ----- | -----
  **Intel Broadwell** |
  5% vCPU | $0.001535
  20% vCPU | $0.002187 |
  100% vCPU | $0.002769 |
  1 GPU | $1.999397 |
  RAM (за 1 ГБ) | $0.000961
  **Intel Cascade Lake** |
  5% vCPU | $0.000815
  20%+ vCPU | $0.001282
  50%+ vCPU | $0.001794
  100% vCPU | $0.002615
  RAM (за 1 ГБ) | $0.000630

- Prices in roubles

  Computing resources | Rate for 1 hour, with VAT |
  ----- | -----
  **Intel Broadwell** |
  | 5%+ of vCPU| ₽0.1198 |
  | 20%+ vCPU| ₽0.1706 |
  | 100% of vCPU| ₽0.2160 |
  | 1 GPU | ₽155,9530 |
  | RAM (for 1 GB)| ₽0.0750 |
  **Intel Cascade Lake** |
  | 5%+ of vCPU| ₽0.0636 |
  | 20%+ vCPU| ₽0.1000 |
  | 50%+ vCPU| ₽0.1400 |
  | 100% of vCPU| ₽0.2040 |
  | RAM (for 1 GB)| ₽0.0492 |

{% endlist %}

### Operating systems {#prices-os}

{% list tabs %}

- Prices in USD

  | OS | Cost per vCPU per hour, without VAT
  ----- | -----
  | Linux for all core types | $0 |
  | Windows Server for 5%+ of vCPU | $0.008135 |
  | Windows Server for 20%+ and 50%+ vCPU | $0.009615 |
  | Windows Server for 100% vCPU | $0.016270 |

- Prices in roubles

  | OS | Cost per vCPU per hour, with VAT |
  ----- | -----
  | Linux for all core types | ₽0 |
  | Windows Server for 5%+ of vCPU | ₽0.6346 |
  | Windows Server for 20%+ and 50%+ vCPU | ₽0.75 |
  | Windows Server for 100% vCPU | ₽1.2691 |

{% endlist %}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

{% list tabs %}

- Prices in USD

  Product | Cost per vCPU per month, without VAT 
  ----- | -----
  MS SQL Server Standard* | $75,59615
  MS SQL Server Enterprise* | $258,50001

- Prices in roubles

  Product | Cost per vCPU per month, with VAT 
  ----- | -----
  MS SQL Server Standard* | ₽5896.5
  MS SQL Server Enterprise* | ₽20163 

{% endlist %}
    
\* The product is given for a bunch of 2 vCPU cores, the minimal amount of the vCPU cores — 4 (2 bunches).

### Disks, snapshots, and images {#prices-storage}

{% list tabs %}

- Prices in USD

  | Type | Rate for 1 GB per month, without VAT
  ----- | -----
  | Fast network drive (SSD) | $0.095437 |
  | Standard disk drive (HDD) | $0.026726 |
  | Snapshot | $0.028552 |
  | Image | $0.028552 |

- Prices in roubles

  | Type | Rate for 1 GB per month, with VAT |
  ----- | -----
  | Fast network drive (SSD) | ₽7.4441 |
  | Standard disk drive (HDD) | ₽2.0847 |
  | Snapshot | ₽2.2271 |
  | Image | ₽2.2271 |

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

