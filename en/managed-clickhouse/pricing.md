---
title: '{{ mch-full-name }} pricing policy'
description: This article covers the {{ mch-name }} pricing policy.
editable: false
---


# {{ mch-short-name }} pricing policy

In this section, you can find the {{ mch-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}





For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=2febafd8c375#calculator) on our website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mch-short-name }} {#rules}

The {{ mch-name }} usage cost includes:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts).

* Settings and number of backups.

* Egress traffic from {{ yandex-cloud }} to the internet.

You are not charged for ingress traffic and requests to the hybrid storage.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Database host usage {#rules-hosts-uptime}

The host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices for the Russia region](#prices).

You can choose a host class both for {{ CH }} and {{ ZK }} hosts based on the expected replication load.

{% note warning %}

In clusters with [{{ CK }}](./concepts/replication.md#ck) support off and with two or more {{ CH }} hosts, three {{ ZK }} hosts of the lowest class are automatically created for replication and [high availability](concepts/high-availability.md).

{% endnote %}

The minimum billing unit is one minute, e.g., 1.5 minutes of host operation cost the same as two minutes. You do not pay for the time when the DBMS or {{ ZK }} host is unable to perform its main functions.


### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for database clusters.

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.
   * Non-replicated SSD storage (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts, in increments of 93 GB.

* Size of data backups in [local](concepts/storage.md#local-storage-features) and [network](concepts/storage.md) storage:

    * Backups are stored free of charge as long as the combined size of the database and all its backups is smaller than the selected storage size.

    * If the combined size of the database and all its backups exceeds the cluster storage size, you only pay for the portion in excess of the storage size.

   * When performing automatic backups, {{ mch-short-name }} does not create a new backup but saves the database changes introduced since the previous one. This means the storage space used by automatic backups increases only in proportion to the amount of changes.

   * The number of hosts in a cluster does not affect the storage size and, consequently, the amount of free backups.

    For example, if there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* Size of cold data backups in a [hybrid storage](concepts/storage.md#hybrid-storage-features):

   * Cold data backups are stored in the same {{ objstorage-name }} bucket as the data itself.

   * The cost of using {{ objstorage-name }} includes both the space used by the backups and the space used by the data itself.

   * When performing automatic backups, {{ mch-short-name }} does not create a new backup but saves the database changes introduced since the previous one. This means the storage space used by automatic backups increases only in proportion to the amount of changes.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes costs the same as for 2 minutes.


### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ CH }} hosts**: Three `s3-c2-m8` hosts, Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **Storage for {{ CH }} hosts**: 100 GB of network HDD storage per host.
* **{{ ZK }} hosts** (created automatically): Three `b3-c1-m4` hosts, Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
* **Storage for {{ ZK }} hosts**: 10 GB of network SSD storage per host.




{% include [usd-hour](../_pricing_examples/managed-clickhouse/usd-hour.md) %}



## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mch-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain types of resources. For unsupported resource types, the relevant CVoS columns under [Prices for the Russia region](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

You cannot order {{ ZK }} host resources via CVoS.


{% include [note-compute-optimized-request](../_includes/mdb/note-compute-optimized-request.md) %}





<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.ch }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.keeper.clickhouse.highfreq-v3.cores }}', '{{ pc|mdb.keeper.clickhouse.v2.cpu.c5 }}', '{{ pc|v1.commitment.selfcheckout.m6.mdb.ch.ram.v4a }}', '{{ pc|mdb.keeper.clickhouse.v1.cpu.c5 }}', '{{ pc|mdb.software_accelerated_network.clickhouse.highfreq-v4a.cores }}' , '{{ pc|mdb.software_accelerated_network.keeper.clickhouse.highfreq-v4a.cores }}', '{{ pc|v1.commitment.selfcheckout.m6.mdb.ch.cpu.c100.v4a }}', '{{ pc|mdb.keeper.clickhouse.v2.cpu.c20 }}', '{{ pc|mdb.keeper.clickhouse.v1.cpu.c20 }}', '{{ pc|mdb.software_accelerated_network.zk.clickhouse.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.clickhouse.highfreq-v3.cores }}', '{{ pc|mdb.software_accelerated_network.zk.clickhouse.highfreq-v3.cores }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}