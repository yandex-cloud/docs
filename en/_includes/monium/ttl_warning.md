{% note warning %}

When choosing metrics for SLI calculation, consider [TTL](../../monium/concepts/ttl.md). The TTL metric value must not be smaller than the metric calculation window you select. Otherwise, the system may remove your metrics from the storage for not being delivered anymore.

{% endnote %}