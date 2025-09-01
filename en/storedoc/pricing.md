---
title: '{{ mmg-full-name }} pricing policy'
description: This article covers the {{ mmg-name }} pricing policy.
editable: false
---

# {{ mmg-name }} pricing policy



In this section, you can find the {{ mmg-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=a147d66e1d1e#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


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

The minimum billing unit is one minute (for example, 90 seconds of host operation cost is same as two minutes). You do not pay for the time when the {{ SD }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for DB clusters.

    * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts, in increments of 93 GB.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
        * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

    For more information about platform-specific storage limitations, see [{#T}](./concepts/storage.md).

* Space occupied by DB backups beyond the storage size specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all its backups is smaller than the selected storage size.

    * When performing automatic backups, {{ mmg-short-name }} does not create a new backup but saves the DB changes since the previous one. It means the storage space used by automatic backups only increases in proportion to the amount of changed data.

    * The number of hosts in a cluster does not affect the storage size and, consequently, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds costs the same as storing 1 GB for two minutes).

### Example of cluster cost calculation {#example}

This is an example of calculating the cost of using a cluster with the following properties for 30 days:

* **{{ SD }}** hosts: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ SD }} hosts:



{% include [usd-mongodb-host](../_pricing_examples/storedoc/usd-host.md) %}


Calculation for the storage cost and total cost:



{% include [usd-mongodb-storage](../_pricing_examples/storedoc/usd-storage.md) %}



## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host compute resources {#prices-host}

The prices for computing resources are the same for all types of hosts: mongod, mongos, and mongocfg.



{% include [usd-host](../_pricing/storedoc/usd-host.md) %}



### Storage and backups {#prices-storage}


{% note info %}

Access to ultra high-speed network storage with three replicas (SSD) is available upon request. Contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}




{% include [usd-storage](../_pricing/storedoc/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

