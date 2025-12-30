---
title: '{{ mkf-full-name }} pricing policy'
description: This article covers the {{ mkf-name }} pricing policy.
editable: false
---

# {{ mkf-name }} pricing policy

In this section, you can find the {{ mkf-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources.

{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=688ba2e0d05a#calculator) on the {{ yandex-cloud }} website or check out the pricing below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

The prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The {{ mkf-name }} usage cost includes:

* Disk type and storage size.

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts) and the type of hosts.

* Outgoing traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The host operation cost is charged per hour based on what computing resources you allocate for it. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

You can choose the host class for {{ KF }} broker hosts, {{ ZK }} and {{ kraft-short-name }} hosts based on the expected replication load. Adding {{ ZK }} or {{ kraft-short-name }} hosts depends on the cluster configuration:

* {{ ZK }} hosts are added to the cluster if it contains more than one {{ KF }} host and uses {{ ZK }} as the coordination service.
* {{ ZK }} hosts are not added to the cluster if it contains a broker host.
* {{ kraft-short-name }} hosts are added to the cluster if its {{ KF }} version is 3.6 or higher and if it contains more than one {{ KF }} host and uses {{ kraft-short-name }} as the coordination service (on separate hosts).
* {{ kraft-short-name }} hosts are not added to the cluster if its {{ KF }} version is 3.6 or higher and if it uses {{ kraft-short-name }} as the coordination service (combined mode). 

The minimum billing unit is one minute (for example, 90 seconds of host operation count as two minutes). You do not pay for the time when a broker host, {{ ZK }}, or {{ kraft-short-name }} is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the storage allocated for DB clusters.

* You can only order local SSD storage (`local-ssd`) for clusters with three or more broker hosts:
    * For Intel Cascade Lake: In increments of 100 GB.
    * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.
* You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) for clusters with three or more broker hosts in increments of 93 GB.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds counts as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **{{ KF }} broker hosts**: Three `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **Storage for {{ KF }} broker hosts**: 100 GB of network HDD storage per broker host.
* **{{ ZK }} hosts** (created automatically): Three `b3-c1-m4` hosts: Intel Ice Lake, 2 × 50% vCPU, 4 GB RAM. 
* **Storage for {{ ZK }} hosts**: 10 GB of network SSD storage per host.




{% include [usd-hour](../_pricing_examples/managed-kafka/usd-hour.md) %}


## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mkf-name }} provides two types of CVoS: on vCPUs and on RAM for the hosts you intend to use in your DB clusters. In the management console, you can see how much you can potentially save with CVoS at the current consumption level. You can also forecast your monthly payments for the required number of vCPUs and RAM.

{% note info %}

CVoS discount is only available for certain types of resources. If the relevant CVoS columns under [Prices for the Russia region](#prices) are blank, this means the resource is not supported. Currently, you cannot order storage or web traffic this way.

{% endnote %}


## Prices for the Russia region {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}


You cannot order {{ ZK }} host resources via CVoS.

{% include [local-ssd for Intel Ice Lake only by request](../_includes/ice-lake-local-ssd-note.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.kafka }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.zk.kafka.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.kafka.highfreq-v4a.cores }}', '{{ pc|mdb.software_accelerated_network.kafka.highfreq-v3.cores }}', '{{ pc|mdb.software_accelerated_network.zk.kafka.highfreq-v3.cores }}', '{{ pc|mdb.cluster.kafka.backup }}' ]}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
