The name of the metric is written in the `name` label.

Common labels for all {{ at-name }} metrics:

| Label | Value |
| --- | --- |
| service | Service ID: `audit-trails` |
| trail | [Trail](../../../audit-trails/concepts/trail.md) ID |
| status | [Trail](../../../audit-trails/concepts/trail.md#status) status |
| event_type | Event type |
| event_source | Event source service |
| destination_type | [Destination object](../../../audit-trails/concepts/trail.md#target) |

Service metrics:

| Metric name<br>Type, units of measurement | Description<br>Labels |
| --- | --- |
| `trail.status`<br>`IGAUGE`, `ACTIVE`/`ERROR` | Current trail status.<br>You can use this metric to create an alert for a trail going inactive. |
| `trail.processed_events_count`<br>`RATE`, events per second | Frequency of events received for processing from the audit log [collection scope](../../../audit-trails/concepts/trail.md#collecting-area) |
| `trail.unauthorized_events_count`<br>`RATE`, events per second | Frequency of events with failed authorization.<br>You can use this metric to create an alert for attempts of unauthorized access to resources. |
| `trail.delivered_events_count`<br>`RATE`, events per second | Frequency of events delivered to the destination object.<br>You can use this metric to create an alert signaling the suspension of the audit log upload to the destination object, e.g., due to a lack of free storage space in a bucket or due to a required role being revoked from a service account. |
| `quota.trails_count.limit`<br>`IGAUGE`, number | Current trail [quota](../../../audit-trails/concepts/limits.md) per cloud |
| `quota.trails_count.usage`<br>`IGAUGE`, number | Current usage of the trail quota per cloud. You can use this metric to create an [alert](../../../monitoring/concepts/alerting.md) signaling the upcoming quota depletion. |