# Pricing policy for {{ ydb-name }} Serverless mode



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


When you use {{ ydb-name }} in Serverless mode, you are billed for each request made to the database. Users don't have to indicate the resources they need: the database quickly adapts to changes in the user load. Apart from requests, the user pays for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as restoring data from backups, are charged additionally.

## What goes into the cost of using {{ ydb-name }} Serverless mode {#rules}

When using {{ ydb-name }} in Serverless mode, you pay for the following:
* Data operations.
* The amount of stored data, including service data, such as indexes.
* Additional user operations, like restoring data from backups.

Other consumed resources to be additionally paid for:
* The space used in Object Storage to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the Internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Data operations and request units {#rules-ru}

The serverless mode of {{ ydb-name }} supports multiple ways to work with data:
* YQL is an SQL-like language that allows you to work with relational tables and is supported by the [SDK](https://ydb.tech/en/docs/reference/ydb-sdk/), [CLI](https://ydb.tech/en/docs/reference/ydb-cli/), and management consoles {{ ydb-short-name }}.
* Document API is the Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

You can also query the database through the special APIs available as stand-alone features in the SDK, CLI, or management console {{ ydb-short-name }}.

To calculate the cost of requests in {{ ydb-short-name }}, we use a concept called _request units (RU)_. Each executed request, depending on its type, complexity, and data size, consumes a certain number of RU. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the RU costs for each request.

Rules for calculating the cost of requests to {{ ydb-short-name }} in RU:
* [YQL](ru-yql.md).
* [Document API](ru-docapi.md).
* [Special APIs](ru-special.md).
* [Topic operations](ru-topics.md).

#### Pricing for Request Unit consumption {#prices-ru}

* **Actual consumption (on-demand)**. The cost of using {{ ydb-short-name }} for a certain period is the number of Request Units spent multiplied by the price per Request Unit minus the monthly [free package](../../billing/concepts/serverless-free-tier.md#ydb). If there were no requests to the database or if the amount of RU spent in the current month is less than the free package, there is no charge for actual RU consumption.
* **Provisioned capacity**. If your load is predictable and has a fixed component, you can reduce the cost of using {{ ydb-short-name }} by paying part (or all) of RU spent at an hourly rate. To do this, set a non-zero value of the database parameter "Provisioned capacity, RU/s". After that, you are charged according to a special pricing plan, the rate for which is set to RU/s × hour, with billing per second. The consumption of RU within the specified capacity isn't added to the RU spent at the on-demand rate.

### Amount of data stored {#rules-storage}

In Serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data stored in the database. For example, creating a global index increases the total storage size by the index size.

For topics with on-demand pricing, you also pay for the actually used disk space. Its usage starts once each message is published in a topic and it's released once the retention period set for the topic expires.

### Creating backups {#rules-backup-storage}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days free of charge. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup, saving a copy to [{{ objstorage-full-name }}](../../storage/). The cost of this operation depends on the amount of data copied. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you export data using the `ydb tools dump` utility, billing is based on the rates for the `ReadTable` operation.

{% endnote %}

### Restoring data from backups {#rules-backup-restore}

You can restore databases and individual tables from the backups stored in Object Storage. The cost of this operation depends on the amount of data restored. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using the `ydb tools restore` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

## Pricing  {#prices}





{% include notitle [usd-serverless](../../_pricing/ydb/usd-serverless.md) %}





{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}



