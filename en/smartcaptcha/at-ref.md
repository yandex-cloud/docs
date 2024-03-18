# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management (control plane) events for {{ captcha-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.smartcaptcha.<event_name>
```

{% include [captcha-events](../_includes/audit-trails/events/captcha-events.md) %}
