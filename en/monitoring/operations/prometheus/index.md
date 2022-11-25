# Connecting the Remote API

To enable {{ monitoring-name }} as [remote storage](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations) for {{ prometheus-name }}, set up metric [writes](remote-write.md) and [reads](remote-read.md) in {{ prometheus-name }} via the Remote API.

{% include [note-preview](../../../_includes/note-preview.md) %}

## Limits per endpoint {#limits-per-endpoint}

* 200 requests per second and 3 MB/s per write.
* 10000 metrics per request per write.
* 25 requests per second per read.
* 1 million unique metrics.
* 29 unique labels per metric.
* [Expired metrics](../../concepts/ttl.md) are deleted in 60 days.

## Restrictions {#restrictions}

* The `NaN` value is not supported and is treated as a missing point.
* The `+Inf`/`-Inf` value may be processed incorrectly.
* `Staleness markers` and `exemplars` are not supported.
