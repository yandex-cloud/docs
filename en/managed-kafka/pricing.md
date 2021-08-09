---
editable: false
---

# Pricing for {{ mkf-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* For a `Running` cluster, you pay both for the computing resources and storage size.
* For a `Stopped` cluster, you pay only for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The cost of {{ mkf-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts).

* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts (as appropriate for the expected replication load).

{% note warning %}

When you create a cluster with two or more {{ KF }} broker hosts, three {{ ZK }} hosts with the minimal host class are created automatically in three availability zones to provide replication and fault tolerance for the cluster. If you create a cluster with a single broker host, no {{ ZK }} hosts are created.

{% endnote %}

The minimum billing unit is one minute (for example, the cost of 1.5 minutes of operation is the same as the cost of 2 minutes of operation). You are not charged for the time when a broker host or {{ ZK }} doesn't perform its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with three or more broker hosts in 100 GB increments.
    * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more broker hosts in 93 GB increments.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, the cost of storing 1 GB for 1.5 minutes is equal to the cost of storage for 2 minutes).

{% if region == "ru"%}

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* With 3 {{ KF }} broker hosts with the `s2.micro` host class (2 vCPUs, 8 GB RAM).
* With 3 automatically created {{ ZK }} hosts with the `b2.medium` class (2 vCPUs, 50% vCPU, 4 GB RAM).
* With 100 GB of standard network storage.

Cost per hour for the hosts: `3 × (2 × ₽1.05 + 8 × ₽0.28) + 3 × (2 × ₽0.49 + 4 × ₽0.20) = ₽18.36`

Total cost per cluster per month (hosts and storage): `720 × ₽18.36 + 100 × ₽2.2881 = ₽13,448.01`

{% endif %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mkf-name}} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

## Pricing {#prices}

### {{ KF }} broker host computing resources {#prices-kafka-brokers}

{% if region == "ru" %}

{% include notitle [rub-hosts-and-storage.md](../_pricing/managed-kafka/rub-hosts-and-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-hosts-and-storage.md](../_pricing/managed-kafka/kzt-hosts-and-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-hosts-and-storage.md](../_pricing/managed-kafka/usd-hosts-and-storage.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

## Estimated prices for host classes {#calculated-host-price}

Prices for host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-kafka#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

### {{ KF }} broker hosts {#calculated-kafka-brokers}

{% if region == "ru" %}

For a month of host operation at the rate of 720 hours per month, rounded to an integer, RUB.

{% include notitle [rub-calculated.md](../_pricing/managed-kafka/rub-calculated.md) %}

{% endif %}

{% if region == "kz" %}

For a month of host operation at the rate of 720 hours per month, rounded to an integer, KZT.

{% include notitle [kzt-calculated.md](../_pricing/managed-kafka/kzt-calculated.md) %}

{% endif %}

{% if region == "int" %}

For a month of host operation at the rate of 720 hours per month, rounded to an integer, USD.

{% include notitle [usd-calculated.md](../_pricing/managed-kafka/usd-calculated.md) %}

{% endif %}
