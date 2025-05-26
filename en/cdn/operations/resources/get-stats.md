---
title: Viewing CDN resource statistics
description: Follow this guide to view the CDN resource statistics.
---

# Viewing CDN resource statistics

{{ cdn-name }} automatically sends CDN resource performance metrics to [{{ monitoring-full-name }}](../../../monitoring/).

On average, {{ cdn-short-name }} metrics are updated every three minutes.

For a full list of metrics, see [this reference](../../metrics.md).

## Viewing overall statistics on the CDN resource page {#cdn-ui}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the CDN resource was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Select the CDN resource for which you want to get the statistics.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. Select the time period for which you want to view the statistics: 1 hour, 3 hours, 1 day, 1 week, or 1 month.

      The tab displays the following dashboards:

      * **Requests**: Number of CDN server requests per second.
      * **Origin_requests**: Number of origin requests per second.
      * **Bandwidth**: Speed of client connections to CDN servers.
      * **Origin_bandwidth**: Speed of CDN server connections to [origins](../../concepts/origins.md).
      * **Requests_codes**: Number of responses with HTTP codes from CDN servers.
      * **Origin_requests_codes**: Number of responses with HTTP codes from origins.
      * **Requests_total**: Total number of requests to CDN servers.
      * **Requests_waf_blocked/waf_passed**: Total number of requests to CDN servers allowed and blocked by the CDN provider WAF.
      * **Hit_bytes**: Amount of cached traffic.
      * **Hit_ratio**: Cached traffic ratio.

{% endlist %}

## Viewing detailed statistics in {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the CDN resource was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. In the left-hand panel, select ![image](../../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. In the query string, specify the following:
      1. **{{ cdn-name }}**.
      1. Metric you want to visualize.
      1. Metric label.

{% endlist %}