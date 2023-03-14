# ycp_monitoring_expression_alert (Resource)

Monitoring expression alert

## Schema

### Required

- `alert_id` (String) Alert identifier, will be copied to id
- `name` (String) Alert name
- `program` (String) Alert expression program
- `project_id` (String) Project identifier
- `window_duration` (String) Alert evaluation window. Example: 5h0m30s

### Optional

- `annotations` (Map of String) Alert annotations
- `channels` (Block List) Alert channels (see [below for nested schema](#nestedblock--channels))
- `delay_duration` (String) Alert evaluation delay. Example: 5h0m30s
- `description` (String) Alert description
- `escalations` (List of String) Alert escalations
- `group_by_labels` (List of String) Alert group by
- `id` (String) The ID of this resource.
- `labels` (Map of String) Alert labels
- `no_metrics_policy` (String) Alert no metrics policy. Default value is RESOLVED_EMPTY_DEFAULT
- `no_points_policy` (String) Alert no points policy. Default value is NO_POINTS_DEFAULT
- `severity` (String) Alert severity. Default value is SEVERITY_UNSPECIFIED
- `status` (String) Alert status. Default value is ACTIVE
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `channels` {#nestedblock--channels}

Required:

- `id` (String) Channel id

Optional:

- `notify_about_statuses` (List of String) Notify statuses
- `repeat_period_duration` (String) Channel repeat duration. Example: 5h0m30s


### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_expression_alert" "alerting-cluster-membership" {
  description = <<EOT
https://wiki.yandex-team.ru/solomon/dev/runbooks#alerting-cluster-membership

Нет описания, что делать, если алерт сработал? Спроси создавшего этот алерт и заполни runbook самостоятельно!
EOT
  project_id  = "project_id_here"
  alert_id    = "alerting-cluster-membership"
  name        = "Alerting: Cluster membership"
  channels {
    id                    = ycp_monitoring_channel_telegram.alextrushkin-telegram.id
    notify_about_statuses = [
      "ALARM"
    ]
    repeat_period_duration = "10m0s"
  }
  program         = <<EOT
let data = {project='solomon', cluster='production', service='alerting', host='cluster', sensor='health.cluster.membership'};
let now = drop_head(data, 1d);
let nowValue = last(now);
let prevValue = max(data);
let data = '';
let prev = now * 0 + prevValue;
let nowValueStr = to_fixed(nowValue, 0);
let prevValueStr = to_fixed(prevValue, 0);
alarm_if(nowValue < prevValue);
EOT
  window_duration = "10m0s"
  delay_duration  = "10s"
  annotations     = {
    details = "See https://solomon.yandex-team.ru/?cluster=production&project=solomon&dashboard=alerting-projects-assignment-summary-dashboard&b=not_var{{fromTime}}&e=not_var{{toTime}}"
    state   = "not_var{{expression.nowValueStr}}/not_var{{expression.prevValueStr}}"
  }
}
```
