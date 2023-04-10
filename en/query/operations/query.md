# Managing queries

[Queries](../concepts/glossary.md#query) contain a set of YQL statements for handling data and connection parameters.

## Creating a query {#create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a query.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. On the top panel, click **New analytics query** or **New streaming query**.
1. Enter the query text in the input field.

## Checking a query {#parse}

To check the text of your query without executing it, click **Validate**.

## Running a query {#run}

{% list tabs %}

- Analytical query

   Analytical queries only support a scenario that allows running queries. To run a query, enter its text and click ![run](../../_assets/query/run.svg) **Run**.

- Streaming query

   Streaming queries support a scenario that allows a new query to be run while the current one is in progress.

   * To run a new query, click ![run](../../_assets/query/run.svg) **Run from current**.
   * To continue to execute a streaming query from the last [checkpoint](../concepts/glossary.md#checkpoint), click ![run](../../_assets/query/run.svg) **Continue**. If query execution needs to be continued after changing the data source, click ![option](../../_assets/query/option.svg) and select **Continue (force)**.

   {% note info %}

   Streaming queries are made on data streams that are not limited. Unlike an analytical query, a streaming query can run endlessly.

   {% endnote %}

{% endlist %}

## Stopping a query {#stop}

To stop a query:

{% list tabs %}

- Analytical query

   Click ![stop](../../_assets/query/stop.svg) **Stop**.

- Streaming query

   * Click ![stop](../../_assets/query/stop.svg) **Stop** to create a [checkpoint](../concepts/glossary.md#checkpoint) and stop the query.
   * Click ![stop](../../_assets/query/stop.svg) **Force stop** to stop the query without creating a checkpoint.

{% endlist %}

## Viewing query execution information {#view-result}

You can view the query progress in the following tabs:

* **Result**: Query execution results as a table or schema. You can only view the results of the last query execution within 24 hours.
* **Plan**: Information about [query execution stages](../concepts/request-processing.md).
* **Monitoring**: Query execution metrics with the following data:
  * Input data streams.
  * Capacity used for running the query.
  * Amount of RAM used.
  * Amount of output data.
* **Metadata**: Query metadata:
  * Query ID.
  * Query execution status.
  * Date when the query was created, modified, and last executed.
* **Issues**: Information about query execution errors.

## Viewing the history of query runs {#log}

{{ yq-full-name }} logs each query's [run history](../concepts/glossary.md#jobs).

1. In the [management console]({{ link-console-main }}), select the folder where you want to view the query execution history.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. Select the desired query and click ![pencil](../../_assets/query/launch.svg) **Show launches** on the top panel.

## Renaming a query {#update-query-name}

1. In the [management console]({{ link-console-main }}), select the folder where you want to rename a query.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. Select the desired query and click ![pencil](../../_assets/query/pensil.svg) on the panel next to the query name.
1. Enter a new name for the query and click ![check](../../_assets/query/check.svg).

## Editing a query {#update}

To edit a query, enter a new query text and click **Run**. If the query is running, [stop](#stop) it to edit the query text.

## Cloning a query {#clone}

For convenience, you can clone a query with the original query text:

1. In the [management console]({{ link-console-main }}), select the folder where you want to clone a query.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. Select the query and click **Clone**. To clone it to a query with a different type, click ![option](../../_assets/query/delete.svg) **Clone as…**

## Deleting a query {#delete}

1. In the [management console]({{ link-console-main }}), select the folder to delete the query from.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. Click ![delete](../../_assets/query/delete.svg) next to the name of the query to delete.
1. Confirm query deletion.
