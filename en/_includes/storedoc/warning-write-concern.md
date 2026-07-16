{% note warning %}

Queries with the `writeConcern: 1` setting may lead to lagging data on secondary replicas. This increases the risk of write timeouts and data loss if the master host fails. Therefore, the [SLA](https://yandex.com/legal/cloud_sla_mdb/en/) and [high availability](../../storedoc/concepts/high-availability.md) guarantees do not apply to such clusters. For more information on how `writeConcern` impacts high availability, see [here](../../storedoc/concepts/high-availability.md#connect).

{% endnote %}