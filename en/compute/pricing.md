---
editable: false
---

# {{ compute-name }} pricing

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ compute-short-name }} {#rules}

The {{ compute-name }} usage cost is based on:
* VM computing resources:
   * Type and number of cores (vCPUs)
   * Number of graphics accelerators ([GPUs](concepts/gpus.md))
   * Amount of memory (RAM)
* Operating systems
* Type and size of storage:
   * Disks
   * Images
   * Snapshots
* Amount of outgoing traffic
* Public IP address

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly usage rate is based on 720 hours per month.

### VM usage {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status changes to `RUNNING`) until it is completely stopped. The time when the VM is stopped is not charged.

The VM starts automatically once it is created.

When creating a VM, you can specify a public IP address for it.

For information about external IP address usage pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} documentation.

#### Computing resources {#instance-resources}

When creating a VM, you specify the number of vCPUs and graphics accelerators ([GPUs](concepts/gpus.md)), as well as the basic level of core performance and the amount of RAM in GB. For more information, see [{#T}](concepts/performance-levels.md).

The basic level of core performance depends on the [platform](concepts/vm-platforms.md) you select.

{{ price-per-hour-count-per-second }}


#### Example of calculating the cost of computing resources {#instance-resources-example}

Let's compare the cost of running VMs on the Intel Broadwell [platform](concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Two VMs were created running Linux OS:
* With 2 x 5% vCPUs and 2 GB of RAM.
* With 2 x 100% vCPUs and 2 GB of RAM.

Both VMs have been running for 30 days.

**VM cost with 5% vCPU**:



> 720 × (2 × $0.002480 + 2 × $0.003120) = $8.064000
>
> Total: $8.064000 is the cost of using a VM with 2 × 5% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720: Number of hours in 30 days.
* 2 is the number of 5% vCPUs.
* $0.002480 is the cost of using 5% vCPU per hour.
* 2 is the amount of RAM (in GB).
* $0.003120 is the cost of using 1 GB of RAM per hour.


**VM cost with 100% vCPU**:



> 720 × (2 × $0.008960 + 2 × $0.003120) = $17.395200
>
> $17.395200 is the cost of using a VM with 2 × 100% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720: Number of hours in 30 days.
* 2: Number of 100% vCPUs.
* $0.008960: Cost of using 100% vCPU per hour.
* 2: Amount of RAM (in GB).
* $0.003120: Cost of using 1 GB of RAM per hour.


As you can see, the cost of the VM using 5% vCPU is half as much as that of the VM using 100% vCPU.


#### Operating systems {#instance-os}

OS usage on a VM is also charged. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

{{ price-per-hour-count-per-second }}

#### Using a Microsoft license {#license-microsoft}

The rules for using Microsoft licenses are described in [{#T}](../microsoft/licensing.md).

### Storage usage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, meaning the amount of block storage that the disk occupies. The cost of the service depends on the amount of time between when the disk is created and deleted, the amount of disk space, and the disk type selected during creation.

You are charged for using disks whether the VM is running or not.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

After deleting a VM instance, you will still be charged for disks, snapshots, and images. If you no longer need these resources, delete them.

The cost is specified for one month of use. You are charged per second of usage.

{% note warning %}

Disks with installed [{{ marketplace-name }}](/marketplace) products contain the license IDs (`product_ids`) of these products.

If you connect such a disk to a VM as additional storage, you will be charged for the use of the {{ marketplace-name }} products in addition to the storage fee.

{% endnote %}

### {{ ig-name }} usage {#instance-groups}

The {{ ig-name }} component can be used free of charge. You can create instance groups and use the storage and computing resources within the [available limits](concepts/limits.md).

All other {{ yandex-cloud }} services, such as VMs and external IP addresses, are charged as usual. Outgoing traffic [is charged](#prices-traffic) the same as in other services.


### Dedicated host usage {#dedicated-hosts}

The cost of a dedicated host depends on its [type](concepts/dedicated-host.md#host-types), i.e., the processor model, the number of cores, the amount of RAM, the size and number of local SSDs, etc., and does not depend on the number of VMs running on it.

vCPUs and RAM of VMs running on a dedicated host are not charged.

Use of additional resources, such as images from {{ marketplace-name }} or network drives, is billed as usual.

{{ price-per-hour-count-per-second }}

{% cut "Example of calculating the cost of a dedicated host" %}

An `intel-6338-c108-m704-n3200x6` dedicated host running for an hour is charged as follows:



| Resource | Cost per hour | Available | Total |
| --- | --- | --- | ---: |
| vCPU | $0.009462/vCPU | 108 vCPU | $1.021896 |
| RAM | $0.002506/GB | 704 GB | $1.764224 |
| Disk | $0.000098/GB | 19,200 GB | $1.881600 |
| | | **Total** | **$4.667720** |


{% endcut %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ compute-name }} provides two types of CVoS: on vCPUs and RAM. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices for Russia](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for Russia {#prices}





All prices are shown without VAT.



The price with a CVoS is only available for regular VMs.


### VM computing resources {#prices-instance-resources}




{% include [usd-instance-resources.md](../_pricing/compute/usd-instance-resources.md) %}



### GPU clusters {#prices-gpu-clusters}



{% include [usd-gpu-clusters.md](../_pricing/compute/usd-gpu-clusters.md) %}



### Disks, snapshots, and images {#prices-storage}




{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}


### File storages {#prices-nfs}




{% include [usd-nfs.md](../_pricing/compute/usd-nfs.md) %}



### Computing resources of dedicated hosts {#prices-dedicated-host}

The prices are specified for 1 vCPU, 1 GB of RAM, and 1 GB of local SSD storage. You pay for all the resources available on the dedicated host, regardless of whether you use them or not. For example, a host of the `intel-6338-c108-m704-n3200x6` [type](concepts/dedicated-host.md#host-types) has the following resources available: 108 vCPUs, 704 GB of RAM, and 19,200 GB of storage on local SSDs. For more information, refer to the example of cost calculation [above](#dedicated-hosts).



{% include [usd-host-resources.md](../_pricing/compute/usd-host-resources.md) %}

{% include [usd-local-nvme.md](../_pricing/compute/usd-local-nvme.md) %}



### Software-accelerated network {#software-accelerated-network}




{% include [usd-network.md](../_pricing/compute/usd-network.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}