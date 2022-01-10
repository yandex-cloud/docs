---
editable: false
---

# Pricing for {{ mmy-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The cost of {{ mmy-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one minute (for example, the cost of 1.5 minutes of operation is the same as the cost of 2 minutes of operation). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with three or more hosts:
        * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
        * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

    * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in 93 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, the cost of storing 1 GB for 1.5 minutes is equal to the cost of storage for 2 minutes).

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mmy-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% if region == "ru" %}

{% include notitle [rub-host.md](../_pricing/managed-mysql/rub-host.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-host.md](../_pricing/managed-mysql/kzt-host.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-host.md](../_pricing/managed-mysql/usd-host.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../_pricing/managed-mysql/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../_pricing/managed-mysql/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../_pricing/managed-mysql/usd-storage.md) %}

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

Prices for host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-mysql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% if region == "ru" %}

For a month of host operation at the rate of 720 hours per month, rounded to an integer, RUB.

{% include notitle [rub-classes-hour.md](../_pricing/managed-mysql/rub-classes-hour.md) %}

{% endif %}

{% if region == "kz" %}

For a month of host operation at the rate of 720 hours per month, rounded to an integer, KZT.

{% include notitle [kzt-classes-hour.md](../_pricing/managed-mysql/kzt-classes-hour.md) %}

{% endif %}

{% if region == "int" %}

For a month of host operation at the rate of 720 hours per month, rounded to an integer, USD.

{% include notitle [usd-classes-hour.md](../_pricing/managed-mysql/usd-classes-hour.md) %}

{% endif %}
