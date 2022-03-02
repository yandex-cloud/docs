---
editable: false
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

## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

### Host computing resources {#prices-compute-units}

{% if region == "ru" %}

{% include notitle [rub-compute-units.md](../../_pricing/ydb/rub-compute-units.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-compute-units.md](../../_pricing/ydb/kzt-compute-units.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-compute-units.md](../../_pricing/ydb/usd-compute-units.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if region == "ru" %}

{% include notitle [rub-storage.md](../../_pricing/ydb/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-storage.md](../../_pricing/ydb/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-storage.md](../../_pricing/ydb/usd-storage.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% endif %}

## Estimated cost of computing resources {#calculated-prices}

{% if region == "ru" %}

{% include notitle [rub-dedicated.md](../../_pricing/ydb/rub-dedicated.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-dedicated.md](../../_pricing/ydb/kzt-dedicated.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-dedicated.md](../../_pricing/ydb/usd-dedicated.md) %}

{% endif %}

