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
     - url: '<url>' # Provided on request
       bearer_token: '<api_key>'
       # Or via a file (recommended):
       # bearer_token_file: '<name of file with api_key>'

       # We recommend adding a user-defined X-Lookback-Delta header.
       # If you did not change the lookback-delta parameter value in the configuration
       # of your Prometheus instance, specify the default value, 5m.
       # This info is required for optimized decimation.
       headers:
         X-Lookback-Delta: 5m

       # By default, data is only requested for the time ranges
       # that are not present in the Prometheus local storage (are older than the Storage retention).
       # If you want to always request data, which makes sense if reads and writes
       # are made from different Prometheus instances, enable the option:
       # [ read_recent: true ]

       # If you want to only read some metrics via the Remote API, specify their labels:
       # required_matchers:
       # [ <labelname>: <labelvalue> ... ]
   ```
1. Restart {{ prometheus-name }} or reload the configuration.

## Error examples {#errors}

* Read request limit exceeded
   > ```remote_read: remote server https://monitoring.{{ api-host }}/workspaces/monb1piptmdo916sceer/prometheus/api/v1/read returned HTTP status 429 Too Many Requests: {"type":"RESOURCE_EXHAUSTED","message":"too many read requests: monb1piptmdo916sceer","code":429}```

## {{ prometheus-name }} metrics {#metrics}

| Metric name | Units | Explanations |
|----|----|----|
| `prometheus_remote_storage_read_queries_total` | Invocations | Total number of read requests |
| `prometheus_remote_storage_read_request_duration_seconds` | Seconds | Read request execution time histogram |

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
