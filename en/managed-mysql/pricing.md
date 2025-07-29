---
title: '{{ mmy-name }} pricing policy'
description: The cost of {{ mmy-name }} usage is calculated based on the disk type and storage size, computing resources allocated to cluster hosts, settings and number of backups, and amount of outgoing traffic from {{ yandex-cloud }} to the internet.
editable: false
---


# {{ mmy-name }} pricing policy

In this section, you can find the {{ mmy-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}





To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=7f776c1fc309#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mmy-short-name }} {#rules}

The {{ mmy-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### DB host usage {#rules-hosts-uptime}

There are different ways to calculate the cost depending on the [host type](concepts/index.md):

* Standard hosts

  Host operation cost is charged per hour based on what computing resources you allocate for it.


* Dedicated hosts

  The cost is made up of two components: [the cost of {{ compute-full-name }}](../compute/pricing.md#prices) computing resources and {{ mmy-name }} charges for these resources.


You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

The minimum billing unit is one minute (for example, 90 seconds of host operation cost is same as two minutes). You do not pay for the time when the {{ MY }} host is unable to perform its main functions.


### Disk space usage {#rules-storage}

You are charged for the following:

* Storage allocated for DB clusters.

    * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
                * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
        * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

    * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more broker hosts.

* Space occupied by DB backups beyond the storage size specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.

    * The number of hosts in a cluster does not affect the storage size and, consequently, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds costs the same as storing 1 GB for two minutes).


### Example of cluster cost calculation {#example}

This is an example of calculating the cost of using a cluster with the following properties for 30 days:

* **{{ MY }} hosts**: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ MY }} hosts:




{% include [usd-mysql-host](../_pricing_examples/managed-mysql/usd-host.md) %}


Calculation for the storage cost and total cost:




{% include [usd-mysql-storage](../_pricing_examples/managed-mysql/usd-storage.md) %}




## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mmy-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are planning to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Host prices are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The price of local SSD storage (`local-ssd`) also depends on the host type.

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


### Host computing resources {#prices-hosts}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}



#### Standard hosts {#standard-hosts}



{% include [USD: standard hosts](../_pricing/managed-mysql/usd-hosts-standard.md) %}




#### Dedicated hosts {#dedicated-hosts}

The cost is made up of two components: [the cost of {{ compute-full-name }}](../compute/pricing.md#prices) computing resources and {{ mmy-name }} charges for these resources.



{% include [USD: dedicated hosts](../_pricing/managed-mysql/usd-hosts-dedicated.md) %}




### Storage and backups {#prices-storage}

{% include [local-ssd for Ice Lake by query only](../_includes/ice-lake-local-ssd-note.md) %}



{% list tabs %}

- Standard hosts

  {% include [usd-storage-standard.md](../_pricing/managed-mysql/usd-storage-standard.md) %}

- Dedicated hosts

  The cost is made up of two components: the [{{ compute-full-name }} storage cost](../compute/pricing.md#prices) and the {{ mmy-name }} price for it. All prices are per GB, per month.

  {% include [usd-storage-dedicated.md](../_pricing/managed-mysql/usd-storage-dedicated.md) %}

{% endlist %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
