# Pricing rules for {{ ydb-name }} dedicated mode

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## What goes into the cost of using YDB {#rules}

When using {{ ydb-name }} in dedicated mode, you pay for the following:

* The type and size of [storage groups](../concepts/index.md#storage-groups) allocated for the DB.
* Allocated computing resources.

Other consumed resources to be additionally paid for:

* The space used in Object Storage to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the Internet.


{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Using computing resources {#rules-hosts-uptime}

The cost is calculated for each hour of VM operation in accordance with its class. Exact class characteristics are given in [{#T}](../concepts/index.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation).

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB storage groups.

* Space used by on-demand DB backups saved in Object Storage.

   {% note info %}

   For each DB, {{ ydb-full-name }} automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

   {% endnote %}

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}


### Host computing resources {#prices-compute-units}




{% include notitle [usd-compute-units.md](../../_pricing/ydb/usd-compute-units.md) %}


### Storage and backups {#prices-storage}




{% include notitle [usd-storage.md](../../_pricing/ydb/usd-storage.md) %}


### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}


