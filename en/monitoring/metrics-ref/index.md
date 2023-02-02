---
editable: false
---

# Metric reference

This section describes the {{ yandex-cloud }} service metrics that are automatically collected in {{ monitoring-full-name }}.

The name of the metric is written in the `name` label.

{% include [compute.md](../../_includes/monitoring/metrics-ref/compute.md) %}

{% if product == "yandex-cloud" %}

{% include [data-proc.md](../../_includes/monitoring/metrics-ref/data-proc.md) %}

{% include [managed-clickhouse.md](../../_includes/monitoring/metrics-ref/managed-clickhouse.md) %}

{% endif %}

{% include [managed-elasticsearch.md](../../_includes/monitoring/metrics-ref/managed-elasticsearch.md) %}

{% include [managed-greenplum.md](../../_includes/monitoring/metrics-ref/managed-greenplum.md) %}

{% if product == "yandex-cloud" %}

{% include [managed-kafka.md](../../_includes/monitoring/metrics-ref/managed-kafka.md) %}

{% endif %}

{% include [managed-mongodb.md](../../_includes/monitoring/metrics-ref/managed-mongodb.md) %}

{% if product == "yandex-cloud" %}

{% include [managed-mysql.md](../../_includes/monitoring/metrics-ref/managed-mysql.md) %}

{% include [managed-opensearch.md](../../_includes/monitoring/metrics-ref/managed-opensearch.md) %}

{% include [managed-postgresql.md](../../_includes/monitoring/metrics-ref/managed-postgresql.md) %}

{% include [managed-redis.md](../../_includes/monitoring/metrics-ref/managed-redis.md) %}

{% include [ydb.md](../../_includes/monitoring/metrics-ref/ydb.md) %}

{% endif %}

{% include [compute.md](../../_includes/monitoring/metrics-ref/monitoring.md) %}
