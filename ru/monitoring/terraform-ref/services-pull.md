# ycp_monitoring_service_pull (Resource)

Monitoring pull service

## Schema

### Required

- `path` (String) URL on which your application exposes metrics via HTTP
- `port` (Number) Port which Solomon should use to fetch metrics from your application. Value of this field will override port number defined in service config
- `project_id` (String) Project identifier
- `service_id` (String) Service identifier, will be copied to id

### Optional

- `add_ts_args` (Boolean) If true Solomon will add 'now' (e.g. '2017-06-11T00:45:45.542Z') and 'period' (e.g. '1d2h3m4s') query parameter into fetch request
- `aggregation_rules` (Block List) Aggregates configured in next form: MATCH_CONDITION -> LABELS_EXPRESSION. Match condition and labels expression are list of labels (written in "key=value" format) separated by comma (,) (see [below for nested schema](#nestedblock--aggregation_rules))
- `grid_duration` (String) Defines data granularity, must be multiple of 5m. Can be different from fetch interval, in cases when fetch\push multiple points by one time Default value equal to Interval. You can leave this field empty to use default value
- `id` (String) The ID of this resource.
- `interval_duration` (String) Defines delay in seconds which Solomon will wait after fetching metrics data from your application and before performing new fetch request. Default value is 15 seconds. You can leave this field empty to use default value
- `label_name` (String) Service name
- `labels` (Map of String) Service labels
- `metrics_name_label` (String) Required metric name label for service metrics.
  It's neccessary to convert sensor=<metric_name>, label1="value1", label2="value2" to <metric_name>{label1="value1", label2="value2"} format.
  This label must be required in pull/push data and existing metrics
- `metrics_ttl_days` (Number) If this field is filled, Solomon will drop all metrics where last point was metrics TTL days ago
- `protocol` (String) Protocol which will be used by Solomon to fetch metrics from your application (HTTP/HTTPS)
- `store_only_aggregates` (Boolean) If true Solomon will not store all fetched raw data. Only configured aggregates (see tab 'Aggregation rules') will be stored
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `tvm_destination_id` (String) TVM client id of your application that Solomon will contact to download metrics from

### Nested Schema for `aggregation_rules` {#nestedblock--aggregation_rules}

Required:

- `conditions` (List of String) Labels match condition
- `targets` (List of String) Labels targets

Optional:

- `function` (String) Aggregation function (SUM/LAST)


### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_service_pull" "solomon_alerting" {
  project_id = "project_id_here"
  service_id = "solomon_alerting"
  label_name = "alerting"
  port       = 4530
  path       = "/metrics"
  aggregation_rules {
    conditions = [
      "host=*"
    ]
    targets = [
      "host=cluster"
    ]
  }
  aggregation_rules {
    conditions = [
      "target=*"
    ]
    targets = [
      "target=cluster"
    ]
  }
  aggregation_rules {
    conditions = [
      "target=*",
      "host=*"
    ]
    targets = [
      "target=total",
      "host=cluster"
    ]
  }
  aggregation_rules {
    conditions = [
      "host=*"
    ]
    targets = [
      "host=not_var{{DC}}"
    ]
  }
  aggregation_rules {
    conditions = [
      "target=*",
      "host=*"
    ]
    targets = [
      "target=total",
      "host=not_var{{DC}}"
    ]
  }
  metrics_ttl_days   = 1
  metrics_name_label = "sensor"
}
```
