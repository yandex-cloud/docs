# ycp_monitoring_channel_webhook (Resource)

Monitoring webhook channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier
- `url` (String) Url that will be use to POST request, e.g.: https://myhost:8181/alert

### Optional

- `body_template` (String) Webhook body
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `headers` (Map of String) Webhook headers
- `id` (String) The ID of this resource.
- `labels` (Map of String) Channel labels
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_channel_webhook" "this" {
  channel_id                 = "channel-webhook-ds2"
  project_id                 = "alextrushkin_test"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  url           = "example.com"
  body_template = "body here"
  headers       = {
    content = "application/json"
  }
}
```