# Using {{ yql-full-name }} syntax in {{ yq-full-name }}

In this tutorial, you will learn how to use {{ yql-full-name }} syntax and perform data operations in {{ yq-full-name }} with [analytical](#analytical-query) and [streaming](#stream-query) query examples.

All examples use a ready-made dataset containing New York City taxi trips from 2019 to 2021.

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Analytical query example {#analytical-query}

To create an analytical query and get started:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
1. Click **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**. In the Create connection section, all settings are pre-filled. Just enter an optional description and click **{{ ui-key.yql.yq-connection-form.create.button-text }}**. You will see the Create data binding screen.
1. Enter the optional data binding description and click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**. The system will create the resources needed for this tutorial.

From the list on the left-hand panel, select a tutorial section:

1. [Selecting all columns](./select-all-columns.md).
1. [Selecting specific columns](./select-specific-columns.md).
1. [Sorting and filtering](./sort-filter.md).
1. [Data aggregation](./basic-aggregation.md).
1. [Aggregation conditions](./conditional-values.md).
1. [JSON](./json.md).

## Streaming query example {#stream-query}

To create a streaming query and get started:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
1. Select `{{ ui-key.yql.yq-tutorial.tutorial-type-toggle.option-streaming }}`.
1. Click **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**. In the `create connection` section, some settings are pre-filled.
1. Select an existing database or create a new one.
1. Select an existing service account or create a new one.
1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**. You will see the `create data binding` screen.
1. Select an existing data stream or create a new one.
1. Specify the optional data binding description and click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**. The system will create the resources needed for this tutorial.

From the list on the left-hand panel, select a tutorial section:

1. [Querying real-time data](./streaming-query.md).

#### See also {#see-also}

[{{ yql-short-name }} syntax]({{ ydb.docs }}/yql/reference/syntax/)
