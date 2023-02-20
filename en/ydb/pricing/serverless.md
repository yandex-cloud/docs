# Pricing policy for {{ ydb-name }} Serverless mode

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will be effective once {{ ydb-name }} [becomes generally available](../../overview/concepts/launch-stages.md) (the date will be announced later). Before that, service usage is free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

When you use {{ ydb-name }} in Serverless mode, you are billed for each request made to the database. Users don't have to indicate the resources they need: the database quickly adapts to changes in the user load. Apart from requests, the user pays for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as restoring data from backups, are charged additionally.

## What goes into the cost of using {{ ydb-name }} Serverless mode {#rules}

When using {{ ydb-name }} in Serverless mode, you pay for the following:
* Data operations.
* The amount of stored data, including service data, such as indexes.
* Additional user operations, like restoring data from backups.

Other consumed resources to be additionally paid for:

* The space used in {{ objstorage-full-name }} to store on-demand backups.
* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Data operations and request units {#rules-ru}

The serverless mode of {{ ydb-name }} supports multiple ways to work with data:
* YQL is an SQL-like language for accessing relational tables, supported by the [SDK]{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-sdk/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-sdk/){% endif %}, [CLI]{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-cli/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-cli/){% endif %}, and management console in {{ ydb-short-name }}.
* Document API is the Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

You can also query the database through the special APIs available as stand-alone features in the {{ ydb-short-name }} SDK, CLI, or management console.

To calculate the cost of requests in {{ ydb-short-name }}, we use so-called _request units (RU)_. Each executed request, depending on its type, complexity, and data size, consumes a certain number of RU. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the RU costs for each request.

Rules for calculating the cost of requests to {{ ydb-short-name }} in RU:
* [YQL](ru-yql.md).
* [Document API](ru-docapi.md).
* [Special APIs](ru-special.md).
* [Topic operations](ru-topics.md).

#### Pricing for Request Unit consumption {#prices-ru}

* **Actual consumption (on-demand)**. The cost of using {{ ydb-short-name }} for a certain period is the number of spent Request Units multiplied by the price per Request Unit minus the monthly [free package](../../billing/concepts/serverless-free-tier.md#ydb). If there were no requests to the database or if the amount of RU spent in the current month is less than the free package, there is no charge for actual RU consumption.
* **Provisioned capacity**. If your load is predictable and has a fixed component, you can reduce the cost of using {{ ydb-short-name }} by paying part (or all) of RU spent at an hourly rate. To do this, set a non-zero value of the database parameter "Provisioned capacity, RU/s". After that, you are charged according to a special pricing plan, the rate for which is set to RU/s × hour, with billing per second. The consumption of RU within the specified capacity isn't added to the RU spent at the on-demand rate.

### Amount of data stored {#rules-storage}

In Serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data stored in the database. For example, creating a global index increases the total storage size by the index size.

For topics with on-demand pricing, you also pay for the actually used disk space. Its usage starts once each message is published in a topic and it's released once the retention period set for the topic expires.

### Creating backups {#rules-backup-storage}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days free of charge. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup, saving a copy to [{{ objstorage-name }}](../../storage/). The cost of this operation depends on the size of copied data and is calculated similarly to the [ReadTable](ru-special.md#readtable) operation. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you export data using the `ydb tools dump` utility, billing is based on the rates for the `ReadTable` operation.

{% endnote %}

### Restoring data from backups {#rules-backup-restore}

You can restore databases and individual tables from the backups stored in {{ objstorage-name }}. The cost of this operation depends on the size of recovered data and is calculated similarly to the [BulkUpsert](ru-special.md#bulkupsert) operation. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using the `ydb tools restore` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

## Pricing {% if product == "cloud-il" %}(after the service becomes public){% endif %} {#prices}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-serverless](../../_pricing/ydb/rub-serverless.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-serverless](../../_pricing/ydb/kzt-serverless.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-serverless](../../_pricing/ydb/usd-serverless.md) %}

{% endif %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-serverless](../../_pricing/ydb/ils-serverless.md) %}

{% include notitle [ils-egress-traffic.md](../../_pricing/ils-egress-traffic.md) %}

{% endif %}