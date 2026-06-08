---
title: Pricing policy for Serverless mode in {{ ydb-full-name }}
description: This article covers the {{ ydb-name }} pricing policy for Serverless mode.
editable: false
---

# Pricing policy for Serverless mode in {{ ydb-name }}



{% note tip %}




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=02fcbc53c755#calculator) on our website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [vat](../../_includes/vat.md) %}

When using {{ ydb-name }} in *Serverless* mode, you pay for each database query. You do not have to specify which resources you need since the database quickly adjusts to changes in the workload. Apart from queries, you also pay for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as recovery from a backup, are charged extra.

## What goes into the cost of using {{ ydb-name }} in Serverless mode {#rules}

When using {{ ydb-name }} in *Serverless* mode, you pay for:
* Data operations.
* Amount of stored data, including service data, such as indexes.
* Additional user operations, such as recovery from a backup.

In addition, you pay for the following resources you consume:

* Space used in {{ objstorage-full-name }} to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Data operations and request units {#rules-ru}

In *Serverless* mode, {{ ydb-name }} can work with data in several ways:
* YQL: SQL dialect to work with relational tables supported by the {{ ydb-short-name }} [SDK]({{ ydb.docs }}/reference/ydb-sdk/), [CLI]({{ ydb.docs }}/reference/ydb-cli/), and the management console.
* Document API: Amazon’s DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

You can also query the database through the special APIs available as standalone features in the {{ ydb-short-name }} SDK, CLI, or management console.

To calculate the cost of queries in {{ ydb-short-name }}, we use the so-called _request units (RU)_. Each completed query, depending on its type, complexity, and data amount, consumes a certain number of RUs. The total cost of all completed queries against {{ ydb-short-name }} is the sum of the RU costs for each query.

Below, you can find the rules for calculating the cost of queries against {{ ydb-short-name }} in RUs:
* [YQL](ru-yql.md).
* [Document API](ru-docapi.md).
* [Special APIs](ru-special.md).
* [Topic operations](ru-topics.md).

#### Pricing for request unit consumption {#prices-ru}

* **On-demand consumption**. The cost of using {{ ydb-short-name }} for a certain period is the number of spent RUs multiplied by the price per RU minus the monthly [free package](../../billing/concepts/serverless-free-tier.md#ydb). If there were no queries against the database or if the amount of RUs spent in the current month is less than the free package, there is no charge for the actual RU consumption.
* **Provisioned capacity**. If your load is predictable and has a fixed component, you can reduce the cost of using {{ ydb-short-name }} by paying for some (or all) RUs you spent on an hourly basis. To do this, set a non-zero value for the _Provisioned capacity, RU/s_ property. After that, you will be charged according to a special pricing plan, the rate for which is set to RU/s per hour, with billing per second. The RUs consumed within the provisioned capacity will not be added to the RUs spent at the on-demand rate.

### Amount of stored data {#rules-storage}

In *Serverless* mode, data storage capacities are allocated automatically. The amount of stored data is calculated as the total amount of user and service data stored in the database. For example, creating a global index will increase the total storage size by this index size.

For topics with on-demand pricing, you also pay for the actually used disk space. Each message published in a topic uses the disk space and frees it once the retention period set for the topic expires.

### Creating backups {#rules-backup-storage}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup, saving it to [{{ objstorage-name }}](../../storage/). The cost of this operation depends on the backup data size and is calculated as for the [ReadTable](ru-special.md#readtable) operation. For cost calculation, the actual size is rounded up to a multiple of 1 GB.

{% note warning %}

If you export data using `ydb tools dump`, the billing is based on the `ReadTable` operation pricing.

{% endnote %}

#### Example of calculating the cost of creating an on-demand backup {#example-of-cost-calculation-backup-storage}

Let's calculate the cost of creating backups of 1 GB and 10 GB databases.

**Cost calculation for a 1 GB database**

On-demand consumption of RUs per month will be:

> 128 RUs × 1,024 = 131,072 RUs

Where:

* 128: Cost of query per MB of data.
* 1,024: Amount of backed up data, in MB.

The number of RUs spent (131,072) is [less than 1,000,000](#prices), so creating a backup will be free of charge.

**Cost calculation for a 10 GB database**

On-demand consumption of RUs per month will be:



{% include [usd-storage](../../_pricing_examples/ydb/usd-storage.md) %}


### Recovery from a backup {#rules-backup-restore}

You can restore databases and/or individual tables from the backups stored in {{ objstorage-name }}. The cost of this operation depends on the size of recovered data and is calculated as for the [BulkUpsert](ru-special.md#bulkupsert) operation. For cost calculation, the actual size is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using `ydb tools restore`, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

#### Example of calculating the cost of recovery from a backup {#example-of-cost-calculation-backup-restore}

Let's calculate the cost of backup recovery for 1 GB and 10 GB databases.

**Cost calculation for a 1 GB database**

On-demand consumption of RUs per month will be:

> 0.5 RUs × 1,024 × 1,024 = 524,288 RUs

Where:

* 0.5: Cost of query per KB of data.
* 1,024 × 1,024: Amount of data to recover, in KB.

The number of RUs spent (524,288) is [less than 1,000,000](#prices), so recovery from a backup will be free of charge.

**Cost calculation for a 10 GB database**

On-demand consumption of RUs per month will be:



{% include [usd-restore](../../_pricing_examples/ydb/usd-restore.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|ydb }}']}
    skuIds={['{{ pc|ydb.v1.serverless.requests }}', '{{ pc|ydb.v1.serverless.provisioned_rcu }}', 
    '{{ pc|ydb.v1.serverless.storage }}', '{{ pc|ydb.db.backup.v1 }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

