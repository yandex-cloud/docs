* If background mode is disabled (`false`), the redistribution process will be run once as soon as the cluster expansion preparation is over.

    {% include [updating-long](./updating-long.md) %}

    {% note warning %}

    {% include [manual-redistribution](./manual-redistribution.md) %}

    {% endnote %}

* If background mode is enabled (`true`), the redistribution process will be delayed. The process will run on a schedule as a [routine maintenance operation](../../../../managed-greenplum/concepts/maintenance.md#regular-ops).

    {% include [updating-short](./updating-short.md) %}
