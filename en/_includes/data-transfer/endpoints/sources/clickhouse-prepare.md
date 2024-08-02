{% note info %}

{{ data-transfer-full-name }} cannot transfer a {{ CH }} database if its name contains a hyphen.

If the {{ CH }} source tables contain columns of the following types, the transfer will fail.

{% cut "List of unsupported types" %}

| Type | Error example |
|---------------------|-------------------------------------------------------------------|
| `Int128` | `unhandled type Int128` |
| `Int256` | `unhandled type Int256` |
| `UInt128` | `unhandled type UInt128` |
| `UInt256` | `unhandled type UInt256` |
| `Bool` | `unhandled type Bool` |
| `Date32` | `unhandled type Date32` |
| `JSON` | `unhandled type '<field_name> <type_name>'` |
| `Array(Date)` | `Can't transfer type 'Array(Date)', column '<column_name>'` |
| `Array(DateTime)` | `Can't transfer type 'Array(DateTime)', column '<column_name>'` |
| `Array(DateTime64)` | `Can't transfer type 'Array(DateTime64)', column '<column_name>'` |
| `Map(,)` | `unhandled type Map(<type_name>, <type_name>)` |

{% endcut %}

If transferring tables tables with engines other than `ReplicatedMergeTree` and `Distributed` in a {{ CH }} multi-host cluster, the transfer will fail with the following error: `the following tables have not Distributed or Replicated engines and are not yet supported`.

{% endnote %}

{% list tabs %}

* {{ mch-name }}

   1. Make sure the tables you are transferring use the `MergeTree` engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will be transferred.

      In case of a multi-host cluster, only tables and materialized views with the `ReplicatedMergeTree` or `Distributed` engines will be transferred. Make sure these tables and views are present on all the cluster hosts.

   1. [Create a user](../../../../managed-clickhouse/operations/cluster-users.md) with access to the source database. In the user settings, specify a value of at least `1000000` for the **Max execution time** [parameter](../../../mdb/mch-dbms-user-settings.md#setting-max-execution-time).

* {{ CH }}

   1. Make sure the tables you are transferring use the `MergeTree` engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will be transferred.

      In case of a multi-host cluster, only tables and materialized views with the `ReplicatedMergeTree` or `Distributed` engines will be transferred. Make sure these tables and views are present on all the cluster hosts.

   1. {% include notitle [White IP list](../../configure-white-ip.md) %}

   1. [Configure access to the source cluster from {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).

   1. Create a user with access to the source database. In the user settings, specify a value of at least `1000000` for the **Max execution time** parameter.

{% endlist %}
