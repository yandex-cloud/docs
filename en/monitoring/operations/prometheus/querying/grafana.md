---
title: "How to read and visualize metrics with Grafana"
description: "Use this guide to read and visualize metrics with Grafana."
---

# Reading and visualizing metrics with Grafana

{{ managed-prometheus-name }} supports the [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) and allows you to work with dashboards that you or the community created in {{ grafana-name }}.

## Connecting a data source {#data-source}

1. In the [management console]({{ link-console-main }}), select the folder where data is stored.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-viewer }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/api-key/create.md) for the service account.
1. Open the homepage of your {{ grafana-name }} installation.
1. In the main menu, select **Configuration → Data Sources**.
1. Click **Add data source**.
1. Under **Time series databases**, select **Prometheus**.
1. In the **Name** field, enter the data source name.
1. In the **URL** field, the **HTTP** section, specify the [previously obtained endpoint](../index.md#access).
1. Under **Custom HTTP headers**, click **Add Header** and add a header for authorization. In the **Header** field, type `Authorization` and set the **Value** field to `Bearer <Api-Key>`.
1. Click **Save & test**. You should see a message saying `The data source is working`.

## Current limitations {#restrictions}

The {{ prometheus-name }} [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) implementation only supports the following endpoints:

* `/api/v1/query`
* `/api/v1/query_range`
* `/api/v1/labels`
* `/api/v1/<label_name>/values`
* `/api/v1/series`

The following limitations apply:
* The `timeout` parameter is not supported and is ignored.
* The `start` and `end` parameters are not supported and are ignored for `/api/v1/labels`, `/api/v1/<label_name>/values`, and `/api/v1/series` requests.
* The maximum number of selectors that you can provide as the `match[]` parameter is 8.
* The maximum number of time series that you can get metadata for using `/api/v1/series` requests is 10,000.
* The maximum number of time series that can be read per `/api/v1/query` or `/api/v1/query_range` is 10,000.
* The `--query.lookback-delta` parameter value is `5m`.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
