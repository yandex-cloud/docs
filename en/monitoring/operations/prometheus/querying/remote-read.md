---
title: How to read metrics via the Remote API
description: Follow this guide to read metrics via the Remote API.
---

# Reading metrics via the Remote API

1. In the [management console]({{ link-console-main }}), go to the folder that stores your data.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-viewer }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account.
1. Add the endpoint (`url`) to the `remote_read` section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read):
   ```yaml
   ...
   remote_read:
     ...
     - url: '<URL>' # You can get it upon request.
       bearer_token: '<API_key>'
       # Alternatively, you can use a file (recommended):
       # bearer_token_file: '<name_of_file_with_API_key>'

       # We recommend adding the `X-Lookback-Delta` custom header.
       # If you did not change the `lookback-delta` value in
       # your Prometheus instance configuration, specify the default value, `5m`.
       # This information is required for optimized decimation.
       headers:
         X-Lookback-Delta: 5m

       # The default behavior limits data queries to time ranges
       # missing from the Prometheus local storage (usually those beyond the storage retention).
       # If your reads and writes use different Prometheus instances,
       # consider enabling the following option to always fetch data:
       # [ read_recent: true ]

       # If you only want to read specific metrics via the Remote API, provide their labels:
       # required_matchers:
       # [ <label_name>: <label_value> ... ]
   ```
1. Restart {{ prometheus-name }} or reload the configuration.

## Error examples {#errors}

| Error code | Error message | Description |
|----|----|----|
| `404` | Endpoint not found. Make sure the configuration specifies the correct `url`. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 404 Not Found: {"status":"error","errorType":"not_found","error":"workspace not found: monb1piptmdo********"}` |
| `401` | Service account not found. Make sure the configuration specifies the correct [API key](../../../../iam/concepts/authorization/api-key.md). | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 401 Unauthorized: {"status":"error","errorType":"","error":"cannot authenticate by either token or api-key, cause: UNAUTHENTICATED: The token is invalid"}` |
| `403` | No read permissions. Make sure the service account has the `{{ roles-monitoring-viewer }}` role for the selected folder. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 403 Forbidden: {"status":"error","errorType":"","error":"PERMISSION_DENIED: Permission denied"}` |
| `429` | [Number of Remote Read API read requests per second](../index.md#limits) quota exceeded. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 429 Too Many Requests: {"status":"error","errorType":"execution","error":"too many read requests: monb1piptmdo********"}` |
| `400` | Too many lines returned in the response. Try refining your query. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 400 Bad Request: {"status":"error","errorType":"bad_data","error":"Too many metrics are loaded by selectors {job=='grafana'}, expected not more than: 10000"}` |

## {{ prometheus-name }} metrics {#metrics}

| Metric name | Units | Comment |
|----|----|----|
`prometheus_remote_storage_read_queries_total` | Calls | Total read requests
`prometheus_remote_storage_read_request_duration_seconds` | Seconds | Read request duration histogram

## Current limitations {#restrictions}

{% include [maximum-time-lines](../../../../_includes/monitoring/maximum-time-lines.md) %}

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
