# Monitoring and managing sessions and queries in the Command Center

In the [{{ GP }} Command Center](../concepts/command-center.md), you can:

* [{#T}](#list).
* [{#T}](#consumption-history).
* [{#T}](#terminate-session).
* [{#T}](#terminate-query).

{% note info %}

The Command Center is available in clusters with {{ GP }} version 6.25 or higher.

{% endnote %}

## Viewing information about sessions and queries {#list}

You can view a list of sessions and queries with details on them. For each session, you can analyze its history and queries made within it. For each query, you can analyze its execution plan and a JSON file with details.

To view information about sessions and queries:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and go to the ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
   1. Select what you want to view and go to relevant tab:

      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** for the current sessions and queries.
      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** for sessions or queries at a given point in the past.

   1. Go to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** or **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** section. In the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** tab, these are placed under the chart.
   1. To filter the session or query list, click ![image](../../_assets/mdb/mgp-command-center-filter.svg) **{{ ui-key.yacloud.common.label_filters }}** and select relevant parameters.
   1. To view the details of:

      * Sessions: Click the session name.
      * Queries: Click the key of the query you are running.

{% endlist %}

## Viewing the resource consumption history for completed queries {#consumption-history}

The resource consumption history offers a number of system metrics. These show how a {{ mgp-name }} cluster was consuming resources to process queries at different points of time. You can also view a list of completed queries. Using this information, you can determine how to manage your cluster hosts' CPU and memory to process queries more effectively.

To view the resource consumption history for completed queries:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and go to the ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}** tab.
   1. Select the appropriate consumption metric:

      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-running-time-seconds }}**: Time, in seconds, it took the CPU resources to process queries.
      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vm-peak-kb }}**: Maximum memory the cluster used to handle a query during its lifetime.
      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-read-bytes }}**: Memory used for data reads, bytes.
      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-write-bytes }}**: Memory used for data writes to the DB, bytes.
      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-spill-total-bytes }}**: Additional memory used for query execution.
      * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}**: Total memory used for query processing, bytes.

      Once you select the consumption metric, you will see a chart with detailed information and the list of queries. The chart will show the metric value, the name of the user who ran the query, and query execution time.

   1. To filter the results, click ![image](../../_assets/mdb/mgp-command-center-filter.svg) **{{ ui-key.yacloud.common.label_filters }}** and select relevant parameters.

{% endlist %}

## Aborting the current session {#terminate-session}

To free up resources for sessions, you can abort a session, for example, an `Idle` one. To do this:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and go to the ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
   1. In **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**, click ![image](../../_assets/options.svg) in the appropriate line and select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.

      If you see **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**, select it and stop the query.

   1. Confirm stopping the session.

{% endlist %}

## Aborting the current query {#terminate-query}

To free up resources for queries, you can abort a query, for example, an `Idle` query within an idle session. To do this:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and go to the ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
   1. In **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**, click ![image](../../_assets/options.svg) in the appropriate line and select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**.
   1. Confirm stopping the session.

{% endlist %}
