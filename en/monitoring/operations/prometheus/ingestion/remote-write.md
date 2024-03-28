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

* No endpoint found
   > ```ts=2022-11-09T20:55:43.329Z caller=dedupe.go:112 component=remote level=error remote_name=1d1b77 url=https://monitoring.{{ api-host }}/workspaces/monb1piptmdo********/prometheus/api/v1/write msg="non-recoverable error" count=499 exemplarCount=0 err="server returned HTTP status 404 Not Found: {\"type\":\"NOT_FOUND\",\"message\":\"workspace not found: monb1piptmdo********\",\"code\":404}"```
* Write request limit exceeded
   > ```ts=2022-10-27T20:11:26.806Z caller=dedupe.go:112 component=remote level=error remote_name=f0fd14 url=https://monitoring.{{ api-host }}/workspaces/monb1piptmdo********/prometheus/api/v1/write msg="non-recoverable error" count=500 exemplarCount=0 err="server returned HTTP status 429 Too Many Requests: {\"type\":\"RESOURCE_EXHAUSTED\",\"message\":\"too many write requests (bytes/sec): monb1piptmdo********\",\"code\":429}"```
* Service unavailable
   > ```ts=2022-11-07T11:14:42.754Z caller=dedupe.go:112 component=remote level=warn remote_name=db8f73 url=https://monitoring.{{ api-host }}/workspaces/monb1piptmdo********/prometheus/api/v1/write msg="Failed to send batch, retrying" err="server returned HTTP status 503 Service Unavailable: {\"type\":\"UNAVAILABLE\",\"message\":\"Service Unavailable\",\"code\":503}"```

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

