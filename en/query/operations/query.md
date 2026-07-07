# Managing queries

[Queries](../concepts/glossary.md#query) include connection settings and YQL statements.

## Creating a query {#create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a query.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. In the top panel, click **{{ ui-key.yql.yq-ide-header.new-analytics-query.button-text }}** or **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
1. Enter the query text in the input field.

## Validating a query {#parse}

To check your query without running it, click **Validate**.

## Running a query {#run}

{% list tabs %}

- Analytical query

  Analytical queries only support direct execution. To run a query, enter its text and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

- Streaming query

  Streaming queries support continued execution. You can run a new query or continue one already in progress.

  * To run a new query, click ![run](../../_assets/console-icons/play-fill.svg) **Run from current**.
  * To continue a streaming query from the latest [checkpoint](../concepts/glossary.md#checkpoint), click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.continue-query.button-text }}**. If you need to resume the query after switching data sources, click ![option](../../_assets/console-icons/chevron-down.svg) and select **{{ ui-key.yql.yq-query-actions.continue-force-query.button-text }}**.

  {% note info %}

  Streaming queries process unlimited data streams. Unlike analytical queries, streaming queries can run indefinitely.

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

## Viewing query execution details {#view-result}

You can check query execution details in the following tabs:

* **{{ ui-key.yql.yq-query-results.result.tab-text }}**: Query results presented as a table or schema. Query results are only available for the latest query run and only for 24 hours afterward.
* **{{ ui-key.yql.yq-query-results.issues.tab-text }}**: Query error details.
* **{{ ui-key.yql.yq-query-results.plan.tab-text }}**: Query [stage](../concepts/request-processing.md) details.
* **{{ ui-key.yql.yq-query-results.statistics.tab-text }}**: Query metrics containing the following information:
  * Incoming data streams.
  * Computing resources used by the query.
  * RAM used.
  * Output size.
* **{{ ui-key.yql.yq-query-results.meta.tab-text }}**: Query metadata:
  * Query ID
  * Query status.
  * Query creation, update, and last run timestamps.

## Viewing query run history {#log}

{{ yq-full-name }} logs [run history](../concepts/glossary.md#jobs) for each query.

1. In the [management console]({{ link-console-main }}), select the folder with queries whose history you want to check.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Select the query you need and click ![pencil](../../_assets/console-icons/rocket.svg) **{{ ui-key.yql.yq-show-query-launches.show-launches.button-text }}** on the top panel.

## Renaming a query {#update-query-name}

1. In the [management console]({{ link-console-main }}), select the folder containing the query you want to rename.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Locate the query you need and click ![pencil](../../_assets/console-icons/pencil.svg) next to its name on the panel.
1. Specify the new query name and click ![check](../../_assets/console-icons/check.svg).

## Editing a query {#update}

To update a query, type the new query text and click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**. If the query is running, [stop](#stop) it before making any changes.

## Cloning a query {#clone}

To simplify your workflow, you can clone queries along with their text:

1. In the [management console]({{ link-console-main }}), select the folder containing the query you want to clone.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Locate the query you need and click **{{ ui-key.yql.yq-query-actions.clone.link-text }}**. To clone a query with a different type, click ![option](../../_assets/console-icons/chevron-down.svg) and select **Clone as…**.

## Deleting a query {#delete}

1. In the [management console]({{ link-console-main }}), select the folder containing the query you want to delete.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Click ![delete](../../_assets/console-icons/trash-bin.svg) next to the query you want to delete.
1. Confirm query deletion.
