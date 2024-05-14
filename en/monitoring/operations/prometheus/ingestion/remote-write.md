---
title: "How to write metrics via the Remote API"
description: "Use this guide to write metrics via the Remote API."
---

# Writing metrics via the Remote API

To set up metric writes via the Remote API with Prometheus used as an agent for collecting metrics:

1. In the [management console]({{ link-console-main }}), select the folder where you want to store data.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-editor }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/api-key/create.md) for the service account.
1. Add the endpoint (`url`) to the `remote_write` section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write):
   ```yaml
   ...
   remote_write:
     ...
     - url: '<URL>' # provided upon request
       bearer_token: '<API_key>'
       # Or via a file (recommended):
       # bearer_token_file: '<name_of_the_file_with_the_API_key>'
       queue_config:
           max_samples_per_send: 2000 # 10,000 if using vmagent
           min_backoff: 100ms
           max_backoff: 15s
           # for Prometheus 2.26 or newer
           # retry_on_http_429: true
       metadata_config:
           send: false
   ```
1. Restart {{ prometheus-name }} or reload the configuration.
1. Make sure the {{ prometheus-name }} logs contain no errors related to the specified endpoint.

## Error examples {#errors}

| Error code | Description | Log example |
|----|----|----|
| `404` | Endpoint not found. Make sure the configuration specifies the correct `url`. | `ts=2024-04-04T09:59:15.973Z caller=dedupe.go:112 component=remote level=error remote_name=366d8d`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=105 exemplarCount=0 err="server returned HTTP status 404 Not Found:`<br/>`{\"status\":\"error\",\"errorType\":\"not_found\",\"error\":\"workspace not found: monb1piptmdo********\"}` |
| `401` | Service account not found. Make sure the configuration specifies the correct [API key](../../../../iam/concepts/authorization/api-key.md). | `ts=2024-04-12T12:55:10.124Z caller=dedupe.go:112 component=remote level=error remote_name=6b764c`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=1 exemplarCount=0 err="server returned HTTP status 401 Unauthorized:`<br/>`{\"error\":\"cannot authenticate by either token or api-key, cause: UNAUTHENTICATED: The token is invalid\",\"errorType\":\"\",\"status\":\"error\"}"` |
| `403` | No write permissions. Make sure the service account has the `{{ roles-monitoring-editor }}` role for the selected folder. | `ts=2024-04-05T17:10:47.706Z caller=dedupe.go:112 component=remote level=error remote_name=a9c26f`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=205 exemplarCount=0 err="server returned HTTP status 403 Forbidden:`<br/>`{\"error\":\"PERMISSION_DENIED: Permission denied\",\"errorType\":\"\",\"status\":\"error\"}"` |
| `413` | [Number of unique metrics](../index.md#limits) quota exceeded. | `ts=2024-04-05T16:48:16.002Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=205 exemplarCount=0 err="server returned HTTP status 413 Request Entity Too Large:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"more than 1000000 metrics in shard\"}` |
| `413` | [Number of metrics per write request](../index.md#limits) quota exceeded. | `ts=2024-04-05T17:39:29.102Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=10001 exemplarCount=0 err="server returned HTTP status 413 Request Entity Too Large:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"more than 10000 metrics from one URL\"}` |
| `429` | [Maximum data write speed in Remote Write format](../index.md#limits) quota exceeded. If the `retry_on_http_429` option is enabled, the data will be resent automatically and the load will be distributed over time. If the error persists, contact [support]({{ link-console-support }}). | `ts=2024-04-06T14:31:01.113Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="Failed to send batch, retrying" count=205 exemplarCount=0 err="server returned HTTP status 429 Too Many Requests:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"too many requests (bytes/sec)\"}` |
| `400` | Invalid Remote Write data format. | `ts=2024-04-07T13:42:10.543Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=499 exemplarCount=0 err="server returned HTTP status 400 Bad Request:`<br/>`{\"status\":\"error\",\"errorType\":\"bad_data\",\"error\":\"unrecognized remote write format (some headers are missing?): monb1piptmdo********\"}` |

## {{ prometheus-name }} metrics {#metrics}

| Metric name | Units | Explanations |
|----|----|----|
| `prometheus_remote_storage_sent_batch_duration_seconds` | Seconds | Write request execution time histogram. |
| `prometheus_remote_storage_bytes_total` | Bytes | Total number of bytes of data (not metadata) sent to remote storage after compression. |
| `prometheus_remote_storage_enqueue_retries_total` | Number | Total number of failed sample enqueue retries. |
| `prometheus_remote_storage_max_samples_per_send` | Number | Maximum number of samples sent per write request. |
| `prometheus_remote_storage_samples_dropped_total` | Number | Total number of samples read from the WAL but not sent to remote storage. |
| `prometheus_remote_storage_samples_failed_total` | Number | Total number of samples that failed to be sent to remote storage due to non-recoverable errors. |
| `prometheus_remote_storage_samples_pending` | Number | Number of pending samples to be sent to remote storage. |
| `prometheus_remote_storage_samples_retried_total` | Number | Total number of samples that failed to be sent to remote storage with their sending retried afterwards as the error was recoverable. |
| `prometheus_remote_storage_samples_total` | Number | Total number of samples sent to remote storage. |

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}

