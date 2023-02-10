# Working with queries

In {{yq-full-name}}, you can run [analytical](../concepts/batch-processing.md) and [streaming](../concepts/stream-processing.md) queries.

## Creating a query {#create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a query.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. On the top panel, click **New analytics query** or **New streaming query**.

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

### Viewing results {#view-result}

Query execution results are available in the **Result** tab as a table or schema.

{% note info %}

The following limitations apply to query execution results:
* You can only view the results of the last query execution.
* The results of a query are deleted in 24 hours.

{% endnote %}

### Errors {#errors}

Query execution errors are available in the **Errors** tab.

### Query plan {#plan}

The **Plan** tab shows [query execution stages](../concepts/request-processing.md).

### Monitoring query execution {#monitoring}

Using query execution metrics, you can diagnose in detail the performance of queries managed by {{yq-full-name}}. The **Monitoring** tab shows information about:

* Input data streams.
* Capacity used for running a query.
* Amount of RAM used.
* Amount of output data.

### Metadata {#meta}

The **Meta** section contains query metadata:
* Query ID.
* Query execution status.
* Date when the query was created, modified, and last executed.

## Viewing information about executed queries {#log}

{{yq-full-name}} logs the [execution history](../concepts/glossary.md#job) for each query.

To view the history of query runs:

1. In the [management console]({{ link-console-main }}), select the folder where you want to view the query execution history.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Queries**.
1. Select the desired query and click ![pencil](../../_assets/query/launch.svg) **Show launches** on the top panel.

## Renaming a query {#update-query-name}

To rename a query:

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
