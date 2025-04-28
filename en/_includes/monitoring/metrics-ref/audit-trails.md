The `name` label contains the metric name.

Labels shared by all {{ at-name }} metrics:

| Label | Value |
| --- | --- |
service | Service ID: `audit-trails`
trail | [Trail](../../../audit-trails/concepts/trail.md) ID |
status | [Trail](../../../audit-trails/concepts/trail.md#status) status | |
event_type | Event type |
event_source | Event source service |
destination_type | [Destination object](../../../audit-trails/concepts/trail.md#target) |

Service metrics:

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
`trail.status`<br>`IGAUGE`, `ACTIVE`/`ERROR` | Current trail status.<br>You can use this metric to create an alert for a trail going inactive. |
`trail.processed_events_count`<br>`RATE`, events per second | Frequency of events received for processing from the audit log [collection scope](../../../audit-trails/concepts/trail.md#collecting-area) |
`trail.unauthorized_events_count`<br>`RATE`, events per second | Frequency of events with failed authorization.<br>You can use this metric to create an alert for attempts of unauthorized access to resources. |
`trail.delivered_events_count`<br>`RATE`, events per second | Frequency of events delivered to the destination object.<br>You can use this metric to create an alert for temporary suspension of audit log ingestion to the destination object, e.g., due to insufficient space in the bucket or revocation of the required role from the service account. |
`quota.trails_count.limit`<br>`IGAUGE`, count | Current cloud trail [quota](../../../audit-trails/concepts/limits.md) |
`quota.trails_count.usage`<br>`IGAUGE`, count | Current usage of the cloud trail quota. You can use this metric to create an [alert](../../../monitoring/concepts/alerting.md) for upcoming quota depletion. |