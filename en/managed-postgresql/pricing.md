---
title: '{{ mpg-name }} pricing policy'
description: The cost of {{ mpg-name }} usage is calculated based on the disk type and storage size, computing resources allocated to cluster hosts, settings and number of backups, and amount of outgoing traffic from {{ yandex-cloud }} to the internet.
editable: false
---


# {{ mpg-name }} pricing policy

In this section, you can find the {{ mpg-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}





To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=ae5598bac8c3#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mpg-short-name }} {#rules}

The {{ mpg-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### DB host usage {#rules-hosts-uptime}

Host operation cost is charged per hour based on the host class. You can find detailed class specifications in the [Host classes](concepts/instance-types.md) section.

The minimum billing unit is one minute (for example, 90 seconds of host operation count as two minutes). You do not pay for the time when the {{ PG }} host is unable to perform its main functions.


### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for DB clusters.

    
    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:

        * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
        * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.



    * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

* Space occupied by DB backups beyond the storage size specified for the cluster.

    {% note info %}

    The cluster's storage size is equal to the total storage size of all of its hosts.

    {% endnote %}

    * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

    * Automatic backups in {{ mpg-short-name }} only include the data that has been changed since the previous backup rather than a full DB. It means the storage space used by automatic backups only increases in proportion to the amount of changes.

    * Adding hosts increases the cluster's total storage size and, consequently, the free amount of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds counts as storing 1 GB for 2 minutes).


### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ PG }} hosts**: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ PG }} hosts:




{% include [usd-postgresql-host](../_pricing_examples/managed-postgresql/usd-host.md) %}


Calculation for the storage cost and total cost:




{% include [usd-postgresql-storage](../_pricing_examples/managed-postgresql/usd-storage.md) %}



## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mpg-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}



## Prices for the Russia region {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}


{% include [ice-lake-local-ssd-note](../_includes/ice-lake-local-ssd-note.md) %}

Pricing for backup storage has the following specifics:

* Backups are stored free of charge as long as the combined size of the database and all backups is smaller than the total storage size.

* [Adding a host](./operations/hosts#add) increases the total cost per cluster. However, expenses for storing backups beyond the storage size will be lower due to the increased total storage size.

* To reduce expenses for storing backups beyond the storage size:

    * Reduce the retention period for automatic backups in the [advanced settings](./operations/update#change-additional-settings).
    * [Delete the backups](./operations/cluster-backups.md#delete) created manually.

* {% include [backup-wal](../_includes/mdb/mpg/backup-wal.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.pg }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.pg.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.pg.highfreq-v3.cores }}' ]}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}