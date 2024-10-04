# Pricing policy for {{ ydb-name }} serverless mode



{% include [use-calculator](../../_includes/pricing/use-calculator.md) %}

{% include [link-to-price-list](../../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When you use {{ ydb-name }} in Serverless mode, you are billed for each request made to the database. Users do not have to indicate the resources they need: the database quickly adapts to changes in the user load. Apart from requests, the user pays for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as recovery from a backup, are charged extra.

## What goes into the cost of using {{ ydb-name }} Serverless mode {#rules}

When using {{ ydb-name }} in Serverless mode, you pay for the following:
* Data operations.
* Amount of stored data, including service data, such as indexes.
* Additional user operations, such as recovery from a backup.

Other consumed resources to be additionally paid for:

* Space used in {{ objstorage-full-name }} to store on-demand backups.
* Volume of outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Data operations and request units {#rules-ru}

The serverless mode of {{ ydb-name }} supports multiple ways to work with data:
* YQL is an SQL-like language for accessing relational tables that is supported by the [SDK](https://ydb.tech/en/docs/reference/ydb-sdk/), [CLI](https://ydb.tech/en/docs/reference/ydb-cli/), and the {{ ydb-short-name }} management console.
* Document API is the Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

You can also query the database through the special APIs available as stand-alone features in the {{ ydb-short-name }} SDK, CLI, or management console.

To calculate the cost of requests in {{ ydb-short-name }}, we use so-called _request units (RU)_. Each executed request, depending on its type, complexity, and data size, consumes a certain number of RUs. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the RU costs for each request.

Rules for calculating the cost of requests to {{ ydb-short-name }} in RU:
* [YQL](ru-yql.md).
* [Document API](ru-docapi.md).
* [Special APIs](ru-special.md).
* [Topic operations](ru-topics.md).

#### Pricing for Request Unit consumption {#prices-ru}

* **Actual consumption (on-demand)**. The cost of using {{ ydb-short-name }} for a certain period is the number of spent Request Units multiplied by the price per Request Unit minus the monthly [free package](../../billing/concepts/serverless-free-tier.md#ydb). If there were no requests to the database or if the amount of RUs spent in the current month is less than the free package, there is no charge for actual RU consumption.
* **Provisioned capacity**. If your load is predictable and has a fixed component, you can reduce the cost of using {{ ydb-short-name }} by paying for some (or all) RUs you spent at an hourly rate. To do this, set a non-zero value of the database parameter "Provisioned capacity, RU/s". After that, you are charged according to a special pricing plan, the rate for which is set to RU/s × hour, with billing per second. The RUs consumed within the specified capacity are not added to the RUs spent at the on-demand rate.

### Amount of data stored {#rules-storage}

In Serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data stored in the database. For example, creating a global index increases the total storage size by the index size.

For topics with on-demand pricing, you also pay for the actually used disk space. Its usage starts once each message is published in a topic and it is released once the retention period set for the topic expires.

### Creating backups {#rules-backup-storage}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days free of charge. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup, saving a copy to [{{ objstorage-name }}](../../storage/). The cost of this operation depends on the size of copied data and is calculated similarly to the [ReadTable](ru-special.md#readtable) operation. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you export data using `ydb tools dump`, billing is based on the `ReadTable` operation rates.

{% endnote %}

#### Example of calculating the cost of creating an on-demand backup {#example-of-cost-calculation-backup-storage}

Let's calculate the cost of creating backups of 1 GB and 10 GB databases.

**Cost calculation for a 1 GB database**

Actual (on-demand) consumption of RUs per month will be:

> 128 RUs × 1,024 = 131,072 RUs

Where:

* 128: Cost of request for 1 MB of data.
* 1,024: Amount of data copied, in MB.

The number of RUs spent (131,072) is [less than 1,000,000](#prices), so creating a backup will be free of charge.

**Cost calculation for a 10 GB database**

Actual (on-demand) consumption of RUs per month will be:



{% include [usd-storage](../../_pricing_examples/ydb/usd-storage.md) %}


### Recovery from a backup {#rules-backup-restore}

You can restore databases and individual tables from the backups stored in {{ objstorage-name }}. The cost of this operation depends on the size of recovered data and is calculated similarly to the [BulkUpsert](ru-special.md#bulkupsert) operation. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using `ydb tools restore`, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

#### Example of calculating the cost of recovery from a backup {#example-of-cost-calculation-backup-restore}

Let's calculate the cost of backup recovery for 1 GB and 1 GB databases.

**Cost calculation for a 1 GB database**

Actual (on-demand) consumption of RUs per month will be:

> 0.5 RUS × 1,024 × 1,024 = 524,288 RUS

Where:

* 0.5: Cost of request for 1 KB of data.
* 1,024 × 1,024: Amount of data recovered, in KB.

The number of RUs spent (524,288) is [less than 1,000,000](#prices), so recovery from a backup will be free of charge.

**Cost calculation for a 10 GB database**

Actual (on-demand) consumption of RUs per month will be:



{% include [usd-restore](../../_pricing_examples/ydb/usd-restore.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../../_includes/pricing-diff-regions.md) %}



{% include [usd-serverless](../../_pricing/ydb/usd-serverless.md) %}


{% include [egress-traffic-pricing](../../_includes/egress-traffic-pricing.md) %}

