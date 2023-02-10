# ycp_monitoring_channel_phone (Resource)

Monitoring phone channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier

### Optional

- `abc_slug` (String) Receiver duty ABC service slug
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `duty_slug` (String) Receiver duty slug
- `id` (String) The ID of this resource.
- `labels` (Map of String) Channel labels
- `login` (String) Receiver staff login
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
resource "ycp_monitoring_channel_phone" "channel" {
  project_id                 = "alextrushkin_test"
  channel_id                 = "channel1"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  login     = "alextrushkin"
}
```
