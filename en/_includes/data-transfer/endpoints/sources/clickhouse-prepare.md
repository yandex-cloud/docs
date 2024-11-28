{% note info %}

{{ data-transfer-full-name }} cannot transfer a {{ CH }} database if its name contains a hyphen.


If transferring tables with engines other than `ReplicatedMergeTree` and `Distributed` in a {{ CH }} multi-host cluster, the transfer will fail with the following error: `the following tables have not Distributed or Replicated engines and are not yet supported`.

{% endnote %}

{% list tabs %}

* {{ mch-name }}

    1. Make sure the tables you are transferring use the `MergeTree` family engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will be transferred.

       In case of a multi-host cluster, only tables and materialized views with the `ReplicatedMergeTree` or `Distributed` engines will be transferred. Make sure these tables and views are present on all the cluster hosts.

    1. [Create a user](../../../../managed-clickhouse/operations/cluster-users.md) with access to the source database. In the user settings, specify a value of at least `1000000` for the **Max execution time** [parameter](../../../../managed-clickhouse/concepts/settings-list.md#setting-max-execution-time).

* {{ CH }}

    1. Make sure the tables you are transferring use the `MergeTree` family engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will be transferred.

       In case of a multi-host cluster, only tables and materialized views with the `ReplicatedMergeTree` or `Distributed` engines will be transferred. Make sure these tables and views are present on all the cluster hosts.

    1. {% include notitle [White IP list](../../configure-white-ip.md) %}

    1. [Configure access to the source cluster from {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).

    1. Create a user with access to the source database. In the user settings, specify a value of at least `1000000` for the **Max execution time** parameter.

{% endlist %}
