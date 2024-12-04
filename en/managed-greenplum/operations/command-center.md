# Monitoring and managing sessions and queries in the Command Center

{{ GP }} Command Center provides the following functionality:

* [Viewing information about sessions and queries](#list).
* [Viewing the resource consumption history for completed queries](#consumption-history).
* [Aborting the current session](#terminate-session).
* [Terminating the current query](#terminate-query).

Check out these [use cases](#examples) for how and when you can use the Command Center.

For more information about the statistics you can get using the Command Center, see [{#T}](../concepts/command-center.md).

{% note info %}

The Command Center is available in clusters with {{ GP }} version 6.25 or higher.

{% endnote %}

## Viewing information about sessions and queries {#list}

You can view a list of sessions and queries with details on them. For each session, you can analyze its history and queries made within it. For each query, you can analyze its execution plan and a JSON file with details.

To view information about sessions and queries:

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and go to the ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
    1. Select what you want to view and go to relevant tab:

        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** for the current sessions and queries.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** for sessions or queries at a given point in the past.

    1. Go to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** or **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** section. In the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** tab, these are placed under the chart.
    1. To filter the session or query list, click ![image](../../_assets/console-icons/funnel.svg) **{{ ui-key.yacloud.common.label_filters }}** and select the relevant parameters.
    1. To view the details of:

        * Sessions: Click the session name.
        * Queries: Click the key of the query you are running.

{% endlist %}

## Viewing the resource consumption history for completed queries {#consumption-history}

The resource consumption history offers a number of system metrics. These show how a {{ mgp-name }} cluster was consuming resources to process queries at different points of time. You can also view a list of completed queries. Using this information, you can determine how to manage your cluster hosts' CPU and memory to process queries more effectively.

To view the resource consumption history for completed queries:

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and go to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**.
    1. Select the appropriate consumption metric:

        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-running-time-seconds }}**: Time it took the CPU resources to process the queries, seconds.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vm-peak-kb }}**: Maximum memory the cluster used to process a query during its lifetime.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-read-bytes }}**: Memory used for data reads, bytes.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-write-bytes }}**: Memory used for data writes to the DB, bytes.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-spill-total-bytes }}**: Additional memory used for query execution.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}**: Total memory used for query processing, bytes.

        Once you select the consumption metric, you will see a chart with detailed information and the list of queries. The chart will show the metric value, the name of the user who ran the query, and query execution time.

    1. To filter the results, click ![image](../../_assets/console-icons/funnel.svg) **{{ ui-key.yacloud.common.label_filters }}** and select the relevant parameters.

{% endlist %}

## Aborting the current session {#terminate-session}

To free up resources for sessions, you can abort a session, e.g., one that is `Idle`. To do this:

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and go to the ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
    1. In **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**, click ![image](../../_assets/console-icons/ellipsis.svg) in the appropriate line and select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.

        If you see **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**, select it and stop the query.

    1. Confirm stopping the session.

{% endlist %}

## Terminating the current query {#terminate-query}

To free up resources for queries, you can terminate a query, for example, an `Idle` query within an idle session. To do this:

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and go to the ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
    1. In **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**, click ![image](../../_assets/console-icons/ellipsis.svg) in the appropriate line and select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**.
    1. Confirm terminating the query.

{% endlist %}

## Examples {#examples}

### Identifying a current session that is consuming excessive resources {#current-session}

There might be cases when a user is no longer working with the database, but failed to terminate their session. In such cases, a session remains idle tying up cluster resources and degrading its performance. To identify and terminate such a session, do the following:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Click the cluster name and go to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
1. Filter the sessions by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
1. Find the longest lasting session in the `Idle` status.
1. Click its number. This will open a page with detailed info about this session.
1. Check when the last query was submitted in the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-started }}** field under **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-info }}**. If it has been a while, chances are the user is no longer using the database, but the session was not closed. You can terminate the session.
1. In the top-right corner, click **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.
1. Confirm stopping the session.

### Identifying CPU-intensive queries {#past-statements}

At times you might observe unusual spikes in the CPU consumption. To determine which queries caused the spikes, do the following:

1. Find out when the spike occurred:

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and go to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
    1. Set the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-cpu-usage }}** filter.
    1. Use the graph to find out the peak CPU consumption time.

        Hover over the highest point on the graph curve. You will see a pop-up displaying the cluster state information for the selected time. The time of the spike is indicated in that window.

1. Identify the CPU-intensive queries:

    1. Go to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}** tab.
    1. Set the time range based on the state history data.
    1. Group the queries by user, database, and query ID. This will group similar queries together.
    1. Filter the groups of queries by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**.
    1. Open the group with the highest **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** value.
    1. Check the details of each query and adjust them if needed. You can also [terminate a query](#terminate-query) that is still running.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
