---
title: Performance diagnostics in {{ mch-name }}
description: You can get performance metrics for queries and query groups in {{ mch-full-name }}.
---

# Performance diagnostics in {{ mch-name }}

{% note info %}

This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. To get access, contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}

{{ mch-name }} allows you to collect performance metrics of queries in a cluster. The feature is available in {{ CH }} version 25.3 and higher.

## Enabling statistics collection {#activate-stats-collector}

{% list tabs group=instructions %}

- Management console {#console}

  To enable statistics collection, select **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** when [creating](cluster-create.md#create-cluster) or [updating](update.md) a cluster. This option is disabled by default.


{% endlist %}

## Getting query statistics {#get-queries}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the ![image](../../_assets/console-icons/heart-pulse.svg) **Performance diagnostics** tab.

      To view query history or statistics, select the relevant tab. The data is displayed for the selected time period.
  
  1. Optionally, add query filters:
      
      1. Select hosts.
      1. Select users.
      1. Select query result: `QueryFinish`, `ExceptionBeforeStart`, or `ExceptionWhileProcessing`.
      1. Select query type.

  1. To view query info, select the query of interest in the **History** tab. This will open the query page.
  
      For queries of 5 seconds and longer, the following charts will be displayed:

      * **Chart CPU**: CPU usage.
      * **Chart memory**: RAM usage.
      * **Chart rows**: Number of rows read and added via the query.
      * **Chart bytes**: Amount of data read and added via the query, in bytes.

{% endlist %}

## Getting query group statistics {#get-query-groups}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the ![image](../../_assets/console-icons/heart-pulse.svg) **Performance diagnostics** tab.
  1. Navigate to the **{{ ui-key.yacloud.clickhouse.PerformanceDiagnostics.ClusterDiagnosticsTabs.label_query-groups_w3anM }}** tab.

      The page displays unique queries for the selected time period.
  
  1. Optionally, add query filters:
      
      1. Select hosts.
      1. Select users.
      1. Select query result: `QueryFinish`, `ExceptionBeforeStart`, or `ExceptionWhileProcessing`.
      1. Select query type.

{% endlist %}