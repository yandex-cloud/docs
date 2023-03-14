# ycp_monitoring_service_push (Resource)

Monitoring push service

## Schema

### Required

- `project_id` (String) Project identifier
- `service_id` (String) Service identifier, will be copied to id

### Optional

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
- `store_only_aggregates` (Boolean) If true Solomon will not store all fetched raw data. Only configured aggregates (see tab 'Aggregation rules') will be stored
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

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
resource "ycp_monitoring_service_push" "push1" {
  project_id         = "alextrushkin_test"
  service_id         = "push1"
  label_name         = "alerting"
  interval_duration  = "15s"
  grid_duration      = "60s"
  metrics_ttl_days   = 7
  metrics_name_label = "sensor"
  aggregation_rules {
    conditions = [
      "host=*"
    ]
    targets = [
      "host=cluster"
    ]
    function = "SUM"
  }
  aggregation_rules {
    conditions = [
      "host=*"
    ]
    targets = [
      "host=cluster1"
    ]
  }
  store_only_aggregates = true
}
```
