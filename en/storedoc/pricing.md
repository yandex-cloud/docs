---
title: '{{ mmg-full-name }} pricing policy'
description: This article covers the {{ mmg-name }} pricing policy.
editable: false
---

# {{ mmg-name }} pricing policy



In this section, you can find the {{ mmg-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




To calculate the cost of using {{ mmg-name }}, use [our calculator](https://yandex.cloud/en/prices?state=a147d66e1d1e#calculator) on the {{ yandex-cloud }} website or see the pricing data below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmg-short-name }} {#rules}

The {{ mmg-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

Host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

The minimum billing unit is one minute (for example, 90 seconds of host operation count as two minutes). You do not pay for the time when the {{ SD }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for database clusters.

    * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts, in increments of 93 GB.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

    For more information about platform-specific storage limitations, see [{#T}](./concepts/storage.md).

* Space used by DB backups in excess of the storage amount specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all its backups is smaller than the selected storage size.

    * When performing automatic backups, {{ mmg-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the amount of changes.

    * The number of hosts in a cluster does not affect the storage size and, consequently, the amount of free backups.

The price covers one month of use based on 720 hours per month.  The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds counts as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ SD }}** hosts: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ SD }} hosts:



{% include [usd-mongodb-host](../_pricing_examples/storedoc/usd-host.md) %}


Calculation for the storage cost and total cost:



{% include [usd-mongodb-storage](../_pricing_examples/storedoc/usd-storage.md) %}



## Prices for the Russia region {#prices}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

The prices for computing resources are the same for all types of hosts: `mongod`, `mongos`, and `mongocfg`.

Access to ultra high-speed network storage with three replicas (SSD) is available upon request. Contact [support]({{ link-console-support }}) or your account manager.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.mongo }}']}
    excludeSkuIds={['{{ pc|mdb.cluster.mongodb.v1.cpu.c20 }}', '{{ pc|mdb.cluster.mongodb.v2.cpu.c20 }}', '{{ pc|mdb.cluster.mongodb.v2.cpu.c5 }}', '{{ pc|mdb.cluster.mongodb.v1.cpu.c5 }}', '{{ pc|mdb.software_accelerated_network.mongodb.v2.cores}}', '{{ pc|mdb.software_accelerated_network.mongodb.v1.cores }}', '{{ pc|mdb.software_accelerated_network.mongodb.v4a.cores }}', '{{ pc|mdb.software_accelerated_network.mongodb.v3.cores }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

