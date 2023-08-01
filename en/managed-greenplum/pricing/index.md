---
editable: false
---

# Pricing for {{ mgp-name }}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [pricing-status](../../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning](../../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mgp-short-name }} {#rules}

The {{ mgp-name }} usage cost is based on:

* Disk type and storage size.
* Computing resources allocated to cluster hosts and host type.
* Settings and number of backups.
* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

There are different ways to calculate the cost depending on the [host type](../concepts/):

* Standard hosts

   The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

* Dedicated hosts

   The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

Supported resource configurations are shown in [{#T}](../concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ GP }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.

   * You can only order local SSD storage (`local-ssd`) for clusters with two master hosts:
      * For Intel Cascade Lake: In 100 GB increments.
      * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.
   * You can only order storage on non-replicated SSDs (`network-ssd-nonreplicated`) in 93 GB increments for clusters with two master hosts.

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mgp-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use and is based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **Standard hosts**: 3 `s3-c8-m32` hosts: Intel Ice Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for standard hosts**: 100 GB of HDD network storage.
* **Dedicated hosts**: 3 `s2.medium` hosts: Intel Cascade Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for dedicated hosts**: 50 GB of local SSD storage.

Cost calculation for standard hosts:

> 
> 3 × (8&nbsp;×&nbsp;$0.017231 + 32&nbsp;×&nbsp;$0.004564) = $0.851688
> 
>
> Total: $0.851688 is the cost per hour of standard host operation.

Where:
* 3: Number of standard hosts.
* 8: Number of vCPUs.
* $0.017231: Cost of using 100% vCPU per hour.
* 32: Amount of RAM per standard host (in GB).
* $0.004564: Cost of using 1GB of RAM on 100% vCPU per hour.

Cost calculation for dedicated hosts:

> 
> 3 × (8&nbsp;×&nbsp;$0.009595 + 32&nbsp;×&nbsp;$0.002538) = $0.473928
> 
>
> Total: $0.473928 is the cost per hour of dedicated host operation.

Where:
* 3: Number of dedicated hosts.
* 8: Number of vCPUs.
* $0.009595: Cost of using 100% vCPU per hour.
* 32: Amount of RAM per dedicated host (in GB).
* $0.002538: Cost of using 1GB of RAM on 100% vCPU per hour.

Calculation for the storage cost and total cost:

> 
> 
> (720 × $0.851688 + 100 × $0.104080) + (720 × $0.473928 + 50 × $0.104080) = $970.0555
>
> Total: $970.0555 is the cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* $0.851688: Cost per hour of standard host operation.
* 100: Amount of HDD network storage (in GB) for standard hosts.
* $0.104080: Cost of using 1 GB of network HDD storage per month.
* $0.473928: Cost per hour of dedicated host operation.
* 50: Amount of local SSD storage (in GB) for dedicated hosts.
* $0.104080: Cost of using 1 GB of local SSD storage per month.

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{ mgp-name }} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage, web traffic or computing resources for dedicated hosts this way.

{% endnote %}

## Pricing {#prices}


All prices are shown without VAT.


Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of storage on local SSDs (`local-ssd`) also depends on the host type.

{% include [pricing-month-term](../../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Standard hosts

   The cost is calculated differently depending on the [host configuration](../concepts/instance-types.md):

   * For hosts i2 and i3 (`io-optimized`), the cost is made up of the price for {{ mgp-name }} host computing resources (see the table below) and [the price for software-accelerated network use](../../compute/pricing.md#software-accelerated-network).
   * For hosts with other configurations, you only pay for their computing resources:

    {% include notitle [USD: standard hosts](../../_pricing/managed-greenplum/usd-hosts-standard.md) %}


- Dedicated hosts

   The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

    {% include notitle [USD: dedicated hosts](../../_pricing/managed-greenplum/usd-hosts-dedicated.md) %}


{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Standard hosts

   {% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

   {% include notitle [usd-storage-standard.md](../../_pricing/managed-greenplum/usd-storage-standard.md) %}


- Dedicated hosts

   The cost is made up of two components: the [{{ compute-full-name }} storage cost](../../compute/pricing.md#prices) and the {{ mgp-name }} price for it. All prices are shown per 1 GB per month.

   {% include notitle [usd-storage-dedicated.md](../../_pricing/managed-greenplum/usd-storage-dedicated.md) %}


{% endlist %}

Pricing for backup storage has the following specifics:

* Backups are stored free of charge as long as the combined size of the database and all backups is less than the total storage size.

* [Adding a segment host](../operations/hosts/cluster-expand.md#add-hosts) increases the total cost per cluster. However, expenses for storing backups beyond the storage size will decrease because the total storage will expand.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

### Egress traffic {#prices-traffic}

 {% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %} 

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
