# ycp_monitoring_channel_yachat (Resource)

Monitoring YaChat channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier

### Optional

- `content_template` (String) Notification content template
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `group` (String) Receiver group identifier
- `id` (String) The ID of this resource.
- `labels` (Map of String) Channel labels
- `login` (String) Receiver staff login
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_channel_yachat" "this" {
  channel_id                 = "channel-yachat"
  project_id                 = "alextrushkin_test"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  content_template           = "example.com"
  login = "alextrushkin"
}
```
