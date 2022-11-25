# Performance diagnostics in {{ mmy-name }}

{{ mmy-name }} has a built-in tool for collecting session and query statistics. These metrics can be useful when [analyzing the performance and optimizing the settings](../tutorials/profiling-mmy.md) of a cluster.

## Enabling statistics collection {#activate-stats-collector}

Enable the **Collect statistics** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings) (the option is disabled by default).

Set the **Sessions sampling interval** and **Statements sampling interval**. Both are measured in seconds.

## Getting session statistics {#get-sessions}

1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mmy-name }}**.
1. Click on the name of the desired cluster and select **Performance diagnostics** → **Sessions**.

   To view session statistics or the history of queries executed within a session, select the appropriate tab.

   {% list tabs %}

   * Statistics

      To view session statistics:

      1. Specify the desired time interval.
      1. (Optional) Set filters.
      1. Select the desired [data segment](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).

      To show or hide individual categories, click on the category name in the chart legend.

   * History

      To view the history of queries run during a session:

      1. Specify the desired time interval.
      1. (Optional) Set filters.

   {% endlist %}


## Getting query statistics {#get-queries}

1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mmy-name }}**.
1. Click on the name of the desired cluster and select **Performance diagnostics** → **Queries**.

   To view query statistics or compare them in two time intervals, select the appropriate tab.

   {% list tabs %}

   * Interval

      To view query statistics:

      1. Select the desired time interval.
      1. (Optional) Set filters.

   * Two intervals

      To get information about the relative change in the query statistics:

      1. In the **Interval 1** field, select the time interval to be used as a calculation basis for statistics.
      1. In the **Interval 2** field, select the time interval to compare the statistics for interval 1 with.
      1. (Optional) Set filters.

      For example, 10 `SELECT * FROM cities` queries were executed in the first interval and 20 in the second. When comparing statistics, the difference by the <q>number of queries</q> metric (the `Calls` column in the table) will be `+100%`.

   {% endlist %}

For more information about what statistics you can get, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).
