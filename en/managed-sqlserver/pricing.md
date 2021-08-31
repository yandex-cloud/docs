---
editable: false
---

# Pricing for {{ mms-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* `Running` cluster: You pay for software licenses, computing resources, storage, and backups.
* `Stopped` cluster: You're charged for storage and backups in full, but pricing for software licenses is described in [{#T}](#license). Computing resources are free of charge.

  {% note alert %}

  If a cluster uses local storage (`local-ssd`), its computing resources are not released when it's stopped and are charged in full.

  {% endnote %}

## What goes into the cost of using {{ mms-short-name }} {#rules}

The cost of {{ mms-name }} usage is based on:

* The cost of licenses for Microsoft Windows Server Datacenter and Microsoft SQL Server.

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Software license usage {#license}

You're charged for using licenses monthly on an pre-payment basis. This means that a fee is charged at the beginning of a billing period before you actually start using the service resources. In this case:

* If you stop or delete your cluster during the billing period, license costs for this period are not refunded.
* If you change the cluster configuration and reduce resource consumption, the cost of released licenses for this period is not refunded. A new cost is valid from the first day of the following month.
* If you create a new cluster or restart a previously stopped cluster during the billing period, the license cost is calculated based on the number of days remaining in the billing period. For example, if there are 30 days in the month and 7 days left until the end of the month, you'll pay 7/30 of the monthly license cost.
* If you change the cluster configuration and increase resource consumption, you need additional licenses. Their cost is calculated based on the number of days remaining in the billing period. For example, if there are 30 days in the month and 7 days left until the end of the month, you'll additionally pay 7/30 of the monthly cost of new licenses.

### DB host usage {#rules-hosts-uptime}

The cost of using DB hosts is calculated according to their class. Exact class characteristics are given in [{#T}](concepts/instance-types.md). The host usage fee is charged in accordance with the agreement.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for the time when the DB host is not performing its main functions.

### Disk space usage {#rules-storage}

The disk space usage fee is charged in accordance with the agreement. The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with three or more hosts in 100 GB increments.
    * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in 93 GB increments.
* Space used by DB backups in excess of the storage specified for the cluster.
    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.
    * During an automatic backup, {{ mms-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.
    * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, the cost of storing 1 GB for 1.5 minutes is equal to the cost of storage for 2 minutes).

## Pricing {#prices}

{% if region == "ru"%}

All prices are shown with VAT.

{% include [rub-pricing.md](../_pricing/managed-sqlserver/rub-pricing.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-pricing.md](../_pricing/managed-sqlserver/kzt-pricing.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-pricing.md](../_pricing/managed-sqlserver/usd-pricing.md) %}

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

{% if audience == "draft" %}

## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the aforementioned prices for using software licenses, vCPU, and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.ru/services/managed-sqlserver#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% if region == "ru"%}

{% include [rub-licence.md](../_pricing/managed-sqlserver/rub-licence.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-licence.md](../_pricing/managed-sqlserver/kzt-licence.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-licence.md](../_pricing/managed-sqlserver/usd-licence.md) %}

{% endif %}

{% endif %}