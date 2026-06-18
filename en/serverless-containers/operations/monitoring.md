---
title: Viewing container monitoring charts
description: Follow this guide to view container monitoring charts.
---

# Viewing container monitoring charts

You can monitor container activity using monitoring tools in the management console. These tools display diagnostic information as charts. [{{ monitoring-name }}](../../monitoring/) collects metric values and displays charts. 

The chart refresh interval is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your container.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container for which you want to view monitoring charts.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. You will see the following charts:
      * **Requests**: Number of container requests.
      * **Requests latency**: Average time for a container to process a request.
      * **Errors**: Number of errors that occurred while the container was processing a request.

      You can select a time period for which you want to display information on the graph. It can be an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [metrics](../../_includes/serverless-containers/metrics.md) %}