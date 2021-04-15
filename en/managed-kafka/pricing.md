---
editable: false
---

# Pricing for {{ mkf-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* For a `Running` cluster, you are charged both for the computing resources and the size of storage.
* For a `Stopped` cluster, you are only charged for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The cost of {{ mkf-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts);

* Volume of outgoing traffic from Yandex.Cloud to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts (as appropriate for the expected replication load).

{% note warning %}

When you create a cluster with 2 or more {{ KF }} broker hosts, 3 {{ ZK }} hosts with the minimal host class are created automatically  in three availability zones to provide replication and fault tolerance for the cluster. If you create a cluster with a single broker host, then no {{ ZK }} hosts are created.

{% endnote %}

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You aren't charged for time when the broker host or {{ ZK }} host isn't performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 3 broker hosts in 100 GB increments.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* with 3 {{ KF }} broker hosts with the host class `s2.micro` (2 vCPU, 8 GB RAM),
* with 3 automatically created {{ ZK }} hosts with the class `b2.medium` (2 vCPU, 50% vCPU, 4 GB RAM),
* with 100 GB of standard network storage.

Cost per hour for all hosts: `3 × (2 × ₽1.05 + 8 × ₽0.28) + 3 × (2 × ₽0.49 + 4 × ₽0.20) = ₽18.36`

The total cost of the cluster in the month (hosts and storage): `720 × ₽18.36 + 100 × ₽2.2881 = ₽13,448.01`


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mkf-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {{ KF }} {#prices-kafka-brokers}

{% if region == "ru" %}

{% include notitle [rub-hosts-and-storage.md](../_pricing/managed-kafka/rub-hosts-and-storage.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-hosts-and-storage.md](../_pricing/managed-kafka/kzt-hosts-and-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-hosts-and-storage.md](../_pricing/managed-kafka/usd-hosts-and-storage.md) %}

{% endif %}


### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}


## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-kafka#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

### {{ KF }} broker hosts {#calculated-kafka-brokers}

{% if region == "ru" %}

{% include notitle [rub-calculated.md](../_pricing/managed-kafka/rub-calculated.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-calculated.md](../_pricing/managed-kafka/kzt-calculated.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-calculated.md](../_pricing/managed-kafka/usd-calculated.md) %}

{% endif %}

