# ycp_monitoring_escalation_policy (Resource)

Monitoring escalation policy

## Schema

### Required

- `name` (String) Escalation identifier, will be copied to id
- `project_id` (String) Project identifier
- `steps` (Block List, Min: 1) Escalation steps (see [below for nested schema](#nestedblock--steps))
- `title` (String) Channel title

### Optional

- `country` (String) Escalation country used for weekend/holiday calculation. Example: Russia
- `day_time_end` (String) Start iterations only before this time of day. Example: 10:30:00
- `day_time_start` (String) Start iterations only after this time of day. Example: 10:30:00
- `default_for_alert_severity` (List of String) Escalation is default for specified alert severities
- `id` (String) The ID of this resource.
- `initial_delay_duration` (String) Delay before start of the first iteration. Example: 5h0m30s
- `mute_on_absence` (Boolean) Don't send notifications when recipient is not working
- `mute_on_weekends` (Boolean) Don't start iteration when there's a weekend/holiday in escalation country
- `send_on_days` (List of Number) Start iterations only on these days, 0-6, 0 being Monday
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `timezone` (String) Escalation timezone. Example: Europe/Moscow
- `warden_config` (Block List) Escalation warden configuration (see [below for nested schema](#nestedblock--warden_config))

<a id="nestedblock--steps"></a>
### Nested Schema for `steps`

Optional:

- `email` (Block List) Escalation slack step (see [below for nested schema](#nestedblock--steps--email))
- `ignore_on_repeat` (Boolean) Whether this step should be ignored when we restart escalation
- `phone` (Block List) Escalation slack step (see [below for nested schema](#nestedblock--steps--phone))
- `slack` (Block List) Escalation slack step (see [below for nested schema](#nestedblock--steps--slack))
- `sms` (Block List) Escalation sms step (see [below for nested schema](#nestedblock--steps--sms))
- `telegram` (Block List) Escalation sms step (see [below for nested schema](#nestedblock--steps--telegram))
- `tracker` (Block List) Escalation slack step (see [below for nested schema](#nestedblock--steps--tracker))
- `wait_after_duration` (String) Delay before the next step. Can be ignored if current step resulted in error (e.g. the recipient didn't answer the call). Example: 5h0m30s
- `webhook` (Block List) Escalation slack step (see [below for nested schema](#nestedblock--steps--webhook))
- `yachat` (Block List) Escalation yachat step (see [below for nested schema](#nestedblock--steps--yachat))

<a id="nestedblock--steps--email"></a>
### Nested Schema for `steps.email`

Optional:

- `email` (List of String) Generic mailing list
- `recipients` (Block List) Target a particular staff user, or a group of user (see [below for nested schema](#nestedblock--steps--email--recipients))

<a id="nestedblock--steps--email--recipients"></a>
### Nested Schema for `steps.email.recipients`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--email--recipients--abc_duty))
- `abc_owner` (String) Send to a person with owner role (golden crown) in a service - slug without svc_ prefix
- `abc_role` (String) A particular role in a service, like "juggler_administration"
- `abc_service` (String) All people in a service (in all roles) - slug without the svc_ prefix, like "juggler"
- `login` (String) Login of a known staff user, like "reimu"
- `staff_group` (String) Send to a staff group, like "yandex_mnt_sa_runtime_mondev". It also includes all children groups, so sending to "yandex" will try (and fail) to send to every yandex employee, not just 3 people shown on staff

<a id="nestedblock--steps--email--recipients--abc_duty"></a>
### Nested Schema for `steps.email.recipients.staff_group`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both




<a id="nestedblock--steps--phone"></a>
### Nested Schema for `steps.phone`

Optional:

- `recipients` (Block List) Target a particular staff user, or a group of user (see [below for nested schema](#nestedblock--steps--phone--recipients))

<a id="nestedblock--steps--phone--recipients"></a>
### Nested Schema for `steps.phone.recipients`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--phone--recipients--abc_duty))
- `abc_owner` (String) Send to a person with owner role (golden crown) in a service - slug without svc_ prefix
- `abc_role` (String) A particular role in a service, like "juggler_administration"
- `abc_service` (String) All people in a service (in all roles) - slug without the svc_ prefix, like "juggler"
- `login` (String) Login of a known staff user, like "reimu"
- `staff_group` (String) Send to a staff group, like "yandex_mnt_sa_runtime_mondev". It also includes all children groups, so sending to "yandex" will try (and fail) to send to every yandex employee, not just 3 people shown on staff

<a id="nestedblock--steps--phone--recipients--abc_duty"></a>
### Nested Schema for `steps.phone.recipients.staff_group`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both




<a id="nestedblock--steps--slack"></a>
### Nested Schema for `steps.slack`

Optional:

- `chat_id` (List of String) Send to a chat_id (string like "C012TEW2O4H")
- `recipients` (Block List) Target a particular staff user, or a group of user (see [below for nested schema](#nestedblock--steps--slack--recipients))

<a id="nestedblock--steps--slack--recipients"></a>
### Nested Schema for `steps.slack.recipients`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--slack--recipients--abc_duty))
- `abc_owner` (String) Send to a person with owner role (golden crown) in a service - slug without svc_ prefix
- `abc_role` (String) A particular role in a service, like "juggler_administration"
- `abc_service` (String) All people in a service (in all roles) - slug without the svc_ prefix, like "juggler"
- `login` (String) Login of a known staff user, like "reimu"
- `staff_group` (String) Send to a staff group, like "yandex_mnt_sa_runtime_mondev". It also includes all children groups, so sending to "yandex" will try (and fail) to send to every yandex employee, not just 3 people shown on staff

<a id="nestedblock--steps--slack--recipients--abc_duty"></a>
### Nested Schema for `steps.slack.recipients.staff_group`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both




<a id="nestedblock--steps--sms"></a>
### Nested Schema for `steps.sms`

Optional:

- `recipients` (Block List) Recipient (see [below for nested schema](#nestedblock--steps--sms--recipients))

<a id="nestedblock--steps--sms--recipients"></a>
### Nested Schema for `steps.sms.recipients`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--sms--recipients--abc_duty))
- `abc_owner` (String) Send to a person with owner role (golden crown) in a service - slug without svc_ prefix
- `abc_role` (String) A particular role in a service, like "juggler_administration"
- `abc_service` (String) All people in a service (in all roles) - slug without the svc_ prefix, like "juggler"
- `login` (String) Login of a known staff user, like "reimu"
- `staff_group` (String) Send to a staff group, like "yandex_mnt_sa_runtime_mondev". It also includes all children groups, so sending to "yandex" will try (and fail) to send to every yandex employee, not just 3 people shown on staff

<a id="nestedblock--steps--sms--recipients--abc_duty"></a>
### Nested Schema for `steps.sms.recipients.staff_group`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both




<a id="nestedblock--steps--telegram"></a>
### Nested Schema for `steps.telegram`

Optional:

- `chat_id` (List of Number) Target a chat by id. Can be used in /messages/send, not in channels or escalation policies
- `chat_name` (List of String) Target a group chat in sender project (deprecated)
- `project_chat` (List of String) Target a project group chat
- `recipients` (Block List) Target a particular staff user, or a group of user (see [below for nested schema](#nestedblock--steps--telegram--recipients))

<a id="nestedblock--steps--telegram--recipients"></a>
### Nested Schema for `steps.telegram.recipients`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--telegram--recipients--abc_duty))
- `abc_owner` (String) Send to a person with owner role (golden crown) in a service - slug without svc_ prefix
- `abc_role` (String) A particular role in a service, like "juggler_administration"
- `abc_service` (String) All people in a service (in all roles) - slug without the svc_ prefix, like "juggler"
- `login` (String) Login of a known staff user, like "reimu"
- `staff_group` (String) Send to a staff group, like "yandex_mnt_sa_runtime_mondev". It also includes all children groups, so sending to "yandex" will try (and fail) to send to every yandex employee, not just 3 people shown on staff

<a id="nestedblock--steps--telegram--recipients--abc_duty"></a>
### Nested Schema for `steps.telegram.recipients.staff_group`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both




<a id="nestedblock--steps--tracker"></a>
### Nested Schema for `steps.tracker`

Required:

- `queue` (String) Tracker queue

Optional:

- `assignee` (Block List) Assigne that will be set when the ticket is created, up to 10 (see [below for nested schema](#nestedblock--steps--tracker--assignee))
- `components` (List of String) Components that will be added to the ticket when it's created, up to 10
- `followers` (Block List) Additional followers that will be added to the ticket when it's created, up to 10 (see [below for nested schema](#nestedblock--steps--tracker--followers))
- `priority` (String) Ticket priority (must exist in the queue)

<a id="nestedblock--steps--tracker--assignee"></a>
### Nested Schema for `steps.tracker.assignee`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--tracker--assignee--abc_duty))
- `login` (String) Login of a known staff user, like "reimu"

<a id="nestedblock--steps--tracker--assignee--abc_duty"></a>
### Nested Schema for `steps.tracker.assignee.login`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both



<a id="nestedblock--steps--tracker--followers"></a>
### Nested Schema for `steps.tracker.followers`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--tracker--followers--abc_duty))
- `login` (String) Login of a known staff user, like "reimu"

<a id="nestedblock--steps--tracker--followers--abc_duty"></a>
### Nested Schema for `steps.tracker.followers.login`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both




<a id="nestedblock--steps--webhook"></a>
### Nested Schema for `steps.webhook`

Optional:

- `url` (String) Webhook URL


<a id="nestedblock--steps--yachat"></a>
### Nested Schema for `steps.yachat`

Optional:

- `chat_name` (List of String) Target a group chat
- `recipients` (Block List) Target a particular staff user, or a group of user (see [below for nested schema](#nestedblock--steps--yachat--recipients))

<a id="nestedblock--steps--yachat--recipients"></a>
### Nested Schema for `steps.yachat.recipients`

Optional:

- `abc_duty` (Block List) Send to a person currently on duty (see [below for nested schema](#nestedblock--steps--yachat--recipients--abc_duty))
- `abc_owner` (String) Send to a person with owner role (golden crown) in a service - slug without svc_ prefix
- `abc_role` (String) A particular role in a service, like "juggler_administration"
- `abc_service` (String) All people in a service (in all roles) - slug without the svc_ prefix, like "juggler"
- `login` (String) Login of a known staff user, like "reimu"
- `staff_group` (String) Send to a staff group, like "yandex_mnt_sa_runtime_mondev". It also includes all children groups, so sending to "yandex" will try (and fail) to send to every yandex employee, not just 3 people shown on staff

<a id="nestedblock--steps--yachat--recipients--abc_duty"></a>
### Nested Schema for `steps.yachat.recipients.staff_group`

Required:

- `service` (String) slug of the service without the "svc_" prefix, like "juggler"
- `slug` (String) schedule slug, like "main_duty"

Optional:

- `kind` (String) duty kind, Primary/Backup/Both





<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)


<a id="nestedblock--warden_config"></a>
### Nested Schema for `warden_config`

Required:

- `component` (String) Warden component

Optional:

- `create_spi` (Boolean) Create SPI at escalation start
- `functionality` (String) Warden functionality
- `start_flow` (Boolean) Create flow at escalation start

## Example
```
resource "ycp_monitoring_escalation_policy" "test" {
  project_id             = "alextrushkin_test"
  name                   = "test_tf"
  title                  = "Title"
  initial_delay_duration = "5m"
  mute_on_absence        = true
  mute_on_weekends       = true
  timezone               = "Europe/Moscow"
  country                = "RU"
  send_on_days           = [
    0, 1
  ]
  day_time_start             = "10:22:11"
  day_time_end               = "11:32:51"
  default_for_alert_severity = [
    "SEVERITY_CRITICAL"
  ]
  steps {
    wait_after_duration = "3m2s"
    ignore_on_repeat    = false
    sms {
      recipients {
        abc_duty {
          service = "solomon"
          slug    = "alextrushkin-test"
          kind    = "Both"
        }
      }
      recipients {
        login = "alextrushkin"
      }
    }
  }
}
```
