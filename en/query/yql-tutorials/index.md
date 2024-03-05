# Using {{ yql-full-name }} syntax in {{ yq-full-name }}

In this tutorial, you will learn how to use {{ yql-full-name }} syntax and perform operations with data in {{ yq-full-name }} using an example of [analytical](#analytical-query) and [streaming](#stream-query) queries.

All sample queries are run based on a ready-made dataset with New York City taxi trips for 2019-2021.

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Example of analytical queries {#analytical-query}

To create an analytical query and start the training:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
1. Click **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**. In the Create connection section, all parameter fields are pre-filled. Enter a description (optional) and click **{{ ui-key.yql.yq-connection-form.create.button-text }}**. This will take you to the data binding creation screen.
1. Enter the data binding description (optional) and click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**. Appropriate training resources will be created.

In the list on the left panel, choose a training section:

1. [Select all columns](./select-all-columns.md).
1. [Select certain fields](./select-specific-columns.md).
1. [Sorting and filtering](./sort-filter.md).
1. [Data aggregation](./basic-aggregation.md).
1. [Aggregation additional conditions](./conditional-values.md).
1. [JSON](./json.md).

## Example of streaming queries {#stream-query}

To create a streaming query and start the training:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
1. Select `{{ ui-key.yql.yq-tutorial.tutorial-type-toggle.option-streaming }}`.
1. Click **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**. In the Create connection section, some parameter fields are pre-filled.
1. Select or create a database.
1. Select or create a service account.
1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**. This will take you to the data binding creation screen.
1. Select or create a stream.
1. Enter the data binding description (optional) and click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**. Appropriate training resources will be created.

In the list on the left panel, choose a training section:

1. [Querying real-time data](./streaming-query.md).

#### See also {#see-also}

[{{ yql-short-name }} syntax](https://ydb.tech/en/docs/yql/reference/syntax/)
