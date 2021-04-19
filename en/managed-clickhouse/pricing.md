---
editable: false
---
# Pricing for {{ mch-short-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mch-short-name }} {#rules}

The cost of {{ mch-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts);

* Settings and number of backups.

* Volume of outgoing traffic from Yandex.Cloud to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can choose the host class for {{ CH }} and ZooKeeper hosts (as appropriate for the expected replication load).

{% note warning %}

When you create a cluster with 2 or more {{ CH }}  hosts, 3  {{ ZK }} hosts with the minimal host class are created automatically to provide replication and fault tolerance for the cluster.

{% endnote %}

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You aren't charged for time when the DBMS or {{ ZK }} host isn't performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 2 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

{% if region == "ru"%}

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* with 3 {{ CH }} hosts with the host class `s1.micro` (2 vCPU, 8 GB RAM),
* with 3 automatically created {{ ZK }} hosts with the class `s1.nano` (1 vCPU, 4 GB RAM),
* with 100 GB of standard network storage.

Cost of resource usage:

* 1 hour of {{ CH }} host core usage with 100% vCPU — ₽1.43;
* 1 hour of usage of 1 GB RAM on the {{ CH }} host — ₽0.33;
* 1 hour of {{ ZK }} host core usage with 100% vCPU — ₽0.89;
* 1 hour of usage of 1 GB RAM on the {{ ZK }} host — ₽0.2;
* 1 month of usage 1 GB of standard network storage — ₽2.2881.

Cost per hour for all hosts: `3 × (2 × ₽1.43 + 8 × ₽0.33) + 3 × (1 × ₽0.89 + 4 × ₽0,2) = ₽21.57`

The total cost of the cluster in the month (hosts and storage): `720 × ₽21.57 + 100 × ₽2.2881 = ₽15,759.21`

{% endif %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mch-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {{ CH }} {#prices-clickhouse}

{% if region == "ru"%}

{% include [rub-host-ch.md](../_pricing/managed-clickhouse/rub-host-ch.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-host-ch.md](../_pricing/managed-clickhouse/kzt-host-ch.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host-ch.md](../_pricing/managed-clickhouse/usd-host-ch.md) %}

{% endif %}

### Host computing resources {{ ZK }} {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} resources with CVoS discounts.

{% endnote %}

{% if region == "ru"%}

{% include [rub-host-zoo.md](../_pricing/managed-clickhouse/rub-host-zoo.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-host-zoo.md](../_pricing/managed-clickhouse/kzt-host-zoo.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host-zoo.md](../_pricing/managed-clickhouse/usd-host-zoo.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/managed-clickhouse/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/managed-clickhouse/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/managed-clickhouse/usd-storage.md) %}

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

## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-clickhouse#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}


### {{ CH }} hosts {#calculated-clickhouse}

{% if region == "ru"%}

{% include [rub-ch-classes-hour.md](../_pricing/managed-clickhouse/rub-ch-classes-hour.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-ch-classes-hour.md](../_pricing/managed-clickhouse/kzt-ch-classes-hour.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-ch-classes-hour.md](../_pricing/managed-clickhouse/usd-ch-classes-hour.md) %}

{% endif %}


### ZooKeeper hosts {#prices-zookeeper}

{% if region == "ru"%}

  {% include [rub-zoo-classes-hour.md](../_pricing/managed-clickhouse/rub-zoo-classes-hour.md) %}

  {% endif %}

  {% if region == "kz"%}

  {% include [kzt-zoo-classes-hour.md](../_pricing/managed-clickhouse/kzt-zoo-classes-hour.md) %}

  {% endif %}

  {% if region == "int"%}

  {% include [usd-zoo-classes-hour.md](../_pricing/managed-clickhouse/usd-zoo-classes-hour.md) %}

  {% endif %}
