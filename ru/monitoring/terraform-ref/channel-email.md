# ycp_monitoring_channel_email (Resource)

Monitoring email channel

## Schema

### Required

- `channel_id` (String) Channel identifier, will be copied to id
- `name` (String) Channel name
- `project_id` (String) Project identifier

### Optional

- `abc_recipients` (Block List) Channel ABC services recipients (see [below for nested schema](#nestedblock--abc_recipients))
- `content_template` (String) Notification content template
- `default_for_alert_severity` (List of String) Channel is default for specified alert severities
- `id` (String) The ID of this resource.
- `labels` (Map of String) Channel labels
- `recipients` (List of String) Channel recipients emails
- `subject_template` (String) Notification subject template
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

<a id="nestedblock--abc_recipients"></a>
### Nested Schema for `abc_recipients`

Required:

- `abc_slug` (String) ABC service slug

Optional:

- `role_scope_slug` (String) ABC role scope slug


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_channel_email" "this" {
  channel_id                 = "channel-email-ds"
  project_id                 = "alextrushkin_test"
  name                       = "My channel"
  default_for_alert_severity = [
    "SEVERITY_DISASTER"
  ]
  labels = {
    label1 = "value1"
  }
  recipients = [
    "a@m.ru"
  ]
  subject_template = "Subject"
  content_template = "Content here"
}
```
