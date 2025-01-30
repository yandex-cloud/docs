---
editable: false
---

# {{ mgp-name }} pricing policy

In this section, you can find the {{ mgp-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.


{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=a98dc01f27e8#calculator) on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}



{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}

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

  Host operation cost is charged per hour based on what computing resources you allocate for it.

* Dedicated hosts

  The cost is made up of two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} charges for these resources.



You can find the supported resource configurations in the [Host classes](../concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You do not pay for the time when the {{ GP }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for clusters.

  
  * You can only order local SSD storage (`local-ssd`) for clusters with two master hosts:

    * For Intel Cascade Lake: In increments of 100 GB.
    * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.



  * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with two master hosts, in increments of 93 GB.

  To pay less for storage, export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. The data will be stored in a service bucket in a compressed and encrypted form, which is more cost-efficient. The cost of such storage is calculated based on the [{{ objstorage-name }} pricing policy](../../storage/pricing.md).

* Space used by DB backups in excess of the storage amount specified for the cluster.

  * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

  * When performing automatic backups, {{ mgp-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

  * The number of hosts in a cluster does not affect the storage volume and, consequently, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:


* **Standard hosts**: Three `s3-c8-m32` hosts: Intel Ice Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for standard hosts**: 100 GB of network HDD storage.
* **Dedicated hosts**: Three `s2.medium` hosts: Intel Cascade Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for dedicated hosts**: 50 GB of local SSD storage.



{% include [usd-managed-greenplum-standard](../../_pricing_examples/managed-greenplum/usd-managed-greenplum.md) %}





## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{ mgp-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are planning to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. A dash in the relevant CVoS columns under [Prices](#prices) means the resource is not supported. Currently, you cannot order storage, web traffic, and computing resources for dedicated hosts this way.

{% endnote %}

## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.



Host prices are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The price of local SSD storage (`local-ssd`) also depends on the host type.


{% include [pricing-month-term](../../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}


#### Standard hosts {#standard-hosts}

{% include [Access to Compute Optimized on request](../../_includes/mdb/note-compute-optimized-request.md) %}

The cost calculation will be different depending on the [host configuration](../concepts/instance-types.md):

* For i2 and i3 hosts (`io-optimized`), the cost is made up of the price for {{ mgp-name }} host computing resources (see the table below) and [the price for software-accelerated network usage](../../compute/pricing.md#software-accelerated-network).
* For hosts with other configurations, you only pay for their computing resources:


**Prices per hour**




{% include [usd-hosts-standard-hour](../../_pricing/managed-greenplum/usd-hosts-standard-hour.md) %}


**Prices per month**




{% include [usd-hosts-standard-month](../../_pricing/managed-greenplum/usd-hosts-standard-month.md) %}



#### Dedicated hosts {#dedicated-hosts}

{% include [Access to Compute Optimized on request](../../_includes/mdb/note-compute-optimized-request.md) %}

The cost is made up of two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} charges for these resources.



{% include [usd-hosts-dedicated](../../_pricing/managed-greenplum/usd-hosts-dedicated.md) %}



### Storage and backups {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}






{% list tabs %}

- Standard hosts

  {% include [usd-storage-standard](../../_pricing/managed-greenplum/usd-storage-standard.md) %}

- Dedicated hosts

  The cost is made up of two components: the [{{ compute-full-name }} storage cost](../../compute/pricing.md#prices) and the {{ mgp-name }} price for it. All prices are shown per 1 GB per month.

  {% include [usd-storage-dedicated](../../_pricing/managed-greenplum/usd-storage-dedicated.md) %}

{% endlist %}


{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
