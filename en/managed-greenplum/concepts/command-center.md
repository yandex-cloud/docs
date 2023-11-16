# {{ GP }} Command Center

_{{ GP }} Command Center_ monitors the metrics and execution plans of active queries, enables database administrators to interrupt individual queries and sessions, and provides a history of completed queries. In addition, it can be used for analyzing and tuning databases and their queries.

With the command center, you can view the following information:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**: Real-time state of sessions or queries, including their data and consumption metrics.
* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**: Snapshots of sessions or queries at specific points in the past.
* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**: History of completed queries, with the option to aggregate them by {{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-cpu-time }}, {{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-peak-memory }}, or another consumption metric for a specific point in time.

You can interrupt or get detailed information about any active session or query. For queries, you [can view](../operations/command-center.md) the execution plan and the JSON file, and for sessions, the history of the whole session and its individual queries.

{% note info %}

The Command Center is available in clusters with {{ GP }} version {{ versions.console.latest }} or higher.

{% endnote %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
