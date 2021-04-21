---
editable: false
---

# Pricing for {{ compute-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ compute-short-name }} {#rules}

The cost of {{ compute-short-name }} usage is based on:
* Computing resources:
  * Type and number of cores (vCPUs).
  * Number of graphics accelerators (GPUs).
  * Amount of memory (RAM).
* Operating systems.
* Type and size of storage.
  * Disks.
  * Images.
  * Snapshots.
* The amount of outgoing traffic.
* Public IP address.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### VM usage {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status changes to `RUNNING`) until it is completely stopped. The time when the VM is stopped is not charged.

The VM starts automatically once it's created.

When creating a VM, you can specify a public IP address for it.

For information about external IP address usage pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} service documentation.

#### Computing resources {#instance-resources}

When creating a VM, you specify the number of vCPUs and graphics accelerators ([GPUs](concepts/gpus.md)), as well as the basic level of core performance and the amount of RAM in GB. Read more in [{#T}](concepts/performance-levels.md).

The basic level of core performance depends on the [platform](concepts/vm-platforms.md) you select.

{{ price-per-hour-count-per-second }}

#### Operating systems {#instance-os}

OS usage on a VM is also charged. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

{{ price-per-hour-count-per-second }}


#### Example of cost calculation {#example-of-cost-calculation}

Let's compare the cost of running VMs on the Intel Broadwell [platform](concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Two VMs were created running Linux OS:
* 5% of vCPU and 1 GB RAM
* 100% of vCPU and 1 GB RAM

Both VMs have been running for 30 days.

VM cost with 5% vCPU at the price of an hour of CPU core usage equal to $0.002476, and the price of an hour of 1 GB of RAM usage equal to $0.003129:

> 5% vCPU = $0.002476/hour * 30 days * 24 hours = $1.782720
>
> 1 GB RAM = $0.003129/hour * 30 days * 24 hours = $2.252880
>
> Total: $4.035600

VM Cost with 100% vCPU at the price of an hour of CPU core usage equal to $0.008996, and the price of an hour of 1 GB of RAM usage equal to $0.003129:

> 1 vCPU = $0.008996/hour * 30 days * 24 hours = $6.477120
>
> 1 GB RAM = $0.003129/hour * 30 days * 24 hours = $2.252880
>
> Total: $8.730000

As you can see, the cost of the VM using 5% vCPU is about half as much as that of the VM using 100% vCPU.

### Use of storage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, meaning the amount of block storage that the disk occupies. The cost of the service depends on the amount of time between when the disk is created and deleted, the amount of disk space, and the disk type selected during creation.

You are charged for disks regardless of whether the VM is running.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

The cost is specified for one month of use. Billing occurs per second.

### Usage {{ ig-name }} {#instance-groups}

The {{ ig-name }} component can be used free of charge. You can create instance groups and use the storage and computing resources within the [available limits](concepts/limits.md).

All other Yandex.Cloud services, such as VMs and external IP addresses, are [charged as usual](../billing/pricing.md). Outgoing traffic is [charged](#prices-traffic) the same as other services.

### Using a dedicated host {#dedicated-hosts}

The cost of a dedicated host depends on its type (processor model, number of cores, and RAM) and doesn't depend on the number of VMs running on it.

vCPUs and RAM of VMs running on a dedicated host are not charged.

Using additional resources, such as images from {{ marketplace-name }} or disks, are charged as usual.

Prices are shown for 1 hour of use. Billing occurs per second.

## Pricing {#prices}

### VM computing resources {#prices-instance-resources}




{% include [usd-instance-cpu.md](../_pricing/compute/usd-instance-cpu.md) %}

{% include [usd-instance-other.md](../_pricing/compute/usd-instance-other.md) %}

### Preemptible VM computing resources {#prices-preemptible-instance-resources}




{% include [usd-preemp-instance-cpu.md](../_pricing/compute/usd-preemp-instance-cpu.md) %}

{% include [usd-preemp-instance-other.md](../_pricing/compute/usd-preemp-instance-other.md) %}

### Operating systems {#prices-os}




{% include [usd-os.md](../_pricing/compute/usd-os.md) %}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:




{% include [usd-os-win-server.md](../_pricing/compute/usd-os-win-server.md) %}

{% include [usd-os-rds.md](../_pricing/compute/usd-os-rds.md) %}

{% include [usd-os-sql.md](../_pricing/compute/usd-os-sql.md) %}

\* The product is provided for a group of 2 vCPUs. The minimum available number of vCPUs for a VM is 4 (2 groups).

### Disks, snapshots, and images {#prices-storage}

{% note info %}

At the [Preview](../overview/concepts/launch-stages.md) stage, non-replicated disks can be used free of charge. The rates for non-replicated disks listed on this page will be effective from April 19, 2021.

{% endnote %}




{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}

### Dedicated host computing resources {#dedicated-host}




{% include [usd-host-cpu.md](../_pricing/compute/usd-host-cpu.md) %}

{% include [usd-host-other.md](../_pricing/compute/usd-host-other.md) %}

{% endlist %}

### Software accelerated network {#software-accelerated-network}




{% include [usd-network.md](../_pricing/compute/usd-network.md) %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}