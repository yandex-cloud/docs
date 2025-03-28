---
title: "How to read\_metrics via the Remote API"
description: "Use this guide to read\_metrics via the Remote API."
---

# Reading metrics via the Remote API

1. In the [management console]({{ link-console-main }}), select the folder where the data is stored.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-viewer }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account.
1. Add the endpoint (`url`) to the `remote_read` section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read):
   ```yaml
   ...
   remote_read:
     ...
     - url: '<URL>' # Available on request
       bearer_token: '<API_key>'
       # Or via a file (recommended):
       # bearer_token_file: '<name_of_file_with_API_key>'

       # We recommend adding the X-Lookback-Delta custom header.
       # If you did not change the lookback-delta parameter value in
       # your Prometheus instance configuration, specify the default value, 5m.
       # This information is required for optimized decimation.
       headers:
         X-Lookback-Delta: 5m

       # By default, data is only requested for the time ranges
       # not featured in the Prometheus local storage (older than the Storage retention).
       # If you want to be able to request data always, which makes sense if read and write operations
       # are made from different Prometheus instances, enable the following option:
       # [ read_recent: true ]

       # If you want to read only some metrics via the Remote API, specify their labels:
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
| `429` | [Number of Remote Read API read requests per second](../index.md#limits) quota exceeded | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 429 Too Many Requests: {"status":"error","errorType":"execution","error":"too many read requests: monb1piptmdo********"}` |
| `400` | Too many lines returned from the request. Try refining your request. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 400 Bad Request: {"status":"error","errorType":"bad_data","error":"Too many metrics are loaded by selectors {job=='grafana'}, expected not more than: 10000"}` |

## {{ prometheus-name }} metrics {#metrics}

| Metric name | Units | Comment |
|----|----|----|
`prometheus_remote_storage_read_queries_total` | Invocations | Total number of read requests
`prometheus_remote_storage_read_request_duration_seconds` | Seconds | Read request execution time histogram

## Current limitations {#restrictions}

{% include [maximum-time-lines](../../../../_includes/monitoring/maximum-time-lines.md) %}

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
