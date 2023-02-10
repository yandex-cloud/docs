# ycp_monitoring_threshold_alert (Resource)

Monitoring threshold alert

## Schema

### Required

- `alert_id` (String) Alert identifier, will be copied to id
- `name` (String) Alert name
- `predicate_rules` (Block List, Min: 1) Alert threshold predicate rules (see [below for nested schema](#nestedblock--predicate_rules))
- `project_id` (String) Project identifier
- `selector` (String) Alert selector
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

<a id="nestedblock--predicate_rules"></a>
### Nested Schema for `predicate_rules`

Required:

- `comparison` (String) Threshold comparison
- `target_status` (String) Threshold status
- `threshold` (Number) Threshold value
- `threshold_type` (String) Type


<a id="nestedblock--channels"></a>
### Nested Schema for `channels`

Required:

- `id` (String) Channel id

Optional:

- `notify_about_statuses` (List of String) Notify statuses
- `repeat_period_duration` (String) Channel repeat duration. Example: 5h0m30s


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_threshold_alert" "alerting_telegram_inflight_high" {
  description = <<EOT
1. Идем на дажборд https://solomon.yandex-team.ru/?project=solomon&cluster=production&service=alerting&dashboard=http-client-call&l.host=cluster&l.endpoint=api.telegram.org%2FsendMessage
2. Ищем машинки на которых постоянно растет inflight
3. Перезагружаем алертинг на данных машинках"
EOT
  alert_id    = "alerting_telegram_inflight_high"
  project_id  = "project_id_here"
  name        = "Alerting: Telegram inFlight too high"
  selector    = "{projectId='solomon', project='solomon', cluster='production', service='alerting', endpoint='api.telegram.org/send*', host='cluster', sensor='http.client.call.inFlight'}"
  predicate_rules {
    threshold_type = "AVG"
    comparison     = "GT"
    threshold      = 30
    target_status  = "ALARM"
  }
  window_duration  = "5m0s"
  no_points_policy = "NO_POINTS_NO_DATA"
  channels {
    id                    = ycp_monitoring_channel_telegram.alextrushkin-telegram.id
    notify_about_statuses = [
      "ALARM"
    ]
    repeat_period_duration = "10m0s"
  }
}
```
