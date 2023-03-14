
# ycp_monitoring_channel_sms (Resource)

Monitoring sms channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier

### Optional

- `content_template` (String) Notification content template
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `id` (String) The ID of this resource.
- `labels` (Map of String) Channel labels
- `login` (String) Receiver staff login
- `phone` (String) Receiver phone number, example: +71234567890
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_channel_sms" "channel" {
  channel_id                 = "channel-sms"
  project_id                 = "alextrushkin_test"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  login            = "alextrushkin"
  content_template = "Content here"
}
```