# ycp_monitoring_channel_juggler (Resource)

Monitoring juggler channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier

### Optional

- `content_template` (String) Notification content template
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `description` (String) Juggler content description
- `host` (String) Juggler host described by mustache template, by default solomon-alert
- `id` (String) The ID of this resource.
- `instance` (String) Juggler instance described by mustache template. Leave empty unless you are absolutely sure you need it
- `labels` (Map of String) Channel labels
- `service` (String) Juggler service described by mustache template, by default alert.id
- `tags` (List of String) Juggler tags
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_channel_juggler" "channel" {
  channel_id                 = "channel-juggler"
  project_id                 = "alextrushkin_test"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  host        = "host"
  service     = "service"
  instance    = "instance"
  description = "description"
  tags        = [
    "tag1",
    "tag12"
  ]
}
```
