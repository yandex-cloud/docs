# Using {{ yql-full-name }} syntax in {{ yq-full-name }}

In this tutorial, you'll learn how to use {{ yql-full-name }} syntax and perform operations with data (in this case, [analytical](#analytical-query) and [streaming](#stream-query) queries) in {{ yq-full-name }}.

All sample queries are run based on a ready-made dataset with New York City taxi trips for 2019-2021.

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Example of analytical queries {#analytical-query}

To create an analytical query and start the training:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left panel, select ![study](../../_assets/console-icons/graduation-cap.svg) **Tutorial**.
1. Click **Create connection**. In the Create connection section, all parameter fields are filled out, just type a description (optional) and click **Create**. You will be taken to the screen for creating data binding.
1. Type a description of data binding (optional) and click **Create**. Appropriate training resources are created.

In the list on the left panel, choose the desired training section:

1. [Select all columns](./select-all-columns.md).
1. [Select certain fields](./select-specific-columns.md).
1. [Sorting and filtering](./sort-filter.md).
1. [Data aggregation](./basic-aggregation.md).
1. [Aggregation additional conditions](./conditional-values.md).
1. [JSON](./json.md).

## Example of streaming queries {#stream-query}

To create a streaming query and start the training:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left panel, select ![study](../../_assets/console-icons/graduation-cap.svg) **Tutorial**.
1. Select `Streaming`.
1. Click **Create connection**. In the Create connection section, some parameter fields are completed.
1. Select or create a database.
1. Select or create a service account.
1. Click **Create**. You'll be taken to the screen for creating data binding.
1. Select or create a stream.
1. Type a description of data binding (optional) and click **Create**. Appropriate training resources are created.

In the list on the left panel, choose the desired training section:

1. [Querying real-time data](./streaming-query.md).

#### See also {#see-also}

[{{ yql-short-name }} syntax](https://ydb.tech/en/docs/yql/reference/syntax/)
