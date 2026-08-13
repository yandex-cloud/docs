---
title: '{{ mch-full-name }} pricing policy'
description: This article covers the {{ mch-name }} pricing policy.
editable: false
---


# {{ mch-short-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 6
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        icon: _assets/icons/calculator.svg
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=3ea7efa48808#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2220hr46dtogekm57v
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


This section describes the {{ mch-name }} pricing [policy](#rules) and [current prices](#prices) for its resources.

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

The minimum billing unit is one minute, e.g., 1.5 minutes of host usage is billed as 2 minutes. You do not pay for the time when the DBMS or {{ ZK }} host is unable to perform its main functions.


### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for DB clusters.

   * You can order local SSD storage (`local-ssd`) only for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake** and **AMD Zen 4**: In {{ local-ssd-v3-step }} increments.
   * You can order non-replicated SSD storage (`network-ssd-nonreplicated`) only for clusters with three or more hosts, and it must be allocated in 93 GB increments.

{% include [pricing-backup-general](../_includes/mdb/pricing-backup-ch-os-gp.md) %} 

For more information, see [Backups in {{ mch-name }}](concepts/backup.md).

The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes is billed as 2 minutes.

### Cluster cost calculation example {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ CH }} hosts**: Three `s3-c2-m8` hosts, Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **Storage for {{ CH }} hosts**: 100 GB of network HDD storage per host.
* **{{ ZK }} hosts** (created automatically): Three `b3-c1-m4` hosts, Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM.
* **Storage for {{ ZK }} hosts**: 10 GB of network SSD storage per host.




{% include [usd-hour](../_pricing_examples/managed-clickhouse/usd-hour.md) %}



## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mch-name }} provides two types of CVoS: for vCPUs and for RAM on the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at your current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain types of resources. For unsupported resource types, the relevant CVoS columns under [Prices for the Russia region](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

You cannot order {{ ZK }} host resources via CVoS.


{% include [note-compute-optimized-request](../_includes/mdb/note-compute-optimized-request.md) %}





<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.ch }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.keeper.clickhouse.highfreq-v3.cores }}', '{{ pc|mdb.keeper.clickhouse.v2.cpu.c5 }}', '{{ pc|mdb.keeper.clickhouse.v1.cpu.c5 }}', '{{ pc|mdb.software_accelerated_network.clickhouse.highfreq-v4a.cores }}' , '{{ pc|mdb.software_accelerated_network.keeper.clickhouse.highfreq-v4a.cores }}', '{{ pc|mdb.keeper.clickhouse.v2.cpu.c20 }}', '{{ pc|mdb.keeper.clickhouse.v1.cpu.c20 }}', '{{ pc|mdb.software_accelerated_network.zk.clickhouse.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.clickhouse.highfreq-v3.cores }}', '{{ pc|mdb.software_accelerated_network.zk.clickhouse.highfreq-v3.cores }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
