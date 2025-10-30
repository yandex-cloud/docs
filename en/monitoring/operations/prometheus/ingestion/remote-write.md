---
title: How to write metrics via the Remote API
description: Follow this guide to write metrics via the Remote API.
sourcePath: en/monitoring_includes/operations/prometheus/ingestion/remote-write.md
---

# Writing metrics via the Remote API

To set up metric writing via the Remote API with Prometheus used as an agent for collecting metrics:

1. In the [management console]({{ link-console-main }}), select the folder where you want to store data.
1. [Create a service account](../../../../iam/operations/sa/create.md) with the `{{ roles-monitoring-editor }}` role for the selected folder.
1. [Create an API key](../../../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account.
1. Add the endpoint (`url`) to the `remote_write` section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write):
   ```yaml
   ...
   remote_write:
     ...
     - url: 'https://{{ api-host-monitoring-1 }}/prometheus/workspaces/<workspace_ID>/api/v1/write'
       bearer_token_file: '<name_of_file_with_API_key>'
       # Alternatively, you can add the key itself (not recommended):
       # bearer_token: '<API_key>'
       queue_config:
           max_samples_per_send: 2000 # 10,000 if using `vmagent`
           min_backoff: 100ms
           max_backoff: 15s
           # For Prometheus 2.26 or higher
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
| `403` | No write permissions. Make sure the service account has the `{{ roles-monitoring-editor }}` role for the selected folder.| `ts=2024-04-05T17:10:47.706Z caller=dedupe.go:112 component=remote level=error remote_name=a9c26f`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=205 exemplarCount=0 err="server returned HTTP status 403 Forbidden:`<br/>`{\"error\":\"PERMISSION_DENIED: Permission denied\",\"errorType\":\"\",\"status\":\"error\"}"` |
| `413` | [Number of unique metrics](../index.md#limits) quota exceeded. | `ts=2024-04-05T16:48:16.002Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=205 exemplarCount=0 err="server returned HTTP status 413 Request Entity Too Large:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"more than 1000000 metrics in shard\"}`| 
| `413` | [Number of metrics per write request](../index.md#limits) quota exceeded. | `ts=2024-04-05T17:39:29.102Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=10001 exemplarCount=0 err="server returned HTTP status 413 Request Entity Too Large:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"more than 10000 metrics from one URL\"}` |
| `429` | [Maximum data write speed in Remote Write format](../index.md#limits) quota exceeded. If `retry_on_http_429` is enabled, the data will be resent automatically and the load will be distributed over time. If the error persists, contact [support]({{ link-console-support }}). | `ts=2024-04-06T14:31:01.113Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="Failed to send batch, retrying" count=205 exemplarCount=0 err="server returned HTTP status 429 Too Many Requests:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"too many requests (bytes/sec)\"}` |
| `400` | Invalid Remote Write data format. | `ts=2024-04-07T13:42:10.543Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=499 exemplarCount=0 err="server returned HTTP status 400 Bad Request:`<br/>`{\"status\":\"error\",\"errorType\":\"bad_data\",\"error\":\"unrecognized remote write format (some headers are missing?): monb1piptmdo********\"}` |

## {{ prometheus-name }} metrics {#metrics}

| Metric name | Units | Comment |
|----|----|----|
`prometheus_remote_storage_sent_batch_duration_seconds` | Seconds | Write request execution time histogram
`prometheus_remote_storage_highest_timestamp_in_seconds`  | Seconds | Most recent timestamp written to the WAL
`prometheus_remote_storage_queue_highest_sent_timestamp_seconds`  | Seconds | Most recent timestamp sent to remote storage
`prometheus_remote_storage_bytes_total`  | Bytes | Total data bytes (non-metadata) sent to remote storage after compression
`prometheus_remote_storage_enqueue_retries_total`  | Count | Total number of failed sample enqueue retries
`prometheus_remote_storage_max_samples_per_send`  | Count | Maximum number of samples sent per write request
`prometheus_remote_storage_samples_dropped_total`  | Count | Total samples read from the WAL but not sent to remote storage
`prometheus_remote_storage_samples_failed_total`  | Count | Total samples that could not be sent to remote storage due to non-recoverable errors.
`prometheus_remote_storage_samples_pending`  | Count | Number of pending samples to send to remote storage
`prometheus_remote_storage_samples_retried_total`  | Count | Total samples that could not be sent to remote storage but were retried as the send error was recoverable.
`prometheus_remote_storage_samples_total`  | Count | Total samples sent to remote storage
`prometheus_remote_storage_shards`  | Count | Total shards used for sending samples to remote storage
`prometheus_remote_storage_shards_min`  | Count | Minimum number of shards available
`prometheus_remote_storage_shards_max`  | Count | Maximum number of shards available
`prometheus_remote_storage_shards_desired`  | Count | Result of calculating the optimal number of shards to process the total incoming samples.
`prometheus_wal_watcher_current_segment`  | Number | Current WAL read segment
`prometheus_tsdb_wal_segment_current`  | Number | Current WAL write segment

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}

