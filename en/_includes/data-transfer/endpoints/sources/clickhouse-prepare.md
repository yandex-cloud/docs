{% list tabs %}

- {{ mch-name }}

   1. Make sure the tables being transferred use the `MergeTree` engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will get transferred.
   1. [Create a user](../../../../managed-clickhouse/operations/cluster-users.md) with access to the source database. In the user settings, specify a value of at least `1000000` for the **Max execution time** [parameter](../../../mdb/mch-dbms-user-settings.md#setting-max-execution-time).

- {{ CH }}

   1. Make sure the tables being transferred use the `MergeTree` engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will get transferred.
   1. {% include notitle [White IP list](../../configure-white-ip.md) %}

   1. [Configure access to the source cluster from {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).

   1. Create a user with access to the source database. In the user settings, specify a value of at least `1000000` for the **Max execution time** parameter.

{% endlist %}