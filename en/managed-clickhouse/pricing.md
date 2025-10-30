---
title: '{{ mch-full-name }} pricing policy'
description: This article covers the {{ mch-name }} pricing policy.
editable: false
---


# {{ mch-short-name }} pricing policy

In this section, you can find the {{ mch-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}





To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=2febafd8c375#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


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

* Egress traffic from {{ yandex-cloud }}.

Ingress traffic and requests to the hybrid storage are free-of-charge.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### DB host usage {#rules-hosts-uptime}

The host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices for the Russia region](#prices).

You can choose a host class both for {{ CH }} and {{ ZK }} hosts (according to the expected replication load).

{% note warning %}

In clusters with disabled [{{ CK }}](./concepts/replication.md#ck) support and with two or more {{ CH }} hosts, three {{ ZK }} hosts with the lowest class are automatically created to provide replication and fault tolerance.

{% endnote %}

The minimum billing unit is one minute (for example, 90 seconds of host operation count as two minutes). You do not pay for the time when the DBMS or {{ ZK }} host is unable to perform its main functions.


### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for DB clusters.

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.
   * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts, in increments of 93 GB.

* Size of data backups in [local](concepts/storage.md#local-storage-features) and [network](concepts/storage.md) storage:

    * Backups are stored free of charge as long as the combined size of the DB and all its backups is smaller than the selected storage size.

    * If the combined size of the database and all backups exceeds the cluster storage size, you only pay for the portion in excess of the storage size.

   * Automatic backups in {{ mch-short-name }} include only the data that has been changed since the previous backup rather than a full DB. It means the storage space used by automatic backups only increases in proportion to the amount of changed data.

   * The number of hosts in a cluster does not affect the storage size and, consequently, the amount of free backups.

    For example, if there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* Size of cold data backups in a [hybrid storage](concepts/storage.md#hybrid-storage-features):

   * Cold data backups are stored in the same {{ objstorage-name }} bucket as the data itself.

   * The cost of using {{ objstorage-name }} includes both the space used by the backups and the space used by the data itself.

   * {{ mch-short-name }}'s automatic backup function does not create a new backup each time but saves the DB changes from the previous one. It means the storage space used by automatic backups only increases in proportion to the amount of changed data.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds counts as storing 1 GB for 2 minutes).


### Example of cluster cost calculation {#example}

Let’s calculate the cost of using a cluster with the following properties for 30 days:

* **{{ CH }} hosts**: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **Storage for {{ CH }} hosts**: 100 GB of network HDD storage per host.
* **{{ ZK }} hosts** (created automatically): Three `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
* **Storage for {{ ZK }} hosts**: 10 GB of network SSD storage per host.




{% include [usd-hour](../_pricing_examples/managed-clickhouse/usd-hour.md) %}



## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mch-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. If the relevant CVoS columns under [Prices for the Russia region](#prices) are blank, this means the resource is not supported. Currently, you cannot order storage or web traffic this way.

{% endnote %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


### Computing resources of {{ CH }} hosts {#prices-clickhouse}


{% include [note-compute-optimized-request](../_includes/mdb/note-compute-optimized-request.md) %}




{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}



### Computing resources of {{ ZK }} hosts {#prices-zookeeper}


{% include [note-compute-optimized-request](../_includes/mdb/note-compute-optimized-request.md) %}



{% note info %}

You cannot order {{ ZK }} host resources via CVoS.

{% endnote %}





{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}



### Storage and backups {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../_includes/ice-lake-local-ssd-note.md) %}




{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}