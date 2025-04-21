---
editable: false
---


# {{ mch-short-name }} pricing policy

In this section, you can find the {{ mch-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}





To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=2febafd8c375#calculator) on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mch-short-name }} {#rules}

The {{ mch-name }} usage cost is based on:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts).

* Settings and number of backups.

* Egress traffic from {{ yandex-cloud }}.

The incoming traffic and the number of requests to the hybrid storage are free-of-charge.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### DB host usage {#rules-hosts-uptime}

Host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices for the Russia region](#prices).

You can choose a host class both for {{ CH }} and {{ ZK }} hosts (according to the expected replication load).

{% note info %}

In clusters with disabled [{{ CK }}](./concepts/replication.md#ck) support and with two or more {{ CH }} hosts, 3 {{ ZK }} hosts with the minimal class are automatically created to provide replication and fault tolerance.

{% endnote %}

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You do not pay for the time when the DBMS or {{ ZK }} host is unable to perform its main functions.


### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for DB clusters.

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.
   * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts, in increments of 93 GB.

* Size of [local](concepts/storage.md#local-storage-features) and [network](concepts/storage.md) storage data backups:

    * Backups are stored free of charge as long as the combined size of the DB and all its backups is smaller than the selected storage size.

    * If the combined size of the database and all backups exceeds the cluster storage size, you only pay for the portion in excess of the storage size.

   * When performing automatic backups, {{ mch-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

   * The number of hosts in a cluster does not affect the storage size and, consequently, the free volume of backups.

    For example, if there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* Size of [hybrid storage](concepts/storage.md#hybrid-storage-features) cold data backups:

   * Cold data backups are stored in the same {{ objstorage-name }} bucket as the data itself.

   * The cost of using {{ objstorage-name }} considers both the space used by the backups and the space used by the data itself.

   * When performing automatic backups, {{ mch-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **{{ CH }}** hosts: Three hosts of the `s3-c2-m8` class: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **Storage for {{ CH }} hosts**: 100 GB of network HDD storage per host.
* **{{ ZK }}** hosts (created automatically): Three `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
* **Storage for {{ ZK }} hosts**: 10 GB of network SSD storage per host.




{% include [usd-hour](../_pricing_examples/managed-clickhouse/usd-hour.md) %}




## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mch-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are planning to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. A dash in the relevant CVoS columns under [Prices for the Russia region](#prices) means the resource is not supported. Currently, you cannot order storage or web traffic this way.

{% endnote %}




## Prices for the Russia region {#prices}



{% note warning %}

Starting May 1, 2025, the prices for {{ mch-full-name }} resources in the Russia region will increase. For new USD prices, see our [price list](https://yandex.cloud/en/price-list?currency=USD&installationCode=ru&services=dn2220hr46dtogekm57v).

{% endnote %}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


### {{ CH }} host computing resources {#prices-clickhouse}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}




{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}



### {{ ZK }} host computing resources {#prices-zookeeper}


{% include [Доступ к Compute Optimized по запросу](../_includes/mdb/note-compute-optimized-request.md) %}



{% note info %}

You cannot order {{ ZK }} host resources via CVoS.

{% endnote %}





{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}



### Storage and backups {#prices-storage}

{% include [local-ssd for Intel Ice Lake only on request](../_includes/ice-lake-local-ssd-note.md) %}




{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}