# Performance diagnostics

{{ mpg-name }} provides a built-in tool for DBMS cluster performance diagnostics. Use it to analyze {{ PG }} performance metrics for [sessions](#get-sessions) and [queries](#get-queries).

## Enabling statistics collection {#activate-stats-collector}

{% list tabs %}

* Management console

   Enable the **Collect statistics** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings) (the option is disabled by default).

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable statistics collection, pass the `--performance-diagnostics` parameter in the update cluster command:

   ```bash
   {{ yc-mdb-pg }} cluster update <cluster id or cluster name> \
       ...
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<sessions sampling interval>,`
                                `statements-sampling-interval=<statements sampling interval> \
       ...
   ```

   Acceptable parameter values:

   - `sessions-sampling-interval`: Between `1` and `86400` seconds.
   - `statements-sampling-interval`: Between `60` and `86400` seconds.

* {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

* API

   Use the [create](../api-ref/Cluster/create.md) or [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter.
   * The `true` value in the `config.performanceDiagnostics.enabled` parameter.
   * A sessions sampling interval, in the `config.performanceDiagnostics.sessionsSamplingInterval` parameter. Acceptable values are between `1` and `86400` seconds.
   * A statements sampling interval, in the `config.performanceDiagnostics.statementsSamplingInterval` parameter. Acceptable values are between `60` and `86400` seconds.
   * List of cluster configuration fields to be changed in the `updateMask` parameter.

   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

{% endlist %}

## Getting session statistics {#get-sessions}

1. In the management console () go to the folder page and select **{{ mpg-name }}**.
1. Click on the name of the desired cluster and select **Performance diagnostics** → **Sessions**.

   To view session statistics or the history of queries executed within a session, select the appropriate tab.

   {% list tabs %}

   * Statistics

      To view session statistics:

      1. Specify the desired time interval.
      1. (Optional) Set filters.
      1. Select the desired data segment.

      To show or hide individual categories, click on the category name in the chart legend.

   * History

      To view the history of queries run during a session:

      1. Specify the desired time interval.
      1. (Optional) Set filters.

   {% endlist %}

For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Getting query statistics {#get-queries}

1. In the management console () go to the folder page and select **{{ mpg-name }}**.
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

For more information about what statistics you can get, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6).

## Getting information about query execution plans {#auto-explain-enable}

[The `auto_explain` module](https://www.postgresql.org/docs/current/auto-explain.html) lets you log execution plans for slow queries automatically, without the [`EXPLAIN` command](https://www.postgresql.org/docs/current/sql-explain.html). This is useful for tracking non-optimized queries. This logging feature uses the general {{ PG }} log.

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
