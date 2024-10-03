---
title: Viewing bucket metrics
description: Follow this guide to view bucket metrics.
---

# Viewing bucket metrics

{{ objstorage-name }} automatically delivers bucket performance metrics to [{{ monitoring-full-name }}](../../../monitoring).

You can view overall performance statistics on the [bucket page](#storage-ui), with detailed metrics available from the [{{ monitoring-name }} interface](#monitoring).

For a full list of metrics, see the [reference](../../metrics.md).

## View overall statistics on the bucket page {#storage-ui}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Select the bucket you want to get the statistics for.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. Select the time period to view statistics for: one hour, three hours, one day, one week, or one month.

      The tab displays the following dashboards:

      * **Read Requests**: Number of GET, HEAD, LIST, and OPTIONS requests.
      * **Modify Requests**: Number of PUT, POST, and DELETE requests.
      * **Traffic**: Outgoing traffic size.
      * **Objects counts**: Number of bucket [objects](../../concepts/object).
      * **Space by object type**: Breakdown of total storage space used by object type (single part objects, multipart objects, or object parts).
      * **Space by storage type**: Breakdown of total storage space used by [storage class](../../concepts/storage-class).

{% endlist %}

## View detailed statistics in {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. In the left-hand panel, select ![image](../../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
   1. In the query string, select the parameters:
      1. **{{ objstorage-name }}** service.
      1. Metric values you want to visualize.
      1. Label for the metric.

{% endlist %}