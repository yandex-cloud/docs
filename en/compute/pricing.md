---
title: '{{ compute-full-name }} pricing policy'
description: This article covers the {{ compute-name }} pricing policy.
editable: false
---


# {{ compute-name }} pricing policy

{% note tip %}





To calculate the cost of using {{ compute-name }}, use [our calculator](https://yandex.cloud/en/prices?state=577e4326f11d#calculator) on the {{ yandex-cloud }} website or check the pricing data below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}


## What goes into the cost of using {{ compute-short-name }} {#rules}

The {{ compute-name }} usage cost includes:
* VM computing resources:
  * Type and number of cores (vCPUs).
  * Number of graphics accelerators ([GPUs](concepts/gpus.md)). 
  * Amount of RAM.
* Operating systems.
* Type and size of storage:
  * Disks
  * Images
  * Snapshots
* Amount of outgoing traffic.
* Public IP address.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly prices are based on 720 hours per month.

### Using reserved instance pools {#pool}

{% include [reserved-pools-preview-notice](../_includes/compute/reserved-pools-preview-notice.md) %}

The cost of using [reserved instance pools](./concepts/reserved-pools.md) covers the whole unused amount of reserved [computing resources of VMs](#prices-instance-resources), [GPU clusters](#prices-gpu-clusters), and [software accelerated networks](#software-accelerated-network).

Pool rates apply to slots with the `available` [status](./concepts/reserved-pools.md#slot-stats), whereas `used` slots are [billed as regular VM instances](#instance). That is, if you attach a VM to a pool, it continues to be billed separately while using some of the pool’s resources. As a result, your pool usage fee is reduced. When you remove a VM from the pool, the computing resources are released and the fee for using the pool increases.

Slots with the `unavailable` or `pending` status are not billable.

### Using VMs {#instance}

The cost of a VM depends on the allocated computing resources, operating system, and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the VM, from the moment it is started (when its status switches to `RUNNING`) until it is completely stopped. The time when the VM is stopped is not charged.

The VM starts automatically once it is created.

When creating a VM, you can specify a public IP address for it.

To learn how the external IP address is priced, see [this {{ vpc-full-name }} article](../vpc/pricing.md).


#### Computing resources {#instance-resources}

When creating a VM, specify the number of vCPUs and [GPUs](concepts/gpus.md), as well as the basic core performance level and RAM in GB. For more information, see [{#T}](concepts/performance-levels.md).

The basic level of vCPU performance depends on the [platform](concepts/vm-platforms.md) you select.

_{{ price-per-hour-count-per-second }}_


#### Example of calculating the cost of computing resources {#instance-resources-example}

Here is a comparison of the cost of running VMs on the Intel Ice Lake [platform](concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Let’s assume you created two Linux VMs:
* 2 x 20% vCPUs and 2 GB of RAM.
* 2 x 100% vCPUs and 2 GB of RAM.

Both VMs were running for 30 days.

**VM cost with 20% vCPU**:




{% include [usd-compute-vm20](../_pricing_examples/compute/usd-vm20.md) %}


**VM cost with 100% vCPU**:




{% include [usd-compute-vm100](../_pricing_examples/compute/usd-vm100.md) %}


As you can see, the cost of the VM using 20% vCPU is almost half as much as that of the VM using 100% vCPU.


#### Operating systems {#instance-os}

Using the VM’s OS also comes at a charge. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

_{{ price-per-hour-count-per-second }}_


#### Using a Microsoft license {#license-microsoft}

To learn how to use Microsoft licenses, see [{#T}](../microsoft/licensing.md).


### Storage usage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, meaning the amount of block storage the disk uses. The cost depends on the amount of time between when the disk is created and deleted, the amount of disk space, and the disk type selected during creation.

You are charged for using disks whether the VM is running or not.

If you created an image or snapshot, you pay for its storage separately depending on its size.

After deleting a VM instance, you will still be charged for disks, snapshots, and images. If you no longer need these resources, delete them.

_The price covers one month of use. You are charged per second of usage._

{% note warning %}

Disks with installed [{{ marketplace-name }}](/marketplace) products contain the license IDs (`product_ids`) of these products.

If you connect such a disk to a VM as additional storage, you will be charged for the use of the {{ marketplace-name }} products in addition to the storage fee.

{% endnote %}


### Using {{ ig-name }} {#instance-groups}

Using {{ ig-name }} is free of charge. You can create instance groups and use the storage and computing resources within the [available limits](concepts/limits.md).

All other {{ yandex-cloud }} services, such as VMs and external IP addresses, are charged as usual. Outgoing traffic [is charged](#prices-traffic) in the same way as in other services.



### Dedicated host usage {#dedicated-hosts}

The cost of a dedicated host depends on its [type](concepts/dedicated-host.md#host-types), i.e., the processor model, the number of cores, the amount of RAM, the size and number of local SSDs, etc., and does not depend on the number of VMs running on it.

vCPUs and RAM of VMs running on a dedicated host are not charged.

Use of additional resources, such as images from {{ marketplace-name }} or network drives, is billed as usual.

_{{ price-per-hour-count-per-second }}_

{% cut "Example of calculating the cost of a dedicated host" %}

An `intel-6338-c108-m704-n3200x6` dedicated host running for an hour is charged as follows:



{% include [usd-compute-dedicated-hosts](../_pricing_examples/compute/usd-dedicated-hosts.md) %}


{% endcut %}



## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ compute-name }} provides two types of CVoS: for vCPUs and RAM. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. If the relevant CVoS columns under [Prices for the Russia region](#prices) are blank, this means the resource is not supported. Currently, you cannot order storage or web traffic this way.

{% endnote %}

_{{ price-per-hour-count-per-second }}_


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

CVoS adjusted price is only available for regular VMs.


### VM computing resources {#prices-instance-resources}

_{{ price-per-hour-count-per-second }}_




{% include [usd-instance-resources.md](../_pricing/compute/usd-instance-resources.md) %}




### GPU clusters {#prices-gpu-clusters}

_{{ price-per-hour-count-per-second }}_



{% include [usd-gpu-clusters.md](../_pricing/compute/usd-gpu-clusters.md) %}




### Disks, snapshots, and images {#prices-storage}




{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}



### File storages {#prices-nfs}




{% include [usd-nfs.md](../_pricing/compute/usd-nfs.md) %}




### Computing resources of dedicated hosts {#prices-dedicated-host}

The prices are specified for 1 vCPU, 1 GB of RAM, and 1 GB of local SSD storage. You pay for all the resources available on the dedicated host, regardless of whether you use them or not. For example, let’s assume a host of the `intel-6338-c108-m704-n3200x6` [type](concepts/dedicated-host.md#host-types) has the following resources available: 108 vCPUs, 704 GB of RAM, and 19,200 GB of storage on local SSDs. For the relevant example of cost calculation, see [above](#dedicated-hosts).

_{{ price-per-hour-count-per-second }}_



{% include [usd-host-resources.md](../_pricing/compute/usd-host-resources.md) %}

{% include [usd-local-nvme.md](../_pricing/compute/usd-local-nvme.md) %}




### Software-accelerated network {#software-accelerated-network}




{% include [usd-network.md](../_pricing/compute/usd-network.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
