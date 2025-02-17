# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ cloud-apps-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.cloudapps.<event_name>
```

{% include [cloud-apps-events](../_includes/audit-trails/events/cloud-apps-events.md) %}