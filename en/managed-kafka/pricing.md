---
title: '{{ mkf-full-name }} pricing policy'
description: This article covers the {{ mkf-name }} pricing policy.
editable: false
---

# {{ mkf-name }} pricing policy

In this section, you can find the {{ mkf-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=285af0b6c6a6#calculator) on the {{ yandex-cloud }} website or check the pricing data in this section.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The {{ mkf-name }} usage cost includes:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts) and the type of hosts.

* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

Host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts based on the expected replication load. The presence of {{ ZK }} hosts depends on the cluster configuration:

* {{ ZK }} hosts are added to the cluster if it contains more than one {{ KF }} host and uses {{ KF }} 3.5.
* {{ ZK }} hosts are not added to the cluster if it contains a broker host or uses {{ KF }} 3.6 or higher.


There are different ways to calculate the cost depending on the [host type](./concepts/index.md):

* Standard hosts

    Host operation cost is charged per hour based on what computing resources you allocate for it.


* Dedicated hosts

    {% include [Dedicated hosts prices](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}



The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You are not paying for the time when a broker host or {{ ZK }} is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters.

* You can only order local SSD storage (`local-ssd`) for clusters with three or more broker hosts:
    * For Intel Cascade Lake: In increments of 100 GB.
    * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.
* You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) for clusters with three or more broker hosts in increments of 93 GB.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **{{ KF }} broker hosts**: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **Storage for {{ KF }} broker hosts**: 100 GB of network HDD storage per broker host.
* **{{ ZK }} hosts** (created automatically): Three `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM. 
* **Storage for {{ ZK }} hosts**: 10 GB of network SSD storage per host.

#### Standard hosts {#example-standard-hosts}




{% include [usd-hour](../_pricing_examples/managed-kafka/usd-hour.md) %}


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mkf-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you are planning to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. A dash in the relevant CVoS columns under [Prices for the Russia region](#prices) means the resource is not supported. Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices below do not include VAT.


Host prices are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

The price of fast local storage also depends on host type.

### {{ KF }} broker host computing resources {#prices-kafka-brokers}

#### Standard hosts {#prices-kafka-standard}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}




{% list tabs %}

- Prices per hour

  {% include [usd-hosts-standard-hour](../_pricing/managed-kafka/usd-hosts-standard-hour.md) %}

- Prices per month

  {% include [usd-hosts-standard-month](../_pricing/managed-kafka/usd-hosts-standard-month.md) %}

{% endlist %}




#### Dedicated hosts {#prices-kafka-dedicated}

{% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}



{% include notitle [USD: dedicated broker hosts](../_pricing/managed-kafka/usd-hosts-dedicated.md) %}




### Computing resources of {{ ZK }} hosts {#prices-zookeeper}


{% note info %}

You cannot order {{ ZK }} host resources via CVoS.

{% endnote %}


#### Standard hosts {#zookeeper-standard}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}





{% include notitle [USD: standard ZooKeeper hosts](../_pricing/managed-kafka/usd-hosts-zk-standard.md) %}




#### Dedicated hosts {#zookeeper-dedicated}

{% include [prices-dedicated-hosts](../_includes/mdb/mkf/prices-dedicated-hosts.md) %}

For cost details, contact [technical support]({{ link-console-support }}).




### Storage {#prices-storage}

{% include [local-ssd for Intel Ice Lake only by request](../_includes/ice-lake-local-ssd-note.md) %}




{% include notitle [USD: Storage prices](../_pricing/managed-kafka/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
