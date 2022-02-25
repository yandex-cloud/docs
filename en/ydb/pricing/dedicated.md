---
editable: false
sourcePath: en/ydb/overlay/pricing/dedicated.md
---

# Pricing rules for {{ ydb-name }} dedicated mode

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## What goes into the cost of using YDB {#rules}

When using {{ ydb-name }} in dedicated mode, you pay for the following:

* The type and size of [storage groups](../concepts/databases.md#storage-groups) allocated for the DB.
* Allocated computing resources.

Other consumed resources to be additionally paid for:

* The space used in {{ objstorage-name }} to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Use of computing resources {#rules-hosts-uptime}

The cost is calculated for each hour of VM operation in accordance with its class. Exact class characteristics are given in [Basic concepts](../concepts/databases.md#compute-units).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation).

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB storage groups.

* Space used by on-demand DB backups saved in {{ objstorage-name }}.

   {% note info %}

   For each DB, Yandex Database automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

   {% endnote %}

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Discount for committed volumes of services (CVoS) {#cvos}

You can get a guaranteed discount on service resource usage when you commit for a month, year, or three years.

Yandex Database provides two types of [CVoS](../../billing/concepts/cvos.md): for vCPUs and RAM for the DB hosts. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for DBs that use a specific class of VMs.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

### Host computing resources {#prices-compute-units}




{% include notitle [usd-compute-units.md](../../_pricing/ydb/usd-compute-units.md) %}

### Storage and backups {#prices-storage}




{% include notitle [usd-storage.md](../../_pricing/ydb/usd-storage.md) %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

## Estimated cost of computing resources {#calculated-prices}




{% include notitle [usd-dedicated.md](../../_pricing/ydb/usd-dedicated.md) %}

