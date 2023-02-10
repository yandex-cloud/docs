# ycp_monitoring_channel_telegram (Resource)

Monitoring sms channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier

### Optional

- `content_template` (String) Notification content template
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `group` (String) Receiver group title
- `id` (String) The ID of this resource.
- `labels` (Map of String) Channel labels
- `login` (String) Receiver staff login
- `send_screenshot` (Boolean) Send screenshots in messages
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_channel_telegram" "channel" {
  channel_id                 = "channel-telegram"
  project_id                 = "alextrushkin_test"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  login = "alextrushkin"
  content_template = "Content here"
}
```