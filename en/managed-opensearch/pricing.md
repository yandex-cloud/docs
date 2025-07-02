---
title: '{{ mos-full-name }} pricing policy'
description: This article covers the {{ mos-name }} pricing policy.
editable: false
---

# {{ mos-name }} pricing policy

In this section, you can find the {{ mos-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=6045f728368e#calculator) on the {{ yandex-cloud }} website or check out the pricing below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mos-short-name }} {#rules}

The {{ mos-name }} usage cost includes:

* Computing resources allocated to cluster hosts (including hosts with the `MANAGER` role).

* Disk type and disk space.

* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

Host operation cost depends on what resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

You can select host class both for hosts with the `DATA` role and hosts with the `MANAGER` and `DASHBOARDS` roles.

Host operation cost is charged per hour. The minimum billing unit is one minute (for example, 90 seconds of host operation cost is same as two minutes). You do not pay for the time when the {{ OS }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for clusters.

* Storage taken up by backups over specified cluster storage.

    * Backups are stored free of charge as long as the combined size of the data in the cluster and all backups is smaller than the selected storage size.

    * When performing automatic backups, {{ mos-short-name }} does not create a new backup but saves the data changes made since the previous copy. It means the storage space used by automatic backups only increases in proportion to the amount of changed data.

    * The number of hosts in a cluster does not affect the storage size and, consequently, the backup size that is free of charge.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds costs the same as storing 1 GB for two minutes).

### Example of cluster cost calculation {#example}

This is an example of calculating the cost of using a cluster with the following properties for 30 days:

* **{{ OS }}** hosts: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ OS }} hosts:






{% include [usd-opensearch-host](../_pricing_examples/managed-opensearch/usd-host.md) %}


Calculation for the storage cost and total cost:






{% include [usd-opensearch-storage](../_pricing_examples/managed-opensearch/usd-storage.md) %}



## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mos-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are planning to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}




{% include [usd-hosts-and-storage.md](../_pricing/managed-opensearch/usd-hosts-and-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
