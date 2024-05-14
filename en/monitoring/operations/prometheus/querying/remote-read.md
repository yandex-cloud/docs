---
title: "How to read metrics via the Remote API"
description: "Use this guide to read metrics via the Remote API."
---

# Reading metrics via the Remote API

1. In the [management console]({{ link-console-main }}), select the folder where data is stored.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-viewer }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/api-key/create.md) for the service account.
1. Add the endpoint (`url`) to the `remote_read` section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read):
   ```yaml
   ...
   remote_read:
     ...
     - url: '<URL>' # provided upon request
       bearer_token: '<API_key>'
       # Or via a file (recommended):
       # bearer_token_file: '<name_of_the_file_with_the_API_key>'

       # We recommend adding a user-defined X-Lookback-Delta header.
       # If you did not change the lookback-delta parameter value in the configuration
       # of your Prometheus instance, specify the default value, 5m.
       # This info is required for optimized decimation.
       headers:
         X-Lookback-Delta: 5m

       # By default, data is only requested for the time ranges
       # not featured in the Prometheus local storage (older than the Storage retention).
       # If you want to request data at any time, which makes sense if read and write operations
       # are performed from different Prometheus instances, enable the following option:
       # [ read_recent: true ]

       # If you want to read only some of the metrics via the Remote API, specify their labels:
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

| Metric name | Units | Explanations |
|----|----|----|
| `prometheus_remote_storage_read_queries_total` | Invocations | Total number of read requests |
| `prometheus_remote_storage_read_request_duration_seconds` | Seconds | Read request execution time histogram |

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
