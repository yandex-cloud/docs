---
title: '{{ mos-full-name }} pricing policy'
description: This article covers the {{ mos-name }} pricing policy.
editable: false
---

# {{ mos-name }} pricing policy

In this section, you can find the {{ mos-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=6045f728368e#calculator) on our website or check out the pricing below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

The prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mos-short-name }} {#rules}

The {{ mos-name }} usage cost includes:

* Computing resources allocated to cluster hosts (including hosts with the `MANAGER` role).

* Disk type and disk space.

* Egress traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The host operation cost depends on what resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

You can select a host class both for hosts with the `DATA` role and hosts with the `MANAGER` and `DASHBOARDS` roles.

The host operation cost is charged per hour. The minimum billing unit is one minute, e.g., 1.5 minutes of host operation cost the same as two minutes. You will not be charged for the time when the {{ OS }} host is unavailable for basic operations.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for clusters.

* Storage taken up by backups over the specified cluster storage.

    * Backups are stored free of charge as long as the combined size of data in the cluster and all backups is smaller than the selected storage size.

    * All automatic and [manual](operations/cluster-backups.md) backups are incremental. This means the initial backup contains all index segments, and all subsequent backups contain only the _increment_, i.e., changes made since the previous backup. This saves storage space and reduces the cost of using resources.

    * When [requesting information about a backup](operations/cluster-backups.md#get-backup), you will get the full size of restorable data, but you only pay for the incremental part.

    * The number of hosts in a cluster does not affect the storage size and, consequently, the amount of free backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute; e.g., storing 1 GB for 1.5 minutes costs the same as for 2 minutes.

### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ OS }} hosts**: Three `s3-c2-m8` hosts, Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ OS }} hosts:






{% include [usd-opensearch-host](../_pricing_examples/managed-opensearch/usd-host.md) %}


Calculation for the storage cost and total cost:






{% include [usd-opensearch-storage](../_pricing_examples/managed-opensearch/usd-storage.md) %}


## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mos-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}

{% include [local-ssd for Intel Ice Lake only on request](../_includes/ice-lake-local-ssd-note.md) %}





<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.opensearch }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.opensearch.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.opensearch.highfreq-v3.cores }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
