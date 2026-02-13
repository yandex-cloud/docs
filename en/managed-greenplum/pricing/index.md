---
title: '{{ mgp-full-name }} pricing policy'
description: This article covers the {{ mgp-name }} pricing policy.
editable: false
---

# {{ mgp-name }} pricing policy

In this section, you can find the {{ mgp-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.


{% note tip %}




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=a98dc01f27e8#calculator) on our website or check out the pricing below.


{% endnote %}



{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [vat](../../_includes/vat.md) %}

{% include [pricing-status](../../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning](../../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mgp-short-name }} {#rules}

The {{ mgp-name }} usage cost includes:

* Disk type and storage size.
* Computing resources allocated to cluster hosts and host type.
* Settings and number of backups.
* Egress traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}


There are different ways to calculate the cost depending on the [host type](../concepts/):

* Standard hosts

  The host operation cost is charged per hour based on what computing resources you allocate for it.

* Dedicated hosts

  There are two cost components: the [{{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and the {{ mgp-name }} markup on these resources.



You can find the supported resource configurations in the [Host classes](../concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

The minimum billing unit is one minute, e.g., 1.5 minutes of host operation cost the same as two minutes. You will not be charged for the time when the {{ GP }} host is unavailable for basic operations.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for clusters.

  
  * You can only order local SSD storage (`local-ssd`) for clusters with two master hosts:

    * For Intel Cascade Lake: In increments of 100 GB.
    * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.



  * You can only order non-replicated SSD (`network-ssd-nonreplicated`) storage for clusters with two master hosts, in increments of 93 GB.

  To pay less for storage, export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ GP }} cluster to a cold storage in {{ objstorage-full-name }}. The data will be stored in a service bucket in compressed and encrypted form, which is more cost-efficient. The cost of such storage is calculated based on the [{{ objstorage-name }} pricing policy](../../storage/pricing.md).

* Space occupied by DB backups beyond the storage size specified for the cluster.

  * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

  * When performing automatic backups, {{ mgp-name }} does not create a new backup but saves the database changes introduced since the previous one. It means the storage space used by automatic backups only increases in proportion to the amount of changed data.

  * The number of hosts in a cluster does not affect the storage size and, consequently, the amount of free backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes costs the same as for 2 minutes.

### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:


* **Standard hosts**: Three `s3-c8-m32` hosts, Intel Ice Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for standard hosts**: 100 GB of network HDD storage.
* **Dedicated hosts**: Three `s2.medium` hosts, Intel Cascade Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for dedicated hosts**: 50 GB of local SSD storage.



{% include [usd-managed-greenplum-standard](../../_pricing_examples/managed-greenplum/usd-managed-greenplum.md) %}




## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{ mgp-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you intend to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage, web traffic, and computing resources for dedicated hosts this way.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}


Host prices are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The price of local SSD storage (`local-ssd`) also depends on the host type.


{% include [pricing-month-term](../../_includes/mdb/pricing-month-term.md) %}


{% include [Access to Compute Optimized on request](../../_includes/mdb/note-compute-optimized-request.md) %}

The cost calculation for standard hosts will vary depending on the [host configuration](../concepts/instance-types.md):

* For i2 and i3 hosts (`io-optimized`), you should add the cost of the computing resources of {{ GP }} hosts and [the cost of using a software-accelerated network](../../compute/pricing.md).
* For hosts with other configurations, you only pay for their computing resources.

For dedicated hosts, there are two cost components: the [{{ compute-full-name }} computing resources](../../compute/pricing.md) and the {{ mgp-name }} markup on these resources.





<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.greenplum }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.greenplum.highfreq-v4a.cores.dedicated }}', '{{ pc|mdb.software_accelerated_network.greenplum.highfreq-v3.cores.dedicated }}',]}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
