---
editable: false
---

# Pricing for {{ compute-name }}

{% if product == "yandex-cloud" %}

To calculate the cost of using {{ compute-name }}, use [our calculator]({{ link-cloud-calculator }}) or see the prices in this section.

{% endif %}

{% if product == "cloud-il" %}

To calculate the cost of using {{ compute-name }}, see the prices on this page.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

## What goes into the cost of using {{ compute-short-name }} {#rules}

The {{ compute-name }} usage cost is based on:
* Computing resources
   * Type and number of cores (vCPUs)
   * Number of graphics accelerators (GPUs)
   * Amount of memory (RAM)
* Operating systems
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


#### Example of calculating the cost of computing resources {#instance-resources-example}

{% if product == "yandex-cloud" %}
Let's compare the cost of running VMs on the Intel Broadwell [platform](concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Two VMs were created running Linux OS:
* With 2 x 5% vCPUs and 2 GB of RAM.
* With 2 x 100% vCPUs and 2 GB of RAM.

Both VMs have been running for 30 days.

**VM cost with 5% vCPU**:

> {% if region == "ru" %}720 × (2 × ₽0.3100 + 2 × ₽0.3900) = ₽1008.0000{% endif %}
> {% if region == "int" %}720 × (2 × $0.002480 + 2 × $0.003120) = $8.064000{% endif %}
> {% if region == "kz" %}720 × (2 × ₸1.5500 + 2 × ₸1.9500) = ₸5040.0000{% endif %}
>
> Total: {% if region == "ru" %}₽1008.0000{% endif %}{% if region == "int" %}$8.064000{% endif %}{% if region == "kz" %}₸5040.0000{% endif %} is the cost of using a VM with 2 × 5% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720 is the number of hours in 30 days.
* 2 is the number of 5% vCPUs.
* {% if region == "ru" %}₽0.3100{% endif %}{% if region == "int" %}$0.002480{% endif %}{% if region == "kz" %}₸1.5500{% endif %} is the cost of using 5% vCPU per hour.
* 2 is the amount of RAM (in GB).
* {% if region == "ru" %}₽0.3900{% endif %}{% if region == "int" %}$0.003120{% endif %}{% if region == "kz" %}₸1.9500{% endif %} is the cost of using 1 GB of RAM per hour.

**VM cost with 100% vCPU**:

> {% if region == "ru" %}720 × (2 × ₽1.1200 + 2 × ₽0.3900) = ₽2174.4000{% endif %}
> {% if region == "int" %}720 × (2 × $0.008960 + 2 × $0.003120) = $17.395200{% endif %}
> {% if region == "kz" %}720 × (2 × ₸5.6000 + 2 × ₸1.9500) = ₸10872.0000{% endif %}
>
> Total: {% if region == "ru" %}₽2174.4000{% endif %}{% if region == "int" %}$17.395200{% endif %}{% if region == "kz" %}₸10872.0000{% endif %} is the cost of using a VM with 2 × 100% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720 is the number of hours in 30 days.
* 2 is the number of 100% vCPUs.
* {% if region == "ru" %}₽1.1200{% endif %}{% if region == "int" %}$0.008960{% endif %}{% if region == "kz" %}₸5.6000{% endif %} is the cost of using 100% vCPU per hour.
* 2 is the amount of RAM (in GB).
* {% if region == "ru" %}₽0.3900{% endif %}{% if region == "int" %}$0.003120{% endif %}{% if region == "kz" %}₸1.9500{% endif %} is the cost of using 1 GB of RAM per hour.

As you can see, the cost of the VM using 5% vCPU is half as much as that of the VM using 100% vCPU.

{% endif %}

{% if product == "cloud-il" %}

Let's compare the cost of running VMs on the Intel Ice Lake [platform](concepts/vm-platforms.md) with different [vCPU performance levels](concepts/performance-levels.md).

Two VMs were created running Linux OS:
* With 2 x 20% vCPUs and 2 GB of RAM.
* With 2 x 100% vCPUs and 2 GB of RAM.

Both VMs have been running for 30 days.

**VM cost with 20% vCPU**:

> 720 × (2 × ₪0.0223 + 2 × ₪0.0142) = ₪52.5600
>
> Total: ₪52.5600 is the cost of using a VM with 2 × 20% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720 is the number of hours in 30 days.
* 2 is the number of 20% vCPUs.
* ₪0.0223 is the cost of using 20% vCPU per hour.
* 2 is the amount of RAM (in GB).
* ₪0.0142 is the cost of using 1 GB of RAM per hour.

**VM cost with 100% vCPU**:

> 720 × (2 × ₪0.0533 + 2 × ₪0.0142) = ₪97.2000
>
> Total: ₪97.2000 is the cost of using a VM with 2 × 100% vCPUs and 2 GB of RAM during 30 days.

Where:
* 720 is the number of hours in 30 days.
* 2 is the number of 100% vCPUs.
* ₪0.0533 is the cost of using 100% vCPU per hour.
* 2 is the amount of RAM (in GB).
* ₪0.0142 is the cost of using 1 GB of RAM per hour.

As you can see, the cost of the VM using 20% vCPU is half as much as that of the VM using 100% vCPU.

{% endif %}

{% if product == "yandex-cloud" %}

#### Operating systems {#instance-os}

OS usage on a VM is also charged. The cost depends on the OS license and the amount of computing resources. The core usage type selected for the VM also matters.

{{ price-per-hour-count-per-second }}


#### Using a Microsoft license {#license-microsoft}

The rules for using Microsoft licenses are described in [{#T}](../microsoft/licensing.md).

{% endif %}


### Storage usage (disks, snapshots, and images) {#disk}

When creating a disk, you specify its size, meaning the amount of block storage that the disk occupies. The cost of the service depends on the amount of time between when the disk is created and deleted, the amount of disk space, and the disk type selected during creation.

You are charged for disks regardless of whether the VM is running.

If you created an image or snapshot, you pay for the storage of this object separately depending on its size.

The cost is specified for one month of use. Billing occurs per second.

{% note warning %}

Disks with installed [{{ marketplace-name }}](/marketplace) products contain the license IDs (`product_ids`) of these products.

If you connect such a disk to a VM as additional storage, you will be charged for the use of the {{ marketplace-name }} products in addition to the storage fee.

{% endnote %}

### {{ ig-name }} usage {#instance-groups}

The {{ ig-name }} component can be used free of charge. You can create instance groups and use the storage and computing resources within the [available limits](concepts/limits.md).

All other {{ yandex-cloud }} services, such as VMs and external IP addresses, are charged as usual. Outgoing traffic [is charged](#prices-traffic) the same as in other services.


{% if product == "yandex-cloud" %}

### Dedicated host usage {#dedicated-hosts}

The cost of a dedicated host depends on its [type](concepts/dedicated-host.md#host-types), i.e., the processor model, the number of cores, the amount of RAM, the size and number of local SSDs, etc., and does not depend on the number of VMs running on it.

vCPUs and RAM of VMs running on a dedicated host are not charged.

Use of additional resources, such as images from {{ marketplace-name }} or network drives, is billed as usual.

{{ price-per-hour-count-per-second }}

{% cut "Example of calculating the cost of a dedicated host" %}

An `intel-6338-c108-m704-n3200x6` dedicated host running for an hour is charged as follows:

{% if region == "ru" %}

| Resource | Cost per hour | Available | Total |
| --- | --- | --- | ---: |
| vCPU | ₽1.1828/vCPU | 108 vCPU | ₽127.7424 |
| RAM | ₽0.3133/GB | 704 GB | ₽220.5632 |
| Disk | ₽0.0122/GB | 19200 GB | ₽234.2400 |
| | | **Total** | **₽582.5456** |

{% endif %}

{% if region == "kz" %}

| Resource | Cost per hour | Available | Total |
| --- | --- | --- | ---: |
| vCPU | ₸5.9139/vCPU | 108 vCPU | ₸638.7012 |
| RAM | ₸1.5665/GB | 704 GB | ₸1102.8160 |
| Disk | ₸0.0611/GB | 19200 GB | ₸1173.1200 |
| | | **Total** | **₸2914.6372** |

{% endif %}

{% if region == "int" %}

| Resource | Cost per hour | Available | Total |
| --- | --- | --- | ---: |
| vCPU | $0.009462/vCPU | 108 vCPU | $1.021896 |
| RAM | $0.002506/GB | 704 GB | $1.764224 |
| Disk | $0.000098/GB | 19200 GB | $1.881600 |
| | | **Total** | **$4.667720** |

{% endif %}

{% endcut %}

{% endif %}


## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

### VM computing resources {#prices-instance-resources}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-instance-resources.md](../_pricing/compute/rub-instance-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-instance-resources.md](../_pricing/compute/kzt-instance-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-instance-resources.md](../_pricing/compute/usd-instance-resources.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-instance-resources.md](../_pricing/compute/ils-instance-resources.md) %}

{% endif %}


### Operating systems {#prices-os}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-os.md](../_pricing/compute/rub-os.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-os.md](../_pricing/compute/kzt-os.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-os.md](../_pricing/compute/usd-os.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-os.md](../_pricing/compute/ils-os.md) %}

{% endif %}



### Disks, snapshots, and images {#prices-storage}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/compute/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/compute/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/compute/usd-storage.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-storage.md](../_pricing/compute/ils-storage.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### Computing resources of dedicated hosts {#prices-dedicated-host}

The prices are specified for 1 vCPU, 1 GB of RAM, and 1 GB of local SSD storage. You pay for all the resources available on the dedicated host, regardless of whether you use them or not. For example, a host of the `intel-6338-c108-m704-n3200x6` [type](concepts/dedicated-host.md#host-types) has the following resources available: 108 vCPUs, 704 GB of RAM, and 19200 GB of storage on local SSDs. See the example of cost calculation [above](#dedicated-hosts).

{% if region == "ru" %}

{% include [rub-host-resources.md](../_pricing/compute/rub-host-resources.md) %}

{% include [rub-local-nvme.md](../_pricing/compute/rub-local-nvme.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-host-resources.md](../_pricing/compute/kzt-host-resources.md) %}

{% include [kzt-local-nvme.md](../_pricing/compute/kzt-local-nvme.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-host-resources.md](../_pricing/compute/usd-host-resources.md) %}

{% include [usd-local-nvme.md](../_pricing/compute/usd-local-nvme.md) %}

{% endif %}

{% endif %}


### Software-accelerated network {#software-accelerated-network}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-network.md](../_pricing/compute/rub-network.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-network.md](../_pricing/compute/kzt-network.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-network.md](../_pricing/compute/usd-network.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-network.md](../_pricing/compute/ils-network.md) %}

{% endif %}

### Egress traffic {#prices-traffic}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}

