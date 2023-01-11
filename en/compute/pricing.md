---
editable: false
---

# Pricing for {{ compute-name }}


To calculate the cost of using {{ compute-name }}, use [our calculator]({{ link-cloud-calculator }}) or see the prices in this section.




{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## What goes into the cost of using {{ compute-short-name }} {#rules}

The {{ compute-name }} usage cost is based on:
* Computing resources
   * Type and number of cores (vCPUs)
   * Number of graphics accelerators (GPUs)
   * Amount of memory (RAM).
* Operating systems.
* Type and size of storage:
   * Disks
   * Images
   * Snapshots
* The amount of outgoing traffic
* Public IP address

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly usage rate is based on 720 hours a month.

### VM usage {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status changes to `RUNNING`) until it is completely stopped. The time when the VM is stopped is not charged.

The VM starts automatically once it's created.

When creating a VM, you can specify a public IP address for it.


For information about external IP address usage pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} documentation.

#### Computing resources {#instance-resources}

When creating a VM, you specify the number of vCPUs and graphics accelerators ([GPUs](concepts/gpus.md)), as well as the basic level of core performance and the amount of RAM in GB. For more information, see [{#T}](concepts/performance-levels.md).

The basic level of core performance depends on the [platform](concepts/vm-platforms.md) you select.

{{ price-per-hour-count-per-second }}


#### Operating systems {#instance-os}

OS usage on a VM is also charged. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

{{ price-per-hour-count-per-second }}


#### Using a Microsoft license {#license-microsoft}

The rules for using Microsoft licenses are described in [{#T}](../microsoft/licensing.md).



### Example of cost calculation {#example-of-cost-calculation}


Let's compare the cost of running VMs on the Intel Broadwell [platform](concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Two VMs were created running Linux OS:
* With 2 x 5% vCPUs and 2 GB of RAM.
* With 2 x 100% vCPUs and 2 GB of RAM.

Both VMs have been running for 30 days.

**VM cost with 5% vCPU**:

> 
> 720 × (2 × $0.002480 + 2 × $0.003120) = $8.064000
> 
>
> Total: $8.064000 is the cost of using a VM with 2 × 5% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720 is the number of hours in 30 days.
* 2 is the number of 5% vCPUs.
* $0.002480 is the cost of using 5% vCPU per hour.
* 2 is the amount of RAM (in GB).
* $0.003120 is the cost of using 1 GB of RAM per hour.

**VM cost with 100% vCPU**:

> 
> 720 × (2 × $0.008960 + 2 × $0.003120) = $17.395200
> 
>
> Total: $17.395200 is the cost of using a VM with 2 × 100% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720 is the number of hours in 30 days.
* 2 is the number of 100% vCPUs.
* $0.008960 is the cost of using 100% vCPU per hour.
* 2 is the amount of RAM (in GB).
* $0.003120 is the cost of using 1 GB of RAM per hour.

As you can see, the cost of the VM using 5% vCPU is half as much as that of the VM using 100% vCPU.



### Storage usage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, meaning the amount of block storage that the disk occupies. The cost of the service depends on the amount of time between when the disk is created and deleted, the amount of disk space, and the disk type selected during creation.

You are charged for disks regardless of whether the VM is running.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

The cost is specified for one month of use. Billing occurs per second.

{% note warning %}

Disks with installed [{{ marketplace-name }}]({{ link-cloud-marketplace }}) products contain the license IDs (`product_ids`) of these products.

If you connect such a disk to a VM as additional storage, you will be charged for the use of the {{ marketplace-name }} products in addition to the storage fee.

{% endnote %}

### {{ ig-name }} usage {#instance-groups}

The {{ ig-name }} component can be used free of charge. You can create instance groups and use the storage and computing resources within the [available limits](concepts/limits.md).

All other {{ yandex-cloud }} services, such as VMs and external IP addresses, are charged as usual. Outgoing traffic [is charged](#prices-traffic) the same as in other services.



### Dedicated host usage {#dedicated-hosts}

The cost of a dedicated host depends on its type (processor model, number of cores, and RAM) and doesn't depend on the number of VMs running on it.

There are dedicated host configurations with local SSD drives that you can use after receiving approval from Technical Support. If there are local drives in a host configuration, you will need to pay for them even if you do not use them.

vCPUs and RAM of VMs running on a dedicated host are not charged.

Use of additional resources, such as images from {{ marketplace-name }} or network drives, is billed as usual.

Usage prices are shown on an hourly basis (monthly for local drives). Billing occurs per second.



## Pricing {#prices}


All prices are shown without VAT.


### VM computing resources {#prices-instance-resources}





{% include [usd-instance-resources.md](../_pricing/compute/usd-instance-resources.md) %}





### Operating systems {#prices-os}





{% include [usd-os.md](../_pricing/compute/usd-os.md) %}





### Disks, snapshots, and images {#prices-storage}





{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}






### Computing resources of dedicated hosts {#prices-dedicated-host}




{% include [usd-host-cpu.md](../_pricing/compute/usd-host-cpu.md) %}

{% include [usd-host-other.md](../_pricing/compute/usd-host-other.md) %}





{% include [usd-local-nvme.md](../_pricing/compute/usd-local-nvme.md) %}




### Software-accelerated network {#software-accelerated-network}





{% include [usd-network.md](../_pricing/compute/usd-network.md) %}




### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}




