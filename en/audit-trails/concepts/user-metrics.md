# Custom {{ at-full-name }} metrics

{% if audience == "external" %}

You can track the status of [trails](./trail.md) using [{{ monitoring-full-name }}](../../monitoring/concepts/index.md), a service for collecting and storing {{ yandex-cloud }} resource metrics.

## {{ at-name }} metrics {#metrics}

| Metric name | Description | Labels |
--- | --- | ---
| `trail.status` | Current trail [status](./trail.md#status). You can use the metric to create an alert for a trail transitioning to an inactive state | trail, status |
| `trail.processed_events_count` | Frequency of events received for processing from audit log [collection scope](./trail.md#collecting-area) | trail, event_type, event_source |
| `trail.unauthorized_events_count` | Frequency of failed authorization events. You can use the metric to create an alert for attempts of unauthorized access to resources | trail, event_type, event_source |
| `trail.delivered_events_count` | Frequency of events delivered to the [destination object](./trail.md#target). You can use the metric to create an alert that the upload of audit logs to the destination object is suspended because there is no free space in a bucket, for instance, or because a required role has been revoked from a service account | trail, event_type, event_source, destination_type |
| `quota.trails_count.limit` | Current trail [quota](./limits.md) per cloud | — |
| `quota.trails_count.usage` | Current usage of the trail quota per cloud. You can use the metric to create an [alert](../../monitoring/concepts/alerting.md) that the quota is about to be reached | — |

## Labels {#label}

| Label name | Description |
--- | --- 
| `trail` | Trail ID |
| `status` | Trail status |
| `event_type` | Event type |
| `event_source` | Event source service |
| `destination_type` | Destination object |

## What's next {#whats-next}

* Review the {{ at-name }} [alert settings](../tutorials/alerts-monitoring.md) in {{ monitoring-full-name }}.

{% endif %}