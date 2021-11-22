# Performance diagnostics

{{ mpg-name }} provides a built-in tool for DBMS cluster performance diagnostics. Use it to analyze {{ PG }} performance metrics for [sessions](#get-sessions) and [queries](#get-queries).

## Enabling statistics collection {#activate-stats-collector}

To use the diagnostics tool, enable the **Collect statistics** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings) (the option is disabled by default).

If necessary, set intervals for gathering statistics for sessions and queries.

## Getting information about sessions {#get-sessions}

You can get the history of queries run during a session as well as session statistics, such as:

- A chart with the number of sessions for the selected data segment. You can hide or show individual categories in the chart by clicking on the category name in the chart legend.
- A table with statistics for sessions and queries.

For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

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

You can get query statistics and compare statistic data for two time intervals.

For example, 10 `SELECT * FROM cities` queries were executed in the first interval and 20 in the second. When comparing statistics, the difference by the "number of queries" metric (the `Calls` column in the table) will be `+100%`.

For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6).

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

## Getting information about query execution plans {#auto-explain-enable}

The [`auto_explain` module](https://www.postgresql.org/docs/current/auto-explain.html) enables you to log a slow query execution plan automatically without using the [`EXPLAIN` command](https://www.postgresql.org/docs/current/sql-explain.html). This is useful for tracking non-optimized queries. This logging feature uses the general {{ PG }} log.

To enable query logging, [change the DBMS settings](update.md#change-postgresql-config):

1. Use the **Shared preload libraries** field to select the `auto_explain` option.

1. Enable the **Auto explain log analyze** setting.

1. Define the `auto_explain` module settings:

    {% note warning %}

    Selecting `0` for **Auto explain log min duration** or enabling **Auto explain log timing** can significantly reduce cluster performance.

    {% endnote %}
	
    * [**Auto explain log buffers**](../concepts/settings-list.md#setting-auto-explain-log-buffers)
    * [**Auto explain log min duration**](../concepts/settings-list.md#setting-auto-explain-log-min-duration)
    * [**Auto explain log nested statements**](../concepts/settings-list.md#setting-auto-explain-log-nested-statements)
    * [**Auto explain log timing**](../concepts/settings-list.md#setting-auto-explain-log-timing)
    * [**Auto explain log triggers**](../concepts/settings-list.md#setting-auto-explain-log-triggers)
    * [**Auto explain log verbose**](../concepts/settings-list.md#setting-auto-explain-log-verbose)
    * [**Auto explain sample rate**](../concepts/settings-list.md#setting-auto-explain-sample-rate)

