---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Performance diagnostics

{{ mpg-name }} provides a built-in tool for DBMS cluster performance diagnostics. Use it to analyze performance metrics {{ PG }} for [sessions](#get-sessions) and [queries](#get-queries).

{% note info %}

This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Enabling statistics collection {#activate-stats-collector}

To use the diagnostics tool, enable the **Collect statistics** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings) (the option is disabled by default).

If necessary, set the intervals for gathering session and query statistics.

## Getting information about sessions {#get-sessions}

You can get the history of queries run during a session as well as session statistics, such as:

- A chart with the number of sessions for the selected data segment. You can hide or show individual categories in the chart by clicking on the category name in the chart legend.
- A table with statistics for sessions and queries.

For more information about what statistics you can get, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

{% list tabs %}

- Session statistics
  1. In the management console, go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster and select the **Performance diagnostics** tab.
  1. Select **Sessions → Statistics**.
  1. Specify the time interval and, if necessary, set filters.
  1. Choose the desired [data segment](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW) from the list.

- Query history
  1. In the management console, go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster and select the **Performance diagnostics** tab.
  1. Select **Sessions → History**.
  1. Specify the time interval and, if necessary, set filters.

{% endlist %}

## Getting information about queries {#get-queries}

You can get query statistics and see their comparison over two time intervals.

For example, 10 `SELECT * FROM cities` queries were executed in the first interval and 20 in the second. When comparing the statistics, the difference by the "number of queries" metric (the `Calls` column in the table) will be `+100%`.

For more information about what statistics you can get, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6).

{% list tabs %}

- Query statistics
  1. In the management console, go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster and select the **Performance diagnostics** tab.
  1. Select **Queries → Interval**.
  1. Specify the time interval and, if necessary, set filters.

- Comparing queries
  1. In the management console, go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster and select the **Performance diagnostics** tab.
  1. Select **Queries → 2 Intervals**.
  1. Specify the desired intervals and, if necessary, set filters.

{% endlist %}

