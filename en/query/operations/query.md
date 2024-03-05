# Managing queries

[Queries](../concepts/glossary.md#query) contain a set of YQL statements for handling data and connection parameters.

## Creating a query {#create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a query.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. In the top panel, click **{{ ui-key.yql.yq-ide-header.new-analytics-query.button-text }}** or **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
1. Enter the query text in the input field.

## Checking a query {#parse}

To check the text of your query without executing it, click **Validate**.

## Running a query {#run}

{% list tabs %}

- Analytical query

   Analytical queries only support a scenario that allows running queries. To run a query, enter its text and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

- Streaming query

   Streaming queries support a scenario that allows a new query to be run while the current one is in progress.

   * To run a new query, click ![run](../../_assets/console-icons/play-fill.svg) **Run from current**.
   * To resume a streaming query from the last [checkpoint](../concepts/glossary.md#checkpoint), click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.continue-query.button-text }}**. If you need to resume a query after changing the data source, click ![option](../../_assets/console-icons/chevron-down.svg) and select **{{ ui-key.yql.yq-query-actions.continue-force-query.button-text }}**.

   {% note info %}

   Streaming queries are made on data streams that are not limited. Unlike an analytical query, a streaming query can run endlessly.

   {% endnote %}

{% endlist %}

## Stopping a query {#stop}

To stop a query:

{% list tabs %}

- Analytical query

   Click ![stop](../../_assets/console-icons/stop-fill.svg) **{{ ui-key.yql.yq-job-query-actions.stop-query.button-text }}**.

- Streaming query

   * Click ![stop](../../_assets/console-icons/stop-fill.svg) **{{ ui-key.yql.yq-job-query-actions.stop-query.button-text }}** to create a [checkpoint](../concepts/glossary.md#checkpoint) and stop the query.
   * Click ![stop](../../_assets/console-icons/stop-fill.svg) **{{ ui-key.yql.yq-job-query-actions.force-stop-query.button-text }}** to stop the query without creating a checkpoint.

{% endlist %}

## Viewing query execution information {#view-result}

You can view the query progress in the following tabs:

* **{{ ui-key.yql.yq-query-results.result.tab-text }}**: Query results as a table or schema. You can only view the results of the last query execution within 24 hours.
* **{{ ui-key.yql.yq-query-results.issues.tab-text }}**: Information about query execution errors.
* **{{ ui-key.yql.yq-query-results.plan.tab-text }}**: Information about [query execution stages](../concepts/request-processing.md).
* **{{ ui-key.yql.yq-query-results.statistics.tab-text }}**: Query metrics with the following data:
  * Input data streams.
  * Capacity used for running the query.
  * Amount of RAM used.
  * Amount of output data.
* **{{ ui-key.yql.yq-query-results.meta.tab-text }}**: Query metadata:
  * Query ID.
  * Query execution status.
  * Date when the query was created, modified, and last executed.

## Viewing the history of query runs {#log}

{{ yq-full-name }} logs each query's [run history](../concepts/glossary.md#jobs).

1. In the [management console]({{ link-console-main }}), select the folder where you want to view the query execution history.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. In the top panel, select a query and click ![pencil](../../_assets/console-icons/rocket.svg) **{{ ui-key.yql.yq-show-query-launches.show-launches.button-text }}**.

## Renaming a query {#update-query-name}

1. In the [management console]({{ link-console-main }}), select the folder where you want to rename a query.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Select the query and click ![pencil](../../_assets/console-icons/pencil.svg) next to the query name on the panel.
1. Enter a new name for the query and click ![check](../../_assets/console-icons/check.svg).

## Editing a query {#update}

To edit a query, enter a new query text and click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**. If the query is running, [stop](#stop) it to edit the query text.

## Cloning a query {#clone}

For convenience, you can clone a query with the original query text:

1. In the [management console]({{ link-console-main }}), select the folder where you want to clone a query.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Select the query and click **{{ ui-key.yql.yq-query-actions.clone.link-text }}**. To clone it to a query of a different type, click ![option](../../_assets/console-icons/chevron-down.svg) **Clone as…**.

## Deleting a query {#delete}

1. In the [management console]({{ link-console-main }}), select the folder to delete the query from.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Click ![delete](../../_assets/console-icons/trash-bin.svg) next to the name of the query to delete.
1. Confirm query deletion.
