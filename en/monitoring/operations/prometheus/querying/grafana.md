---
title: How to read and visualize metrics with {{ grafana-name }}
description: Follow this guide to read and visualize metrics with {{ grafana-name }}.
---

# Reading and visualizing metrics with {{ grafana-name }}

{{ managed-prometheus-name }} supports the [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) and enables you to work with dashboards you or your community created in {{ grafana-name }}.

The recommended visualization types are charts and dashboards in [{{ monitoring-name }}](monitoring.md).

{% include [grafana-export](../../../../_includes/monitoring/grafana-export.md) %}

## Connecting a data source {#data-source}

1. In the [management console]({{ link-console-main }}), go to the folder that stores your data.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-viewer }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account.
1. Open your {{ grafana-name }} homepage.
1. In the main menu, select **Configuration → Data Sources**.
1. Click **Add data source**.
1. Under **Time series databases**, select **Prometheus**.
1. In the **Name** field, enter the data source name. 
1. In the **URL** field under **HTTP**, specify the [previously obtained endpoint](../index.md#access).
1. Under **Custom HTTP headers**, click **Add Header** and add an authorization header. In the **Header** field, enter `Authorization` and in the **Value** field, `Bearer <API_key>`.
1. Click **Save & test**. You should see a message saying `The data source is working`.

## Error examples {#errors}

| Error code | Description | Error message |
|----|----|----|
| `404` | Endpoint not found. Make sure the configuration specifies the correct `url`. | ```not_found: workspace not found: monb1piptmdo********``` |
| `401` | Service account not found. Make sure the configuration specifies the correct [API key](../../../../iam/concepts/authorization/api-key.md). | ```auth: cannot authenticate by either token or api-key, cause: UNAUTHENTICATED: The token is invalid``` |
| `403` | No read permissions. Make sure the service account has the `{{ roles-monitoring-viewer }}` role for the selected folder. | ```auth: PERMISSION_DENIED: Permission denied```|
| `429` | [Number of HTTP API read requests per second](../index.md#limits) quota exceeded | ```execution: too many requests: monb1piptmdo********``` |
| `400` | Too many lines returned in the response. Try refining your query. | ```bad_data: Too many metrics are loaded by selectors {job=='grafana'}, expected not more than: 20000``` |

## Current limitations {#restrictions}

{{ managed-prometheus-name }} works on TCP port 443. Its public IP address is 158.160.59.216. This address may change over time. To avoid losing access to the service, we recommend using additional addresses [from the list of available ones](../../../../overview/concepts/public-ips.md).

The {{ prometheus-name }} [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) only supports the following endpoints:

* `/api/v1/query`
* `/api/v1/query_range`
* `/api/v1/labels`
* `/api/v1/<label_name>/values`
* `/api/v1/series`

The following limitations apply:
* The `timeout` parameter is not supported and is ignored.
* The `start` and `end` parameters are not supported and are ignored for the `/api/v1/labels`, `/api/v1/<label_name>/values`, and `/api/v1/series` requests.
* The maximum number of selectors you can provide in the `match[]` parameter is 8.

{% include [maximum-time-lines](../../../../_includes/monitoring/maximum-time-lines.md) %}

* `--query.lookback-delta` is set to `5m`.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
